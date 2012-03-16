namespace :s3 do
  
  desc "Publish weblog to Amazon S3"
  task :publish do
    system "jekyll --safe && s3cmd sync _site/ s3://www.jmesnil.net/weblog/ && s3cmd sync _site/sitemap.txt s3://www.jmesnil.net/"
  end
end
