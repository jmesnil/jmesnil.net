namespace :s3 do
  
  desc "Publish weblog to Amazon S3"
  task :publish do
    system "jekyll --safe && s3cmd sync _site/ s3://www.jmesnil.net/weblog/"
  end
end
