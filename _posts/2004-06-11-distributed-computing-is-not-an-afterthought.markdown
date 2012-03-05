---
date: '2004-06-11 11:44:29'
layout: post
slug: distributed-computing-is-not-an-afterthought
status: publish
title: ⚑ Distributed computing is not an afterthought
wordpress_id: '17'
tags:
- misc
---

I recently read two differents papers related to distributed communication which reminded me of the pitfalls of designing applications which treat remote components and local ones the same way.







  * the classic [Notes on Distributed Computing](http://research.sun.com/techrep/1994/abstract-29.html) which explains why distributed computing can't be treated the same way than local computing


  * A paper on IBM DeveloperWorks ([Coaxing J2EE out of the container](http://www-106.ibm.com/developerworks/java/library/j-jtp04204.html)) which presents [Somnifugi](http://somnifugi.sourceforge.net/), a intra-VM [JMS](http://java.sun.com/products/jms/) implementation





The IBM paper discusses the use of some J2EE APIs outside a J2EE container.  

This topic is very important to me. I tried to achieve that goal when I was working on [JORAM](http://joram.objectweb.org) and [JOTM](http://jotm.objectweb.org): to provide J2EE services to smaller applications so that they can use these services without a full J2EE server to take adavantage of only one or two features (have you ever tried to write an applications using JMS messages and Distributed Transactions outside a J2EE server?).  

So I think the idea of Somnifugi is an interesting one.





However, what bothers me in the IBM paper is when the author writes that




> 
Somnifugi also offers another significant benefit: It is now possible to develop components that use JMS interfaces, and then decide at application deployment time whether to use the fast, in-memory Somnifugi provider or a heavier but more reliable provider such as WebSphere MQ. The advantages of being able to defer this choice to deployment time are considerable -- especially because requirements can change over a project's lifecycle -- and provide an opportunity for code reuse that would not be practical with a homegrown messaging layer.






It's striking to read that just after reading the notes on Distributed Computing which states that




> 
Programming a distributed application will require the use of different techniques than those used for non-distributed applications. Programming a distributed application will require thinking about the problem in a different way than before it was thought about when the solution was a nondistributed application. But that is only to be expected. Distributed objects are different from local objects, and keeping that difference visible will keep the programmer from forgetting the difference and making mistakes. Knowing that an object is outside of the local address space, and perhaps on a different machine, will remind the programmer that he or she needs to program in a way that reflects the kinds of failures, indeterminacy, and concurrency constraints inherent in the use of such objects. Making the difference visible will aid in making the difference part of the design of the system.





It seems wrong to me to believe that you can design your application with Somnifugi and switch later to WebSphere MQ as an afterthought.  

There are _fundamental_ differences between using a **distributed entreprise messaging system** and a **thread notification library**. Somnifugi is accessible through JMS interfaces but given its nature (inner-VM, thread notification), it's misleading to think of it as a  JMS implementation.  

For example, using Somnifugi at development time means that the JMS message endpoints **must** be in the same VM. Switching to WebSphere MQ later does not change that fact. And this can not be easily modified at deployment time. You'll have to redesign your components to take into account the remoteness of the endpoints (what about guaranteed delivery, persistence, acknowledgment and do not forget the [Eight Fallacies of Distributed Computing](http://today.java.net/jag/Fallacies.html) ;-)





When I was working on JOTM, it was one of my main goals to provide "easy" transactions to JSP/Servlets developers. So that they could seamlessly integrate JTA transactions to their web applications. However experience showed me that you can't really replace DB transactions by distributed transactions as an afterthought. There are some differences  which makes it dangerous and difficult to switch between two similar but different concepts.  

The IBM paper reminded me of that. Somnifugi and WebSphere MQ shares the same interfaces (JMS) but there are some fundamental difference which makes switching between the two **really hard**.


 


This entry is in no way a critic of Somnifugi. I think there is a lot of potential for that project (especially for **prototyping and unit testing JMS** application) but I also think that developers have to be very careful about the context before using it. IMHO this is a good counter example of [YAGNI](http://c2.com/cgi/wiki?YouArentGonnaNeedIt)! ;-)





[This reminds me of the EJB 1.1 specifications where you were able to access entity beans regardless of their locations. This mistake was corrected in EJB 2.0 where the access to entity beans were marked explicitely as accessible only locally]
