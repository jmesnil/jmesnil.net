---
date: '2006-01-19 18:35:05'
layout: post
slug: label-decorations-in-eclipse
status: publish
title: Label Decorations in Eclipse
wordpress_id: '105'
tags:
- eclipse
---

During the development of an Eclipse plug-in, I wanted to add label decorations to a view.
The article [Understanding Decorators in Eclipse](http://eclipse.org/articles/Article-Decorators/decorators.html) is a good reference but I couldn't make it work in my own plug-in. This article is omitting a key information: The label provider you want to decorate needs to accept decorations, it **must** be wrapped in a `DecoratingLabelProvider`.
For now, I haven't found a way to find that information declaratively. So if you want to decorate a label provider provided by another plug-in, you have to browse its code to find out if it can be decorated or not. 

As an example, to make my own `ILabelProvider` decorable, I had to change the code in my view from:

    viewer.setLabelProvider(new MyLabelProvider());

to:

    viewer.setLabelProvider(
      new DecoratingLabelProvider(
        new MyLabelProvider(),   
        PlatformUI.getWorkbench().getDecoratorManager().getLabelDecorator()));
	
With that change,  I could contribute declaratively a lightweight decorator extension (i.e. in another plug-in) to this provider without any trouble.

