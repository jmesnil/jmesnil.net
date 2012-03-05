---
date: '2011-11-03 23:06:06'
layout: post
slug: stomp-websocket-converted-to-coffeescript
status: publish
title: ⚑ stomp-websocket converted to CoffeeScript
wordpress_id: '1827'
tags:
- misc
---

One of the joy of working with Open Source projects is when you get an awesome contribution coming out of nowhere.

[Jeff Lindsay][progrium] requested to pull one of his branch of [stomp-websocket][stomp-websocket] where he converted all the code to CoffeeScript, added unit tests with a mock implementation of a WebSocket server. This work is a preliminary for more features (including a much-needed support for STOMP 1.1).

When he offered to pull its branch, he wonders if the move to CoffeeScript was controversial and if I would accept it.

[stomp-websocket][stomp-websocket] is meant to run inside Web browsers and leverage the Web Sockets API. When I wrote it, JavaScript was a no-brainer.

However I have started to question this choice recently.

I have a pet project where I use [node.js][nodejs] and I am making countless JavaScript code mistakes (I was bitten by [this one][missing-var] last week, thankfully I have not released my project yet).


As much as I like JavaScript and its related HTML5 APIs, I must admint I am not a good JavaScript programmer and I want a language that helps me instead of trapping me.
I started to read about [CoffeeScript][coffeescript] as a replacement of JavaScript. I find the language more pleasing to read even though some syntax conventions makes it more cryptic than concise.

I am quite pleased with the new code of stomp-websocket in [stomp.coffee][stomp.coffee]. It reads much better than the [original stomp.js][stomp.orig.js], there are no longer noisy `this`, `that` or `var`s (when they are not missing by errors!).

However, the [JavaScript code compiled by CoffeeScript][dist.stomp.js] does not look good. I suppose I must stop to look at the compiled JavaScript and instead consider it as [the assembly language of the Web][assembly].

In any case, the transition should be transparent for developers using stomp.js: the new generated [stomp.js][dist.stomp.js] offers the same [API][api] than the previous one.

If that is not the case, please report any regression or bug on [GitHub issue tracker][issue-tracker].

As usual, do not hesitate to contribute:

    git clone git://github.com/jmesnil/stomp-websocket.git

As Jeff Lindsay can attest, I welcome good contributions :)


[progrium]: https://github.com/progrium
[stomp-websocket]: http://jmesnil.net/stomp-websocket/doc/
[nodejs]: http://nodejs.org
[missing-var]: http://blog.meloncard.com/post/12175941935/how-one-missing-var-ruined-our-launch
[coffeescript]: http://jashkenas.github.com/coffee-script/
[stomp.coffee]: https://github.com/jmesnil/stomp-websocket/blob/master/src/stomp.coffee
[dist.stomp.js]: https://github.com/jmesnil/stomp-websocket/blob/master/dist/stomp.js
[stomp.orig.js]: https://github.com/jmesnil/stomp-websocket/blob/master/src/stomp.orig.js
[issue-tracker]: https://github.com/jmesnil/stomp-websocket/issues
[assembly]: http://www.hanselman.com/blog/JavaScriptIsAssemblyLanguageForTheWebSematicMarkupIsDeadCleanVsMachinecodedHTML.aspx
[api]: http://jmesnil.net/stomp-websocket/doc/#api
