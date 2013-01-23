---
date: '2010-11-24 22:38:55'
layout: post
slug: html5-web-application-for-iphone-and-ipad-with-node-js
status: publish
title: HTML5 Web Application for iPhone and iPad With node.js
wordpress_id: '1333'
tags:
- iphone
- javascript
- web
---

__Update:__ _I have written [another post](/weblog/2010/11/26/offline-support-and-standalone-mode-for-html5-web-application/) about adding offline support to the Web application and making it look like a native iPhone application._

On the server, I want to learn more about [node.js][nodejs] which is an interesting way to develop server-side applications.
On the client-side, I also wanted to check what can be done with HTML5 on iPhone and iPad with the release of iOS 4.2.1.

I will write a simple web application to do both at the same time. The idea is simple enough but will allow me to dive into node.js and HTML5 quite extensively.

The idea is to write a web application that display a piece moving on a board when the user moves its device. 
Later on, I will expand it so that the user will also see the pieces of all others users connected to the server.

But the first iteration will be enough to familiarize with:

* node.js (to serve static content at first)
* [Canvas API][canvas] (to draw the board and the piece)
* [DeviceOrientation Event API][orientation] (to detect the orientation of the mobile, it was added in iOS 4.2.1)

# Web Server 

I will use node.js as my Web server (I installed it from Git by following the [build instructions][nodejs-build] on its web site).

The first version of the server needs to serve static files with the correct HTTP `Content-Type`.
At first, it will serve only HTML pages, CSS stylesheets and JavaScript files.

The whole `server.js` code is:

<pre><code class='javascript'>var http = require('http');
var url = require('url');
var fs = require('fs');
var sys = require('sys');
  
// the HTTP server
var server;
// the HTTP port
var port = 8080;

server = http.createServer(function(req, res){
  var path = url.parse(req.url).pathname;
  if (path == '/') {
    path = '/index.html'
  }
  console.log("serving " + path);
  fs.readFile(__dirname + path, function(err, data){
    if (err) {
      res.writeHead(404);
      res.end();
    } else {
      res.writeHead(200, {'Content-Type': contentType(path)});
      res.write(data, 'utf8');
      res.end();
    }
  });
});
    
function contentType(path) {
  if (path.match('.js$')) {
    return "text/javascript";
  } else if (path.match('.css$')) {
    return  "text/css";
  }  else {
    return "text/html";
  }
}
    
server.listen(port);
console.log("HTTP server running at htpp://0.0.0.0:" + port );
</code></pre>


The code is straightforward: when a request is handled by the server, it looks in the current directory (where `server.js` is) for a file with the given path and writes its content in the HTTP response body.  
The `contentType(path)` function checks the file suffix to use the correct HTTP `Content-Type` for the response.

