---
layout: post
title: "AS7 REST Management API"
date: '2012-07-23 16:57:04'
category: 
tags: 
  - jboss
---

I am playing a bit with [AS7 Management REST API][as7-rest] and I want to display the full description of the server model from the Web browser.

Using the CLI, this is equivalent to

{%highlight bash %}
[standalone@localhost:9999 /] /:read-resource-description(recursive=true, operations=true)
{
    "outcome" => "success",
    "result" => {
        "description" => "The root node of the server-level management model.",
        "head-comment-allowed" => true,
        "tail-comment-allowed" => true,
        "attributes" => {
            "namespaces" => {
                "type" => OBJECT,
                "value-type" => STRING,
                "description" => "Map of namespaces used in the configuration XML document, where keys are namespace prefixes and values are schema URIs.",
                "required" => false,
                "head-comment-allowed" => false,
                "tail-comment-allowed" => false,
                "access-type" => "read-only",
                "storage" => "configuration"
            },
    ...
}
{% endhighlight %}

However, using the CLI is limiting for what I envision. The description that is returned is similar to JSON but it's not valid JSON.
I want to interact with the descriptions using a programming language to iterate on resources, filter them out, etc.

The end game could be to generate a HTML documentation for each release of  AS7 that could ship with the release and complement the [existing documentation][as7-guide]

To achieve this, I have first create a simple [Sinatra][sinatra] application that queries a running AS7 server (in standalone mode) and display its resource description using the REST API.

The application is using [Bundler][bundler] to manage its dependencies through a `Gemfile` file:

{% highlight rb %}
source 'http://rubygems.org'
gem 'rake'
gem 'rack'
gem 'sinatra'
gem 'httparty'
gem 'json'
{% endhighlight %}

We use [Rack][rack] to start the Web server hosting our little app with a `config.ru` file:

{% highlight rb %}
require "./application.rb"

run Sinatra::Application
{% endhighlight %}

The application itsel if a simple Sinatra application which calls the AS7 management REST API (with authentication) and proxies the JSON output.

{% highlight rb %}
require 'rubygems'
require 'bundler/setup'
Bundler.require

get '/resource-description' do
  user = params['user']
  password = params['password']

  return [500, "missing user and password parameters"] unless user and password

  url = 'http://127.0.0.1:9990/management/'
  operation = {:operation => "read-resource-description",
      :recursive => params["recursive"] || false,
      :operations => params["operations"] || false,
      :inherited => params["inherited"] || false
    }
  res = AS7.query url, user, password, operation.to_json
  if res.code == 200
    [res.code,   {'Content-type' => 'application/json'}, res.body.to_s]
  else
    [res.code, res.headers, res.body.to_s]
  end
end

class AS7
  include HTTParty
  def AS7.query(url, user, password, operation)
    digest_auth user, password
    post url , :body => operation, :headers => {"Content-type" => "application/json"}
  end
end
{% endhighlight %}

In itself, that's not terribly interesting but if it is coupled with a [JSON prettifier extension][json-ext], it displays a nice interactive JSON tree in the browser.

<figure>
  <a href="{{ site.s3.url }}/images/2012-07-23-json-tree.jpg" rel="lightbox" title="JSON output">
  ![JSON output]({{ site.s3.url }}/images/2012-07-23-json-tree.jpg)
  </a>
  <figcaption>JSON output</figcaption>
</figure>

To run the application:

{% highlight bash %}
$ bundle # to fetch the ruby gems
$ rackup config.ru
[2012-07-23 17:14:02] INFO  WEBrick 1.3.1
[2012-07-23 17:14:02] INFO  ruby 1.9.3 (2012-04-20) [x86_64-linux]
[2012-07-23 17:14:02] INFO  WEBrick::HTTPServer#start: pid=11499 port=9292    $ rackup config.ru
{% endhighlight %}

The description is then available at [http://localhost:9292/resource-description](http://localhost:9292/resource-description)

* __Mandatory parameters__
  * `user` - the AS7 admin user
  * `password` - the AS7 admin password
* __Optional parameters__
  * `recursive` - whether the description is recursive (defaults to `false`)
  * `operation` - whether the description includes operation descriptions (defaults to `false`)
  * `inherited` - whether the children description includes inherited elements (defaults to `false`)

For example, to get the most comprehensive description of the server, you can go to [http://localhost:9292/resource-description?user=admin&password=mySecretPassword&recursive=true&operation=true&inherited=true](http://localhost:9292/resource-description?user=admin&password=mySecretPassword&recursive=true&operation=true&inherited=true)

Next step is to transform the JSON into a HTML output with a nice format and JavaScript goodies (e.g. for automatic generation of a table of contents)

[as7-rest]: https://docs.jboss.org/author/display/AS71/The+HTTP+management+API
[as7-guide]: https://docs.jboss.org/author/display/AS71/Management+API+reference
[sinatra]:http://sinatrarb.com/
[bundler]: http://gembundler.com/
[rack]: http://rack.github.com/
[json-ext]: https://chrome.google.com/webstore/detail/kccpfgilgmgbipamhohknpokhibinhhj
