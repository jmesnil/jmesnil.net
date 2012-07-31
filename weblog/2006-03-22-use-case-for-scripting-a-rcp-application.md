---
date: '2006-03-22 05:51:14'
layout: post
slug: use-case-for-scripting-a-rcp-application
status: publish
title: Use case for scripting a RCP application
wordpress_id: '128'
tags:
- eclipse
---

I attended the [Scripting Eclipse panel](http://www.eclipsecon.org/2006/Sub.do?id=334) which was quite interesting (see [Ed's transcript](http://blogs.zdnet.com/Burnette/?p=42).

Scripting Eclipse means a lot of different things to different people.  
My own interest is to provide scripting ability to a RCP application so that its users can customize it for their needs and create their own workflow.

For example, imagine that the RCP application is used to manage remote resources. Each resources can be manage individually through a set of methods.   
But what if you want to provide a workflow for advanced operations?

One way to do this is through wizards. But with that solution, users lose control like Joel Spolksy explained in [his presentation](http://www.eclipsecon.org/2006/Sub.do?id=24).   
Besides it is very difficult to provide wizards which makes simple things simple and complex things possible. They tend to become uncluttered and undecipherable.

Another way is to provide cheatsheets. However, interaction between the cheatsheets and the user interface remains basic. And users are still not in control: they must follow the steps dictated by the cheatsheets.

Now, imagine that we expose a DOM of the managed resources and we let users script their processes.
They are in control and *they* manage the workflow of *their* resources.
They win because they are in control and we (the RCP developpers) win because we can keep our RCP application simple. We just have to expose the simplest useful DOMs to our users to let them handle themselves their more complex and specific processes.

