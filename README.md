jmesnil.net
===========

Source of http://jmesnil.net/

Based on [Awestruct](http://awestruct.org/) to generate static content

# Run in docker

Use the `docker.sh` script to run the weblog in a Docker container.

# Rake tasks

* `rake dev` - Run in developer mode available on http://${DOCKER_HOST}:4242/
* `rake post:new title="foo" link="bar" - Create a new post in weblog/. If `link` is defined, create a link post.
* `rake rebuild` - Force a regeneration
* `rake staging` - Build the site and deploy to S3 for staging
* `rake production` - Build the site and deploy to S3 for production
