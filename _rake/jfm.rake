require 'fileutils'

namespace :jfm do

  desc "Publish weblog to Amazon S3"
  task :publish do
    system "jekyll --safe && s3cmd sync _site/ s3://www.jmesnil.net/weblog/ && s3cmd sync _site/sitemap.txt s3://www.jmesnil.net/"
  end

  # Usage: rake jfm:draft title="A Title" [date="2012-02-09"]
  desc "Begin a new draft in #{CONFIG['drafts']}"
  task :draft do
    abort("rake aborted: '#{CONFIG['drafts']}' directory not found.") unless FileTest.directory?(CONFIG['drafts'])
    title = ENV["title"] || "new-post"
    slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    begin
      date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d')
      datetime = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d %H:%M:%S')
    rescue Exception => e
      puts "Error - date format must be YYYY-MM-DD, please check you typed it correctly!"
      exit -1
    end
    filename = File.join(CONFIG['drafts'], "#{date}-#{slug}.#{CONFIG['post_ext']}")
    if File.exist?(filename)
      abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
    end
    puts "Creating new draft: #{filename}"
    open(filename, 'w') do |post|
      post.puts "---"
      post.puts "layout: post"
      post.puts "title: \"#{title.gsub(/-/,' ')}\""
      post.puts "date: '#{datetime}'"
      post.puts "category: "
      post.puts "tags: []"
      post.puts "---"
    end
    ln filename, "_posts/"
  end

  # Usage: rake jfm:undraft
  desc "Undraft a draft"
  task :undraft do
      puts "Choose file:"
      @files = Dir["_drafts/*"]
      @files.each_with_index { |f,i| puts "#{i+1}: #{f}" }
      print "> "
      num = STDIN.gets
      file = @files[num.to_i - 1]
      now = Date.today.strftime("%Y-%m-%d").gsub(/-0/,'-')
      rm "_posts/" + File.basename(file)
      mv file, "_posts/"
  end

end
