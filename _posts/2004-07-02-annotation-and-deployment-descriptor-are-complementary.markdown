---
date: '2004-07-02 15:46:35'
layout: post
slug: annotation-and-deployment-descriptor-are-complementary
status: publish
title: Annotation and Deployment Descriptor are complementary
wordpress_id: '34'
tags:
- java
---

Very interesting blog from Dion, [Scared of annotation hell](http://www.almaer.com/blog/archives/000252.html).




The EJB specification made a good job to separate the different roles (bean developer, assembler, deployer and I forgot the others). One of the interesting side effect was that only a subset of the deployment descriptor was relevant for a given role.  

However, it didn't work out as expected because of the lack of smart applications to read/write the deployment descriptor.




One classic example is transaction demarcation: only the bean developper can set the transaction demarcation attribute `transaction-type` and it can't be changed later on (if the bean use bean-managed transaction demarcation, you can't make it container-managed).




I think that the EJB 3.0 Expert Group needs to think about that issue and maybe keep (optional) deployment descriptor outside the bean (for information such as table name) and use annotations for information that can't be modified without affecting subsequently the EJBs (such as transaction demarcation).



