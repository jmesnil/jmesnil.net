---
date: '2007-05-23 20:53:03'
layout: post
slug: jmx-scripts-with-eclipse-monkey
status: publish
title: JMX Scripts with Eclipse Monkey
wordpress_id: '151'
tags:
- eclipse
- java
- jmx
---

Continuing the series about "writing JMX scripts in a dynamic language", after Ruby ([part I][part-I] & [II][part-II]), let's do that in JavaScript.

Aside of the use of a different scripting language, this example differs completely from the Ruby one by its context of execution: it will be integrated into Eclipse and called directly from its user interface (using [Eclipse Monkey][eclipse-monkey] as the glue).

The example will:

1. ask graphically the user for a logging level
2. update all the JVM's loggers with this level
3. display all the loggers of the JVM

in 50 lines of code.

This example is simple but it implies several interesting steps:

* connect to a JMX Server
* retrieve a MBean
* retrieve value of MBean attributes
* invoke operations on the MBean

There are many use cases where you have to perform theses steps in repetition. It's tedious to do that in a JMX console (e.g. [jconsole][jconsole] or [eclipse-jmx][eclipse-jmx]) and most of the time, it is not worth writing a Java application.

These use cases beg to be scripted.

[part-I]: http://jmesnil.net/weblog/2007/03/23/jmx-scripts-using-jruby/
[part-II]: http://jmesnil.net/weblog/2007/04/03/jmx-scripts-using-jruby-part-ii/
[eclipse-monkey]: http://www.eclipse.org/dash/monkey-help.php?key=installing
[jconsole]: http://java.sun.com/j2se/1.5.0/docs/guide/management/jconsole.html
[eclipse-jmx]: http://code.google.com/p/eclipse-jmx/

We will again use jconsole as our managed java application (see [this previous post][part-II] to start jconsole with all System properties required to manage it remotely).

To run the example:

1. install [Eclipse Monkey][eclipse-monkey]
2. Make sure that Eclipse is running on Java 1.5 or above
3. copy the script just below and save it as `logging_change_level.js` in the `scripts` directory of an Eclipse project
4. click on `Scripts > Logging > Change level` in Eclipse menu
5. follow the instruction to install the required DOM
  * only the `JMX Monkey` feature is required
6. restart Eclipse
7. click on `Scripts > Logging > Change level`
8. in the dialog, input the logging level
    ![Dialog to input the logging level][logging-input-level-dialog]
9. all the loggers have been updated with the given level
    ![Dialog to display the loggers][logging-results]

### logging\_\_change\_\_level.js ###

<pre><code class='javascript'>/*
 * Menu: Logging > Change level
 * DOM: http://eclipse-jmx.googlecode.com/svn/trunk/net.jmesnil.jmx.update/net.jmesnil.jmx.monkey.doms
 */
    
function main() {
   mbsc = jmx.connect("localhost", 3000)
   logging = mbsc.getMBean("java.util.logging:type=Logging")
   
   level = ask_level()
   set_all(mbsc, logging, level)
   text = "All loggers are set to " + level + "\n\n"
   text += logger_levels(mbsc, logging)
   show(text)
}
    
function logger_levels(mbsc, logging) {
   var out = ""
   for each(loggerName in logging.LoggerNames) {
       lvl = mbsc.invoke(logging, "getLoggerLevel",
            [loggerName],
            ["java.lang.String"]);
       out += loggerName + " is at " + lvl + "\n"
   }
   return out
}
    
function set_all(mbsc, logging, level) {
   for each(loggerName in logging.LoggerNames) {
       mbsc.invoke(logging, "setLoggerLevel",
            [loggerName, level],
            ["java.lang.String", "java.lang.String"])
   }
}
    
function ask_level() {
   dialog = new Packages.org.eclipse.jface.dialogs.InputDialog(
          window.getShell(), 
          "Logging Level",
          "Which level? (SEVERE, WARNING, INFO, CONFIG, FINE, FINER, FINEST)",
          "INFO", null)
   result = dialog.open()
   if (result == Packages.org.eclipse.jface.window.Window.OK) {
       return dialog.getValue()
   }
}
    
function show(text) {
   Packages.org.eclipse.jface.dialogs.MessageDialog.openInformation(
           window.getShell(),
           "Update Logging",
           text
       )
}
</code></pre>

### code walkthrough ###

The `main()` function of the script is:

<pre><code class='javascript'>function main() {
  mbsc = jmx.connect("localhost", 3000)
  logging = mbsc.getMBean("java.util.logging:type=Logging")
     
   level = ask_level()
   set_all(mbsc, logging, level)
   text = "All loggers are set to " + level + "\n\n"
   text += logger_levels(mbsc, logging)
   show(text)
} 
</code></pre>

where

* `mbsc = jmx.connect("localhost", 3000)` creates a `mbsc` object connected to a local JMX server using the [standard JMX Service URL][std-jmx-url].
* `logging = mbsc.getMBean("java.util.logging:type=Logging")` creates a `logging` object representing the [LoggingMXBean][LoggingMXBean] used to manage the JVM logging.
* `level = ask_level()` opens an Eclipse input dialog where you can input the logging level and returns it as a String.
* `set_all(mbsc, logging, level)` sets all the loggers at the given level
* `text += logger_levels(mbsc, logging)` returns a String representation of all the loggers and their level
* `show(text)` opens an Eclipse message dialog

