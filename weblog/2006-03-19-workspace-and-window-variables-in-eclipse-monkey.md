---
date: '2006-03-19 23:07:01'
layout: post
slug: workspace-and-window-variables-in-eclipse-monkey
status: publish
title: workspace and window variables in Eclipse Monkey
wordpress_id: '125'
tags:
- eclipse
---

I'm playing with [Eclipse Monkey](http://www.eclipse.org/dash/monkey-help.php?key=installing) and its DOM examples.

At first I did not understood in the `Find_System_Prints.em` example where the `window` variable was coming from.  
After diving into in the `org.eclipse.eclipsemonkey` plug-in source code, I found out that it is defined as a standard global variable
in `RunMonkeyScript.defineStandardGlobalVariables(Scriptable scope)` method.   
Incidentally, it is the only global variable added by Eclipse Monkey.

The following code is also commented in this method (in version 0.1.6 of the `o.e.eclipsemonkey` plug-in):

    // Object wrappedWorkspace = Context.javaToJS(ResourcesPlugin
    // .getWorkspace(), scope);
    // ScriptableObject.putProperty(scope, "workspace", wrappedWorkspace);

The `workspace` variable is instead contributed by the `org.eclipse.dash.doms` plug-in.

To sum up, `window` is available for free in your Monkey scripts while you will have to reference the `http://download.eclipse.org/technology/dash/update/org.eclipse.dash.doms` DOM to have access to the `workspace` variable.

