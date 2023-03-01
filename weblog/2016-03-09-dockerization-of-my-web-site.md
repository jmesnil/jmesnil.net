---
layout: post
title: "Dockerization of My Web Site"
date: '2016-03-09 20:18:59'
category:
tags:
- docker
---

This web site is composed of static files generated by [Awestruct][awestruct].
I have extended the basic Awestruct project to provide some additional features (link posts, article templates, photo thumbnails, etc.)
Unfortunately, some of these extensions uses Rubygems that depends on native libraries or uglier spaghetti dependencies.

I recently wanted to write an article but was unable to generate the web site because some Rubygems where no longer working with native libraries on my Mac. Using [bundler][bundler] to keep the gems relative to this project does not solve the issue of the native libraries that are upgraded either the OS or package system (such as [Homebrew][brew]).

This was the perfect opportunity to play with [Docker][docker] to create an image that I could use to generate the web site independantly of my OS.

I create this [jmesnil/jmesnil.net image][hub] by starting from the [vanilla awestruct image][marek] created by my colleague, Marek. I tweaked it because he was only installing the Awestruct gem from the `Dockerfile` while I have a lot of other gems to install for my extensions.

I prefer to keep the gems listed in the `Gemfile` so that the project can also work outside of Docker so I added the `Gemfile` in the `Dockerfile` before calling `bundle install`.

This web site is hosted on [Amazon S3][s3] and use the [s3cmd][s3cmd] tool to push the generated files to the S3 bucket. The s3cmd configuration is stored on my home directory and I need to pass it to the Docker image so that when the `s3cmd` is run inside it, it can used by secret credentials.
This is done in a [docker.sh][dockersh] script that I used to start the Docker image:

    # Read the s3cmd private keys from my own s3cmd config...
    AWS_ACCESS_KEY_ID=`s3cmd --dump-config | grep access_key | grep -oE '[^ ]+$'`
    AWS_SECRET_ACCESS_KEY=`s3cmd --dump-config | grep secret_key | grep -oE '[^ ]+$'`

    # ... and pass it to the s3cmd inside Docker using env variables
    docker run -it --rm \
      -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
      -e AWS_SECRET_KEY=$AWS_SECRET_ACCESS_KEY \
      -v `pwd`/:/home/jmesnil/jmesnil.net \
      -p 4242:4242 \
      -w /home/jmesnil/jmesnil.net \
      jmesnil/jmesnil.net

Once the Docker image is started by this script, I can then use regular Rake tasks to run a local Web server to write articles (`rake dev`) or publish to Amazon S3 (`rake production`).

This is a bit overkill to use a 1.144 GB Docker image to generate a 6MB web site (that only contains text, all the photos are stored in a different S3 bucket) but it is worthwhile as it will no longer be broken every time I upgrade the OS or Brew.

The image is generic enough that it could serve as the basis of any Ruby project using Bundler (as long as required native libs are added to the `yum install` at the beginning of the Dockerfile).

[awestruct]: http://awestruct.org
[bundler]: http://bundler.io
[brew]: http://brew.sh
[docker]: https://www.docker.com
[hub]: https://hub.docker.com/r/jmesnil/jmesnil.net/
[marek]: https://hub.docker.com/r/goldmann/awestruct/
[s3]: https://aws.amazon.com/s3/
[s3cmd]: http://s3tools.org/s3cmd
[dockersh]: https://github.com/jmesnil/jmesnil.net/blob/master/docker.sh