The interesting methods are `logger_levels()` and `set_all()`. In both methods, we retrieve an attribute of a MBean and invoke an operation.

Let's focus on `set_all()`:

<pre><code class='javascript'>function set_all(mbsc, logging, level) {
   for each(loggerName in logging.LoggerNames) {
      mbsc.invoke(logging, "setLoggerLevel",
            [loggerName, level],
            ["java.lang.String", "java.lang.String"])
   }
}  
</code></pre>

`logging` represents a MBean (it is not a "real" MBean, more on that later) and `mbsc` represents a [`MBeanServerConnection`][mbsc-javadoc] (but it is not a "real" `MBeanServerConnection`, more on that later).  
`logging.LoggerNames` returns the value of the `LoggerNames` attribute of the MBean (_note that the *first letter* must be in *upper case*_) which is an array of strings.  
For each element of this array, we invoke the `setLoggerLevel` operation using `mbsc.invoke()`.   
This method is very similar to the "real" [`MBeanServerConnection.invoke()`][mbsc.invoke-javadoc] method:

1. something representing a MBean (instead of an ObjectName)
2. the MBean operation name
3. the parameters of the operation
4. the types of the parameters

### jmx: an Eclipse Monkey DOM ###

What do I mean when I write that `logging` is not the "real" `LogginMXBean` and that `mbsc` is not the real `MBeanServerConnection`?

This 2 types of objects are created by the `jmx` object in the `main()` method. This `jmx` object is in fact an [Eclipse Monkey DOM][eclipse-monkey-dom] that is contributed by the plug-in listed in the `DOM` directive at the top of the script:

    DOM: http://eclipse-jmx.googlecode.com/svn/trunk/net.jmesnil.jmx.update/net.jmesnil.jmx.monkey.doms
    



This plug-in was included in the "JMX Monkey" feature which was installed the first time you ran this script.

The `jmx` DOM has a single method `connect(host, port)` which connects to a JMX Server using the [standard JMX Service URL][std-jmx-url].  
The object returned by this method is a [`ScriptableMBeanServerConnection`][ScriptableMBeanServerConnection]. This class encapsulates the "real" `MBeanServerConnection` (still available using the `getObject()` method) but only exposes its `invoke()`.

It also exposes a `getMBean()` method which returns a [`ScriptableMBean`][ScriptableMBean]. In turn this class exposes the attributes of the MBean as JavaScript attributes.

To sum up, these are the operations you can perform using the `jmx` DOM:

* connect to a JMX server: `mbsc = jmx.connect(host, port)`
* get a mbean: `mbean = mbsc.getMBean(objectName)`
* get the value of a mbean attribute: `val = mbean.AttributeName`
* get the "real" mbean server connection and use it: `objectNames = mbsc.getObject().queryNames(name, query)`
* invoke an operation on a mbean: `mbsc.invoke(mbean, operation, params, param_types)`

### Conclusion ###

This script example is simple but quite interesting thanks to its integration with Eclipse.

I believe there is an use for such scripts: repeatable management operations that needs to be tweaked from time to time.
It's tedious to do that with a GUI and it's even more tedious to write Java applications to do so.

Last year, during EclipseCon'06, I blogged about an [use case for scripting a RCP application][scripting-rcp-application] using Eclipse Monkey.
This is a concrete example: I'm using [eclipse-jmx][eclipse-jmx] to manage Java applications that I develop. When I realize that I perform the same kind of management task, I write a monkey script which automates it.

Next time, you have to perform the same operation on many MBeans or many operations on the same MBean but you think it is not worth to write a Java application to automate it, ask yourselves if it can not be simply automated by a script such as the one in this post.

[LoggingMXBean]: http://java.sun.com/j2se/1.5.0/docs/api/java/util/logging/LoggingMXBean.html
[mbsc-javadoc]: http://java.sun.com/j2se/1.5.0/docs/api/javax/management/MBeanServerConnection.html
[mbsc.invoke-javadoc]: http://java.sun.com/j2se/1.5.0/docs/api/javax/management/MBeanServerConnection.html#invoke(javax.management.ObjectName,%20java.lang.String,%20java.lang.Object[],%20java.lang.String[])
[mbsc.setAttribute-javadoc]:http://java.sun.com/j2se/1.5.0/docs/api/javax/management/MBeanServerConnection.html#setAttribute(javax.management.ObjectName,%20javax.management.Attribute)
[std-jmx-url]: http://java.sun.com/j2se/1.5.0/docs/guide/management/agent.html#connecting
[logging-input-level-dialog]: http://jmesnil.net/img/logging_level_input.png
[logging-results]: http://jmesnil.net/img/logging_results.png
[eclipse-monkey-dom]: http://www.eclipse.org/dash/monkey-help.php?key=writing-doms
[ScriptableMBeanServerConnection]: http://eclipse-jmx.googlecode.com/svn/trunk/net.jmesnil.jmx.monkey.doms/src/net/jmesnil/jmx/monkey/doms/ScriptableMBeanServerConnection.java
[ScriptableMBean]: http://eclipse-jmx.googlecode.com/svn/trunk/net.jmesnil.jmx.monkey.doms/src/net/jmesnil/jmx/monkey/doms/ScriptableMBean.java
[scripting-rcp-application]: http://jmesnil.net/weblog/2006/03/22/use-case-for-scripting-a-rcp-application
