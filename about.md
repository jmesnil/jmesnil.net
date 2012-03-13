---
layout: page
title: About
---
{% include JB/setup %}

<div itemscope itemtype="http://data-vocabulary.org/Person">

I'm <span itemprop="name">Jean-Frederic Mesnil</span> (everybody calls me <span itemprop="nickname">Jeff</span>). I'm a <span itemprop="title">software developer </span> and this is my <a href="http://jmesnil.net/" itemprop="url">personal website</a>. Be my guest and enjoy your stay.

If you want to contact me, you can send me an email at <a href="mailto:jmesnil@gmail.com" itemprop="url">jmesnil@gmail.com</a>.

<strong>The opinions expressed on this web site are my own, and neither my employer nor any other party necessarily agrees with them.</strong >

</div>

## Professional Experience ##

###  November 2010 - March 2012, Bestofmedia Group (bestofmedia.com) ###

I worked for [Bestofmedia Group](http://www.bestofmedia.com/welcome.php?langue=en) as a senior software developer.  
I was working mainly on "Big Data" (using [Hadoop Map/Reduce](http://hadoop.apache.org/) and related projects) and Java backend infrastructure (on top of [HornetQ](http://jboss.org/hornetq/) and [Solr](http://lucene.apache.org/solr/)).

I also lead development for [Tom's Hardware](http://www.tomshardware.com/) and [Tom's Guide](http://www.tomsguide.com) iOS apps.

### October 2007 - November 2010, Red Hat (redhat.com) ###

I worked for [JBoss](http://jboss.com/), a division of [Red Hat](http://www.redhat.com/).  
I was a core developer on [HornetQ](http://jboss.org/hornetq/), the messaging system which powers JBoss Application Server.

### June 2005 - August 2007, Continuent (continuent.com) ###

I worked for [Continuent](http://www.continuent.com) where I developed on [Sequoia](http://sequoia.continuent.org), an Open Source cluster middleware.
I worked on its management infrastructure (using JMX) and its text console in addition to the core development.  
I also developed a graphical console built on top of Eclipse RCP.

### Jan. 2005 - May 2005, Kelkoo (www.kelkoo.com) ###

After I left Coframi, I signed a 4-month contract with [Kelkoo](http://www.kelkoo.com) (where I already was on a mission for Coframi) to finish development on the User Reviews project I was working on and put it (successfully) in production.

The project was based on web services (more RESTful than SOAPish) to integrate [Yahoo!](http://www.yahoo.com) services (login and
user content) to Kelkoo web site (Kelkoo is owned by Yahoo!).  
If I should describe it with buzzwords, I'd say that it was [Web Style](http://www.tbray.org/ongoing/When/200x/2006/03/26/On-REST) <abbrev title="Service Oriented Architecture">SOA</abbrev>. 

### Dec. 2003 - Jan. 2005, Coframi (www.coframi.fr) ###

I worked for [Coframi](http://www.coframi.fr), a French software engineering and consulting firm. I made several missions for their customers.

#### Kelkoo (www.kelkoo.com) ####

I was part of Kelkoo R&D team where I provided support and development of Kelkoo web sites.  

It was a great experience working on one of the most visited web sites in Europe and being challenged
by scalability issues due to the success of Kelkoo.
I also was in charge of interfacing with the production team to improve production servers uptime by analyzing recurring
performance bottlenecks and fixing them.

#### GTIE Vinci ####

For GTIE Vinci, I was part of the team in charge of the development of a traffic road supervision software (Vinci is a worldwide leader in construction and related services)

I designed and developed the communication tier to exchange data with external partners and road equipments.  
The data were exchanged through Web Services (XML over HTTP/FTP/SMTP/JMS, yes we had 4 different underlying communication protocols to talk to partners, road devices, etc.).
 
I also developped a graphical application to display traffic data in (almost) real time.
The application was built using SWT and was connected to an Oracle database through a homegrown ORM.

### Oct. 2001 - Oct. 2003, ObjectWeb (www.objectweb.org) ###

I was hired by [INRIA](http://www.inria.fr) to help development and promotion of [ObjectWeb](http://www.objectweb.org) projects.  
ObjectWeb is an international consortium creating Open Source middleware projects.

#### JOTM (jotm.objectweb.org) ####

I lead development for one year on JOTM which was the transaction manager embedded in JOnAS, a J2EE server. 
It was extracted from JOnAS codebase to be reused in contexts more lightweight than a J2EE server (e.g. Tomcat, Jetty or Spring Framework).

* Help and support to the JOTM community
* Coordination and integration on developments about JOTM (such as a BTP implementation above JOTM)
* Managed documentation and version releases
* Promotion and animation of the project
  * Presentations and talks at ObjectWeb conferences
  * Presentation at HPTS'03
  * Article about using transactions in Servlets with Tomcat and JOTM for O'Reilly Java web site
* Communication with related projects (JOnAS, Jetty, Tomcat)

#### JORAM (joram.objectweb.org) ####

I also developed for one year on JORAM, an Open Source JMS provider.

* Support and help to the JORAM community
* Integration of JORAM into JOnAS to provide JMS support and Message-Driven Beans
* Test compliance to JMS specifications (both 1.0.2 and 1.1). I developped a JMS Test Suite based on JUnit which was later used 
by other JMS providers (SwiftMQ, Pramati, ArjunaMS) and has been included in JBoss own test suite
* Managed documentation and version releases


## Education ##

### MSc Applied Mathematics and Computing, Cranfield University (www.cranfield.ac.uk), England, 2001 ###

The MSc thesis was to design and develop a Java graphical application (Swing and Java 3D) for B-Spline Volume Modelling.

### Master's Degree in Applied Mathematics and Software Engineering, INSA Rouen (www.insa-rouen.fr), France, 2001 ###

As a part of my studies I made two internships:

* At [Bull](http://www.bull.net), I designed and implemented EJB 1.1 security in JOnAS, an Open Source J2EE server
* At [INRIA](http://www.inrialpes.fr), I designed and developed a Web application to change in one step passwords on multiples OSes.
As part of this application I implemented a SSL stack on top of RMI/JRMP to communicate securely between the Web Server (Apache + JServ) and the OS backends (Unix, Windows NT, Mac OS).
I prototyped both a Java Applet client but ends up with a Servlet-based application (to make the long story short, https beats RMI over SSL between a web browser and a server)

## Technical Profile ##


I worked on projects for R&D team or Open Source organizations, products for companies and software-as-services which were delivered on the web.
I'm involved in various Open Source organizations, either as a user (apache), a member -- a.k.a bug reporter -- (eclipse) or a committer (jboss, objectweb, continuent).

Before the <abbrev title="Three Letters Accronym">TLA</abbrev> slugfest begins, let's make it short:
I developped a lot in Java, both on client side (3 different applications using either Swing or SWT/JFace) and server side
where I developed on a EJB container, 2 MOM implementations, a distributed transaction manager and a cluster middleware.
I also developed web applications on top of Java middleware.  

On my spare time, I develop using Java too and a little of Ruby/JRuby.  
I also learn a new language every year (Ruby, Erlang, Objective-C, JavaScript, Clojure). I won't use Java for all my career and I wonder what is the next platform I will move to....  
For each new language I learn, I try to develop a serious application to have a deep understanding of the language (e.g. [jmx4r](http://github.com/jmesnil/jmx4r/) for Ruby, [TangTouch](http://iphone.jmesnil.net/tangtouch.html) -- an iPhone game -- for Objective-C)

### Java Server Side ###

* JMS - Development of 2 JMS Providers, integration of JMS and Message-Driven Beans in a J2EE server
* JTA - Development of a JTA transaction manager
* EJB - Implementation of the EJB security in a J2EE server
* JSP/Servlets - Development of Web applications (using Struts and in-house MVC frameworks)
* JDBC - development of a JDBC cluster middleware
* JMX - used to manage the JDBC cluster middleware
* Hadoop Map/reduce - Development of map/reduce jobs for Web site analysis

### Java Client Side ###

* Graphical User Interface
    * a 3D application in Swing and Java 3D
    * a SWT application
    * a management console built on top of Eclipse RCP
* Text-based application
   * a text console used to manage Sequoia through JMX

### Misc Development ###

* XML, XSLT, Web Services - I developped several applications using REST Web Services, XML over various Internet protocols (HTTP, FTP, SMTP) or JMS
* Web development in HTML, JavaScript, CSS
* iOS (1 game, 2 apps)
* Ruby, Ruby on Rails

### Misc ###

The development and production tools are the usual suspects:

* Eclipse, TextMate, Vi
* Git, Subversion, CVS
* JUnit
* Ant, Maven
* Hudson, CruiseControl
* Mac OS X, Linux, Unix (AIX)
* MySQL, PostgreSQL, Oracle

## jmesnil.net ##

I created [this web site](http://jmesnil.net) in May 2004. Since then, I have posted articles on my [weblog](/weblog) about all things related to software design and development which interest me.
