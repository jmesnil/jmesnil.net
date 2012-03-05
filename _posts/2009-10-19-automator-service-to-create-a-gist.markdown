---
date: '2009-10-19 19:57:35'
layout: post
slug: automator-service-to-create-a-gist
status: publish
title: ⚑ Automator Service to create a Gist
wordpress_id: '844'
tags:
- apple
---

I created an Automator Service to create a [Gist][gist] from a text selection. This service will create the gist and copy the corresponding URL to the clipboard so that it can be pasted in IRC or in a web browser

* Open `Applications` -> `Automator`
* Create a new Service

![Create a new Service](http://jmesnil.net/weblog/wp-content/uploads/2009/10/service.png)

* Drag and drop `Utilities` -> `Run Shell Script`
  * Select shell: `/bin/bash`
  * Pass input: `as arguments`
  * Copy the content below:


    
    
    RESP_FILE=/tmp/gist.tmp
    rm -f $RESP_FILE
    
    USER=`git config --global github.user`
    USERAVAIL=$?
    TOKEN=`git config --global github.token`
    TOKENAVAIL=$?
    if [ $USERAVAIL -eq 0 -a $TOKENAVAIL -eq 0 ]; then
      AUTH="--data-urlencode login=$USER --data-urlencode token=$TOKEN"
    fi
    
    curl http://gist.github.com/gists --silent -i $AUTH --data-urlencode "file_contents[gistfile1]=$1" --data-urlencode "file_ext[gistfile1]=.txt"  -o $RESP_FILE
    cat $RESP_FILE|sed -ne '/Location/p'|cut -f2- -d:|tr -d ' ' | pbcopy
    



* Since it can take a few seconds to create a Gist, I added a Grow notification: drag and drop `Utilities` -> `Show Growl Notification`
* Save service as "Gist Code"

You will end up with this service:

[![Gist Code](http://jmesnil.net/weblog/wp-content/uploads/2009/10/gist-service-300x216.png)](http://jmesnil.net/weblog/wp-content/uploads/2009/10/gist-service.png)

Now, you can select any text1, right-click and select `Gist Code`:

[![mate](http://jmesnil.net/weblog/wp-content/uploads/2009/10/mate-300x128.png)](http://jmesnil.net/weblog/wp-content/uploads/2009/10/mate.png)

It also works from the Terminal using the application menu `Terminal` -> `Services` -> `Gist Code`

Once the gist has been created, you will be notified by Growl when the gist URL is copied to the clipboard. You can then paste this on IRC or in a web browser: [http://gist.github.com/213301](http://gist.github.com/213301)

By default, the gist will be saved as plain text (you will need to change the type from the gist page directly).
This service also uses Git to retrieve GitHub credentials so that the gist is added to your Gists (rather than anonymously).

This is a  screencast showing how to create and use this service:



Enjoy!

----

1. It only works for Cocoa text widget. At first, I wanted to use it with Eclipse but unfortunately Eclipse does not support Apple Services... ↩

[gist]: http://gist.github.com 

