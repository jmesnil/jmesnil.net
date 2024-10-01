jmesnil.net
===========

Source of http://jmesnil.net/

Based on [Awestruct](http://awestruct.org/) to generate static content

# Run in a container

Use the `container.sh` script to run the weblog in a container.

# Rake tasks

* `rake dev` - Run in developer mode available on `http://localhost:4242/`
* `rake post:new title="foo" link="bar"` - Create a new post in weblog/. If `link` is defined, create a link post.
* `rake image:upload` - Upload an image to Amazon S3 media bucket (passed with file=/path/to/local/file)
* `rake rebuild` - Force a regeneration
* `rake staging` - Build the site and deploy to S3 for staging
* `rake production` - Build the site and deploy to S3 for production
