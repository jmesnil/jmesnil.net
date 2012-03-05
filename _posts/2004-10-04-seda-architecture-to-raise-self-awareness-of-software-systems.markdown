---
date: '2004-10-04 22:28:14'
layout: post
slug: seda-architecture-to-raise-self-awareness-of-software-systems
status: publish
title: ⚑ SEDA architecture to raise self awareness of software systems
wordpress_id: '46'
tags:
- java
---

Last winter, I had the opportunity to work on a road traffic supervision software. I was in charge of the design and development on the communication and data aggregation subprojects.  

The _communication subproject_ was receiving the data from various sources





  
  * the probes and sensors on the roads which were sending regularly traffic data (number of cars, speed,...)

  
  * weather information from Meteo France

  
  * various information from partners (cabs, fire department,...)




When the communication subproject received the information, depending of its type, it dispatched it to the _data aggregation subproject_ which computed interesting values (traffic trend, weather trend,...) based on a set of customizable rules.  

Then depending on the result values, the aggregation subproject used the communication subproject to dispatch the information to the supervision center (to alert supervisors), to the archives or to information displays on the roads (_Big storm coming!!!_).





To design these two parts, I used a simple loosely coupled system where the information was flowing as messages and components declared their interests on specific message types. The messages were either XML messages (we also retrieved CSV files and mapped them to XML ones) or simple MapMessages.  

I had a centralized Content-Based Router which, depending on the message types, sent it to the interested components which did what they wanted and then dispatched it to the router once their task were finished.  

The flow was quite simple and could be expressed using a finite state machine.  

The router was also in charge of thread management (the application was heavily multihtreaded): if there were not enough threads in the pool, new ones were created. If the pool maximum size was reached, the messages were queued and waited for free threads which could take care of them.






The application was delivered on time and is up and running quite well.





I left for another project but I kept thinking about what I could have done if I had the opportunity to make a second version of this project.  

What bothered me on my design was that the thread management was not smart enough. Let take a simple use case: an accident. In that case, there could be a massive number of incoming messages containing road information (traffic jams are forming, speed is quickly varying,...). But the priority in that case is to give the data to the supervision center and display them on the roads to prevent other accidents. We don't want to lose time computing values while we have such an important message to communicate. However the router was not smart enough to prioritize this type of messages.  

Another interesting use case was weather variation: there is some chances that if the weather is quickly degrading (and we computed this trend), the road traffic will be altered some time later. But the application was not smart enough to know that if the weather was degrading it should increase its thread pool size to be ready for huge data acquisition.  

What's more there are regulars peaks of activity during the morning and the afternoon when people drives to work or to home. But the router was not smart enough to increase its thread pool to be ready for these regular peaks.






Enter [SEDA](http://www.eecs.harvard.edu/~mdw/proj/seda/). I first heard about SEDA from John Beatty on his weblog about [removing buttons and knobs from servers with SEDA architecture](http://www.gonesilent.com/~john/blog/archives/000066.html) (incidentally I was at HPTS when David Campbell talked about SQL Server tuning but I don't think he mentioned SEDA, did he?).





Had I the opportunity to write the second version of the project I'd go for a SEDA architecture style.





The main advantage I see in using a SEDA style would be to have separate thread pools 
for the different components (incoming communication, aggregation, outgoing communication) and be able to tune them in response of the behavior of the system.
Taking the weather degradation use case, it'd possible to increase the ingoing communication thread pool when the weather is degrading.  

In the same way, in case of an accident (that we know from incoming messages), we could prioritize the outgoing communication pool to be sure that the more important thing to do is to give the information to competent people.  

The thread pools could self tune themselves (for example to be ready on the morning and afternoon peaks) and could also interact between them (the aggregation pool could increase the incoming pool if the weather is degrading).  

The application would then behave better and, more importantly, **degrade better**.





The more I think about that and the more I believe that we can significantly raise the self awareness of our applications. Using SEDA and a good set of rules we can make our applications smarter and self tunable. David Campbell had a good point. Most of the properties for our application are not accurate and the applications would be better than us to _get_ the correct value (while we can only _guess_ them).
The applications could be more aware of their health and status and could know what to do to degrade nicely if they knew how to prioritize their work. SEDA makes it possible to get such a behavior while separating it from the business code.





Since that project, I didn't have the opportunity to work on a similar project but I'd like to give SEDA a try on a new project to validate that we can design and build better applications by raising their self awareness.





What do you think? Did you have the opportunity to work on a SEDA projects? What was your experience?
