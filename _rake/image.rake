require 'fileutils'

namespace :image do

  # Usage: rake image:upload file="path/to/local/file"
  desc "Upload an image to Amazon S3 (passed with file=/path/to/local/file)"
  task :upload do
    filepath = ENV['file']
    abort("rake aborted: '#{filepath}' file not found.") unless FileTest.file?(filepath)
    system "s3cmd put #{filepath} #{CONFIG['s3_url']}images/"
    puts "DONE"
  end # task :upload
end
