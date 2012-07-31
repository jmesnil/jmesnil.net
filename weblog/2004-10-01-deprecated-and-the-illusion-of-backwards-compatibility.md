---
date: '2004-10-01 15:17:49'
layout: post
slug: deprecated-and-the-illusion-of-backwards-compatibility
status: publish
title: "@deprecated and the illusion of backwards compatibility"
wordpress_id: '48'
tags:
- java
---

Recently, I stumbled on deprecated code which took deprecation a little too seriously.  

I was in the process a upgrading a dependency to an internal project we were using. The modification were only listed at bugfix level which meant that there should have been no changes in the API of the project.  

I saw that some public methods I used were marked as deprecated and I wrote on my todo list to refactor my code to use the new public methods later. It was not a priority task and it could have waited for the next release.  

Unfortunately, the developer was too extreme in his understanding of API deprecation:





  
  * He marked the methods as `@deprecated`

  
  * **and** he modified their implementation to always return `null` within the same release!





Of course, all my tests went crazy after I upgraded the project.





I had an interesting discussion with the developer afterwards. Basically his argument was that these methods were deprecated with good reasons and shouldn't be used anymore because they were not safe.  

I understood his point but I had two objections:





 
  1. deprecated methods _shouldn't_ be used but they _could_ be used

 
  2. deprecating methods and modifying them in the same release is not friendly to the project users because it forces them to refactor their code without any delay.




His project was no longer backwards compatible while the release should have only been about bug fixes. He defined backwards compatible as "the API signature did not change". But IMHO, the fact that his methods always return `null` breaks the _contract_ of the API. Broadly, I see the contract of the API as more than just the sum of its public methods signature, it also includes the preconditions and postconditions associated with the methods. And one of the  (implicit) postconditions of its methods was that they did not return `null`.





Sun defines [deprecation](http://java.sun.com/j2se/1.5.0/docs/guide/javadoc/deprecation/) as :




> A deprecated API is one that you are no longer recommended to use, due to changes in the API. While deprecated classes, methods, and fields are still implemented, they may be removed in future implementations, so you should not use them in new code, and if possible rewrite old code not to use them.






I told the developer that deprecating the methods and modifying them within the same release is of no use. It breaks the API in the same way that if the methods had been plainly and simply removed because I had no other way than to modify my code to remove calls to deprecated methods
_immediately_. It had only the _illusion of backwards compatibility_.





When you have a public API that evolves, deprecation is an invaluable tool but you still have to use it carefully so that your user can upgrade their code at their rhythm and not when you want them too. If you want a clear change in your API, the release version of your project should reflect that big change and it shoud come with a big warning flag.





I'm interested to know how you handle deprecation of your API project, especially in the Open Source Software world.




An useful resource concerning deprecation is [How and When To Deprecate APIs](http://java.sun.com/j2se/1.5.0/docs/guide/javadoc/deprecation/deprecation.html).




