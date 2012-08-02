require 'rubygems'
require 'bundler/setup'
require 'time'

CONFIG = {
  'posts' => 'weblog/',
  'post_ext' => 'md',
  's3_url' => 's3://www.jmesnil.net/'
}

task :default => :build

desc "Run in developer mode"
task :dev => :check do
  system "awestruct --dev"
end

desc "Build the site"
task :build => :check do
  system "awestruct -P production --force"
end

desc "Build the site and publish to S3"
task :s3 => :build do
  system "s3cmd sync _site/ #{CONFIG['s3_url']}"
end
 
task :check do
  Dir.mkdir('_tmp') unless Dir.exist?('_tmp')
end

#Load custom rake scripts
Dir['_rake/*.rake'].each { |r| load r }
