---
date: '2004-11-25 17:09:45'
layout: post
slug: dos-and-donts-of-logging
status: publish
title: Do's and Don't's of Logging
wordpress_id: '51'
tags:
- java
---

I had recently the opportunity to study log files of a heavily used Java-based Web application (several million hits a day).
It was interesting to read these log files because I wrote a lot of logs when I developped but it was the first time that I had to read logs from code I was not familiar with.





It's definitely not rocket science but here is what I learn.





### 1. Log at the appropriate level





Logging framework defines several level of logging. For example, [Log4J](http://logging.apache.org/log4j) defines the following levels in its [`Level`](http://logging.apache.org/log4j/docs/api/org/apache/log4j/Level.html) interface:





DEBUG
    Fine-grained informational events that are most useful to debug an application

INFO
    Informational messages that highlight the progress of the application at coarse-grained level

WARNING
    Potentially harmful situations

ERROR
    Error events that might still allow the application to continue running

FATAL
    Very severe error events that will presumably lead the application to abort





However, it happens that some developpers understand slightly differently these definitions. What is important is to agree within the development team on the meaning and use of these levels to use them _consistently_.





### 2. Write your log at a given level for a given population





Depending of the level, your logs will be read by different people (either technical or non technical one). The logged information may need to be more or less descriptive.





### 3. Do not use several log calls to log related information




I often put in my code the following statements:


       public void aMethod(String id, int value, boolean activated) {
         if (logger.isEnabledFor(DEBUG)) {
            logger.debug("id=" + id);
            logger.debug("value=" + value);
            logger.debug("activated=" + activate);
         }
         ...
       }





That's fine as long you are in a single-thread application. In that case, you get the logs one after the other in the log files. However, once you're in a heavily multithreaded application, you can have several other logs between two of your own logs. That makes it harder to understand the flow and the state of execution due to the noise provided by the other logs.





### 4. Do not rely on previous logs at different level to retrieve information





I saw the following code:




    
       private void doStuff(String name) {
          if (logger.isEnabledFor(Level.DEBUG)) {
             logger.debug("name=" + name);
          }
          String value = giveMeTheValueFor(name);
          if (value == null) {
             if (logger.isEnabledFor(Level.WARN)) {
                logger.warn("value not found, using default.");
             }
             value = ...
          }
          ...
       }





If the logging configuration displays up to `DEBUG` level, that's great.
But if the logging configuration displays only `WARN` and `ERROR` levels, the warning is useless. There is not enough information at these levels to give to the developper to help him or her reproduce and understand the problem.





### 5. No fancy `System.err` or `System.out`





I still saw some `System.err.print(...)` or `System.out.println(...)`. It was obviously put while debugging the code but wasn't removed...





### 6. Use MDC/NDC to correlate logs





In a heavily multithreaded application, you can have lots of intermingled logs. It makes hard to correlate the logs to trace the execution for a specific user. One solution to this problem is to use Log4J [Mapped Diagnostic Context](http://logging.apache.org/log4j/docs/api/org/apache/log4j/MDC.html) or [Nested Diagnostic Context](http://logging.apache.org/log4j/docs/api/org/apache/log4j/NDC.html). You can then store in the diagnostic context the session ID of the user to be able to uniquely identify all logs associated with a given user.  

(It was Gavin King of [Hibernate](http://www.hibernate.org) fame who introduced me to [contextual logging](http://blog.hibernate.org/cgi-bin/blosxom.cgi/2004/08/25#log))





### 7. No fancy `System.err` or `System.out` ...



_...especially in JSP!_



Unfortunately there were a lot of `System.err` in the JSP files. I suppose it's because it's less tedious to write a `System.err.println()` in a JSP than a correct log statement.





### 8. Use `Arrays.asList(Object[])` to log object arrays





I already blogged about [this one](http://www.jmesnil.net/weblog/2004/11/stringified-representation-of-arrays.html) but it's worth repeating it.





### 9. No fancy `System.err` or `System.out` ...





Did I already mention this one?





### To sum up




The bottom line is to have correct logs so that we are able to process them and automatically extract useful information. If they are consistent, it is then possible to retrieve much more information than if tehy are not (e.g. recurring exceptions at a given level).



