---
layout: post
title: "Eclipse MicroProfile Config 1.0 and WildFly implementation"
date: '2017-07-27 14:10:47'
category:
tags:
- work
- java
---

[Eclipse MicroProfile Config 1.0][empcfg] has been released.

It is quite a milestone as it is the first specification released by the [Eclipse MicroProfile project][mp].
It covers a simple need: unify the configuration of Java application from various sources with a simple API:

```java
@Inject
@ConfigProperty(name = "app.timeout", defaultValue = "5000")
long timeout;
```

The developer no longer needs to check for configuration files, System properties, etc. He or she just specifies the name of the configuration property (and an optional default value). The Eclipse MicroProfile Config specification ensures that several sources will be queried in a consistent order to find the most relevant value for the property.

With Eclipse MicroProfile Config 1.0 API available, I have released [wildfly-microprofile-config 1.0.1][wmpc].

This project contains an [implementation of the specification][implementation]:

```
<dependency>
   <groupId>org.wildfly</groupId>
   <artifactId>wildfly-microprofile-config</artifactId>
   <version>1.0.1</version>
</dependency>
```

This implementation passes the MicroProfile Config 1.0 TCK. It can be used by any CDI-aware container/server (i.e. that are able to load CDI extensions).

This project also contains a [WildFly][wildfly] extension so that any application deployed in WildFly can use the MicroProfile Config API.
The `microprofile-config` subsystem can be used to configure various config sources such as directory-based for OpenShift/Kubernetes config maps (as described in a [previous post][configmap]) or the properties can be stored in the `microprofile-config` subsystem itself):

```
<subsystem xmlns="urn:wildfly:microprofile-config:1.0">
    <config-source name="appConfigSource">
        <property name="app.timeout" value="2500" />
    </config-source>
    <config-source name="configSourceFromDir" dir="/etc/config/numbers-app" />
</subsystem>
```

Finally, a Fraction is available for [WildFly Swarm][swarm] so that any Swarm application can use the Config API as long as it depends on the appropriate Maven artifact:

```
<dependency>
  <groupId>org.wildfly.swarm</groupId>
  <artifactId>microprofile-config</artifactId>
  <version>1.0.1</version>
</dependency>
```

It is planned that this `org.wildfly.swarm:microprofile-config` Fraction will eventually move to Swarm own Git repository so that it Swarm will be able to autodetect applications using the Config API and load the dependency automatically. But, for the time being, the dependency must be added explicitely.

If you have any issues or enhancements you want to propose for the WildFly MicroProfile Config implementation, do not hesitate to [open issues][issues] or [propose contributions][pr] for it.

[mp]: https://microprofile.io
[empcfg]: https://github.com/eclipse/microprofile-config/
[wmpc]: https://github.com/wildfly-extras/wildfly-microprofile-config
[implementation]: https://github.com/wildfly-extras/wildfly-microprofile-config/tree/master/implementation
[configmap]: http://localhost:4242/weblog/2017/06/16/eclipse-microprofile-config-in-openshift/
[swarm]: http://wildfly-swarm.io
[wildfly]: http://wildfly.org
[issues]: https://github.com/wildfly-extras/wildfly-microprofile-config/issues
[pr]: https://github.com/wildfly-extras/wildfly-microprofile-config/pulls
