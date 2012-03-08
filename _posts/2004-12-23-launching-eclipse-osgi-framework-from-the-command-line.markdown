---
date: '2004-12-23 14:19:10'
layout: post
slug: launching-eclipse-osgi-framework-from-the-command-line
status: publish
title: Launching Eclipse OSGi Framework from the command line
wordpress_id: '58'
tags:
- eclipse
- osgi
---

I'm currently playing with [OSGi](http://osgi.org/). There are two Open Source implementations ([Oscar](http://oscar.objectweb.org/) and [Knoplerfish](http://www.knopflerfish.org/)) you can use.  

Another Open Source OSGi framework is provided by [Eclipse](http://eclipse.org) since its 3.0 release.




To launch its OSGi framework without starting all Eclipse:





  
  1. put in your classpath all the jars in `$ECLIPSE_HOME/plugins/org.eclipse.osgi_3.1.0/`

  
  2. start the framework with

    
    
      <code><verbatim>java -classpath $CLASSPATH \ 
    -Dosgi.framework="file://$ECLIPSE_HOME/plugins/org.eclipse.osgi_3.1.0" \  
    org.eclipse.osgi.framework.launcher.Launcher -console</verbatim>
    </code>
    






You then have the framework started:

    
    
      <code>
    osgi> status
    Framework is shutdown.
    
    id      Bundle Location
    State       Bundle File Name
    0       System Bundle
      STARTING    org.eclipse.osgi.framework.adaptor.core.SystemBundleData@17f1ba3
    Registered Services
    {org.eclipse.osgi.framework.console.CommandProvider}=
      {service.ranking=2147483647, service.id=1}
    
    osgi> launch
    
    osgi> ss
    
    Framework is launched.
    
    id      Type    State       Bundle
    0               ACTIVE     System Bundle [0]
    
    osgi>
    </code>
    



It is then ready to install and start new bundles (e.g. available from [Oscar Bundle Repository](http://oscar-osgi.sourceforge.net/repo/repository.xml)):

    
    
    <code>
    osgi> install http://oscar-osgi.sf.net/repo/log/log.jar
    Bundle id is 2
    
    osgi> start 2
    
    osgi> status
    Framework is launched.
    
    id      Bundle Location
    State       Bundle File Name
    0       System Bundle
      ACTIVE     org.eclipse.osgi.framework.adaptor.core.SystemBundleData@17f1ba3
    2       http://oscar-osgi.sf.net/repo/log/log.jar
      ACTIVE     http://oscar-osgi.sf.net/repo/log/log.jar
    Registered Services
    {org.eclipse.osgi.framework.console.CommandProvider}=
      {service.ranking=2147483647, service.id=1}
    {org.osgi.service.packageadmin.PackageAdmin}=
      {service.ranking=2147483647, service.id=2, service.vendor=Eclipse.org,   
       service.pid=0.org.eclipse.osgi.framework.internal.core.PackageAdminImpl}
    {org.osgi.service.startlevel.StartLevel}=
      {service.ranking=2147483647, service.id=3, service.vendor=Eclipse.org, 
       service.pid=0.org.eclipse.osgi.framework.internal.core.StartLevelManager}
    {org.osgi.service.log.LogService}=
      {service.id=4}
    {org.osgi.service.log.LogReaderService}=
      {service.id=5}
    
    osgi>
    </code>
    