It will serve files from `http://0.0.0.0:8080/`.  
For the rest of the example, I will use the name of my machine, `blackbook.local`: to access the Web application from my iPhone, I am using [http://blackbook.local:8080](http://blackbook.local:8080).

In future iterations, I will add more interesting code to node.js (to use WebSockets for example) but for the moment this simple server is enough.

# Web Application

Let's now focus on the client-side part of the Web application.

## index.html

The Web application is loaded from a single HTML5 page, `index.html`:

<pre><code class='xml'><html>
&lt;head>
  &lt;meta charset="UTF-8">&lt;/meta>
  &lt;meta content="width=device-width, user-scalable=0" name="viewport">&lt;/meta>
  &lt;title>Board&lt;/title>
  &lt;link href="screen.css" rel="stylesheet">
&lt;/head>
&lt;body>
  &lt;canvas width="320" id="board" height="460">&lt;/canvas>

  &lt;script src="jquery.min.js">&lt;/script>
  &lt;script src="client.js">&lt;/script>
&lt;/body>
&lt;/html>
</code></pre>
    



The page contains a single `<canvas>` element named `board`. All the code to draw on the canvas is in `client.js` JavaScript file.

## client.js

`client.js` contains code to:

* get orientation information from the device (using the DeviceOrientation Event API)
* draw the board and the piece based on the orientation information (using the Canvas API)

First, it defines a few constants used to draw the board and the piece:

<pre><code class='javascript'>var kBoardWidth = 320;
var kBoardHeight = 460;
var kCircleRadius = 32;
</code></pre>
    
The `piece` object is defined literally:

<pre><code class='javascript'>var piece = {
   center : {
      x: kBoardWidth / 2,
      y: kBoardHeight / 2,
      xShift : 0,
      yShift : 0
   },
   color: "#000"
};
</code></pre>
  



The piece has a center position with its coordinates (initially at the center of the board) and its acceleration on the x and y axes, and its color is black.

I use [jQuery][jquery] to bootstrap the application when the document is ready:

<pre><code class='javascript'>$(document).ready(function() {
   var board = document.getElementById("board");
   var context = board.getContext("2d");
   window.addEventListener("devicemotion", function(event) {
     var accel = event.accelerationIncludingGravity;
     piece.center = computeCenter(piece.center, accel);
     drawGrid(context);
     drawPiece(context, piece);
  }, true);
}); 
</code></pre>
    
First we keep a reference on the `board` canvas that was declared in the HTML page and its associated 2D context.
The `context` will be used to draw the piece and the board on the canvas.

We use the DeviceOrientation API (supported by the iPhone and the iPad since iOS 4.2.1) to detect the acceleration of the device.
Periodically, the browser will call the handler associated to the `devicemotion` event.  
When that happens, the handler retrieves the `accelerationIncludingGravity` property, compute the new center position of the piece and draw the board and the piece on the canvas.

The method to draw the board is using the 2D context (the board is displayed as a grid):

<pre><code class='javascript'>function drawBoard(context) {
  context.clearRect(0, 0, kBoardWidth, kBoardHeight);
  for (var x = 0.5; x &lt; kBoardWidth; x += 10) {
     context.moveTo(x, 0);
     context.lineTo(x, kBoardHeight);
  }
  for (var y = 0.5; y &lt; kBoardHeight; y += 10) {
    context.moveTo(0, y);
    context.lineTo(kBoardWidth, y);
  }
  context.strokeStyle = "#eee";
  context.stroke();
}
</code></pre>
    



The code to draw the piece is also using the 2D context to draw a circle from the piece's center and its color:

<pre><code class='javascript'>function drawPiece(context, piece) {
   context.fillStyle = piece.color;
   context.beginPath();
   context.arc(piece.center.x, piece.center.y, kCircleRadius, 0, Math.PI * 2, false);
   context.closePath();
   context.fill();
}
</code></pre>

Finally, we need to compute the updated position of the piece's center based on its current position and the acceleration information from the browser:

<pre><code class='javascript'>function computeCenter (oldCenter, acceleration) {
  newCenter = {};
  newCenter.xShift = oldCenter.xShift * 0.8 + acceleration.x * 2.0;
  newCenter.yShift = oldCenter.yShift * 0.8 + acceleration.y * 2.0;
  newCenter.x = oldCenter.x + oldCenter.xShift;
  // use *minus* to compute the center's new y
  newCenter.y = oldCenter.y - oldCenter.yShift;
  // do not go outside the boundaries of the canvas
  if (newCenter.x &lt; kCircleRadius) {
    newCenter.x = kCircleRadius;
  }
  if (newCenter.x > kBoardWidth - kCircleRadius) {
    newCenter.x = kBoardWidth - kCircleRadius;
  }
  if (newCenter.y &lt; kCircleRadius) {
    newCenter.y = kCircleRadius;
  }
  if (newCenter.y > kBoardHeight - kCircleRadius) {
    newCenter.y = kBoardHeight - kCircleRadius;
  }
  return newCenter;
}
</code></pre>
    
To smooth the movement and increase the acceleration when the mobile is moved, I applied a low-pass filter:

<pre><code class='javascript'>newCenter.xShift = oldCenter.xShift * 0.8 + acceleration.x * 2.0;
newCenter.yShift = oldCenter.yShift * 0.8 + acceleration.y * 2.0;
</code></pre>
    



The rest of the method ensures that the piece will remain in the boundaries of the board.   

# screen.css

Last thing is to make sure that the canvas fills the whole Web page by removing the margin and padding on the `body` element. This is done through CSS in the `screen.css` file:

<pre><code class='css'>body {
  margin: 0px;
  padding: 0px;
}
</code></pre>

All these files are located in the same directory than `server.js`.

# Run the example

Let's start the node.js server:

    $ node server.js
    HTTP server running at htpp://0.0.0.0:8080


Now, from my iPhone, I go to the Web page on [http://blackbook.local:8080](http://blackbook.local:8080) (if you go on the Web application from your machine, nothing will happen since the `devicemotion` event is not available on desktop browsers).

As I have not found a way to prevent the iPhone to change the screen orientation when it is moved, I have locked the iPhone in portrait mode before running the Web application.

Here is a small video of the result:

<div class="video-wrapper" style="max-width:640px"><div class="video">
<iframe width="640" height="360" src="http://www.youtube.com/embed/hqVcLpsO728" frameborder="0" allowfullscreen></iframe>
</div></div>

It's not obvious from the video but the camera was recording from above: the iPhone was held horizontally.

## Source Code

I have pushed the application on [Github][board-git]. You can clone it with Git:

    git clone git://github.com/jmesnil/board-node.git

The code is slightly different as I have already started the next iteration but the main idea remains the same.

## Conclusion

With a few lines of JavaScript on both the client and server sides, it is possible to:

* use node.js to write a Web server returning files
* use the Canvas API to draw things on a Web page
* use the DeviceOrientation Event API orientation to have interaction between the device and the Web page 

Next steps will be to improve the user experience:

* make the application appear as a standalone application on the iPhone home screen and remove Safari chrome
* support offline mode to use the Web application even when the server is not running

# Further Reading

* [node.js][nodejs]
* [Canvas API][canvas] (and its corresponding ["Dive into HTML5" chapter][canvas-dihtml5])
* [DeviceOrientation Event API][orientation]

[nodejs]: http://nodejs.org/
[nodejs-build]: http://nodejs.org/#build
[canvas]: http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html
[canvas-dihtml5]: http://diveintohtml5.org/canvas.html
[orientation]: http://dev.w3.org/geo/api/spec-source-orientation.html
[jquery]: http://jquery.com/
[board-git]: https://github.com/jmesnil/board-node
