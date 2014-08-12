require 'rubygems'
require 'bundler/setup'
require 'time'

CONFIG = {
  'posts' => 'weblog/',
  'post_ext' => 'md'
}

task :default => :dev

desc "Run in developer mode"
task :dev => :check do
  system "awestruct --dev"
end

desc "Force a regeneration"
task :rebuild do
  system "awestruct --force"
end

desc "Build the site and deploy to S3"
task :production => :rebuild do
  system "awestruct -P production --deploy"
end

desc "Build the site and deploy to S3 staging"
task :staging => :rebuild do
  system "awestruct -P staging --deploy"
end
 
task :check do
  Dir.mkdir('_tmp') unless Dir.exist?('_tmp')
end

#Load custom rake scripts
Dir['_rake/*.rake'].each { |r| load r }
