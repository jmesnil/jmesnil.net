require 'fileutils'
require 'RMagick'

include Magick

namespace :image do

  # Usage: rake image:upload file="path/to/local/file"
  desc "Upload an image to Amazon S3 (passed with file=/path/to/local/file)"
  task :upload do
    filepath = ENV['file']
    abort("rake aborted: '#{filepath}' file not found.") unless FileTest.file?(filepath)
    system "s3cmd put #{filepath} #{CONFIG['s3_url']}images/"
    puts "DONE"
  end # task :upload

  # Usage: rake image:thumb file="path/to/local/file"
  desc "Create a 320x320 thumbnail of an image (passed with file=/path/to/local/file-1800w.jpg)"
  task :thumb do
    filepath = ENV['file']
    abort("rake aborted: '#{filepath}' file not found.") unless FileTest.file?(filepath)

    parent =  File.dirname filepath
    basename =  File.basename filepath, "-1800ww.jpg"
    thumb_filefilename = "#{parent}/#{basename}-thumb.jpg"

    img = ImageList.new filepath
    thumb = img.resize_to_fill(320, 320)
    thumb.write thumb_filefilename
    puts "generated #{thumb_filefilename}"
  end

  # Usage: rake image:thumbs dir="path/to/local/dir"
  desc "Create 320x320s of all images (passed with dir=/path/to/local/dir)"
  task :thumbs do
    dirpath = ENV['dir']
    abort("rake aborted: '#{dirpath}' dirpath not found.") unless FileTest.directory?(dirpath)
    puts dirpath

    Dir.glob("#{dirpath}/*-1800w.jpg").each { |f|
      puts f
      basename =  File.basename f, "-1800w.jpg"
      thumb_filefilename = "#{dirpath}/#{basename}-thumb.png"

      img = ImageList.new f
      img.background_color = "none"
      thumb = img.resize_to_fit(320, 320)
      x = (320 - thumb.columns) / 2
      y = (320 - thumb.rows) / 2
      thumb = thumb.extent(320, 320, -x, -y)
      thumb.write thumb_filefilename
      puts "generated #{thumb_filefilename}"
    }
  end
end
