---
layout: post
title: "Node.js + Redis on OpenShift"
date: '2012-05-02 10:56:23'
---

I have a pet project that uses a Web application running on [node.js][nodejs] with its data stored in [Redis][redis].  
Since I joined [Red Hat][redhat], I took the opportunity to eat our own dog food and port this application from [Heroku][heroku] to [OpenShift][openshift].

OpenShift does not support (yet) Redis in its list of database cartridges but it is straighforward to build a Redis server from scratch directly in OpenShift by following [these instructions][redis-openshift].

The next step is to add redis module to the list of dependencies in `deplist.txt`:

<pre><code class='bash'>$ cat deplist.txt
...
redis
...
</code></pre>

Redis node.js module does not expose a method to create a client from a Unix socket. We need to add our own function to do that and pass the path to the socket located in a temporary directory inside `OPENSHIFT_GEAR_DIR` directory (I found the code snippet on [stackoverflow][sof]):

<pre><code class='javascript'>var express   = require('express');
var net       = require('net');
var __redis__ = require('redis');

var createSocketClient = function (path, options) {
  var client = new __redis__.RedisClient(net.createConnection(path), options);
  client.path = path;
  return client;
};

var redis = createSocketClient(process.env.OPENSHIFT_GEAR_DIR + 'tmp/redis.sock');
</code></pre>

The rest of the code was not changed at all:

<pre><code class='javascript'>var app  = express.createServer();

// Handler for POST /test
app.post('/test', function(req, res){
  redis.incr('val', function(err, value) {
    if (err) {
      res.writeHead(500);
      res.end();
    } else {
      res.writeHead(200, {'Content-Type': 'text/plain'});
      res.end('val=' + value + '\n');
    }
  });
})

...
</code></pre>

Once the code is committed and pushed to OpenShift Git repository, the hook will build and start Redis (only the first time) and the Web application is ready to serve any data from Redis:

<pre><code class='bash'>$ curl -X POST http://${appname}-jmesnil.rhcloud.com/test/
val=1
$ curl -X POST http://${appname}-jmesnil.rhcloud.com/test/
val=2
</code></pre>

Even though Redis is not officially supported by OpenShift yet, it is still possible to use it now and it is very simple to deploy and run it. 

[nodejs]: http://nodejs.org
[redis]: http://redis.io
[redis-openshift]: https://github.com/razorinc/redis-openshift-example
[sof]: http://stackoverflow.com/questions/4191019/direct-non-tcp-connection-to-redis-from-nodejs
[redhat]: http://www.redhat.com
[openshift]: https://openshift.redhat.com
[heroku]: http://www.heroku.com/
