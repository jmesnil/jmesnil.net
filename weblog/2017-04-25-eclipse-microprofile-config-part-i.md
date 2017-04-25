---
layout: post
title: "Eclipse MicroProfile Config (Part I)"
date: '2017-04-25 15:00:10'
category:
tags:
- work
- java
---

This is the first post that will cover some work I have been doing around the [Eclipse MicroProfile Config](empcfg) as a part of my job working on [WildFly][wildfly] and [Swarm][swarm].

In this post, I will show how to use the Config API from a Java application. The remaining posts will be about developing such new features within the WildFly and Swarm ecosystem.

## Eclipse MicroProfile

As stated on its [Web site][mpio], the mission of the Eclipse MicroProfile is to define:

> An open forum to optimize Enterprise Java for a microservices architecture by innovating across multiple implementations and collaborating on common areas of interest with a goal of standardization.

One of the first new API that they are defining is the [Config API][empcfg] that provides a common way to retrieve _configuration_ coming from a variety of sources (properties file, system properties, environment variables, database, etc.).
The API is very simple and consists mainly of 2 things:

* a `Config` interface can be used to retrieve (possibly optional) values identified by a name from many config sources
* a `@ConfigProperty` annotation to directly inject a configuration value using CDI

The API provides a way to add different config source from where the properties are fetched. By default, they can come from:

* the JVM System properties (backed by `System.getProperties()`)
* the OS environment (backed by `System.getenv()`)
* properties file (stored in `META-INF/microprofile-config.properties`)

A sampe code to use the Config API looks like this:

```java
@Inject
Config config;

@Inject
@ConfigProperty(name = "BAR", defaultValue = "my BAR property comes from the code")
String bar;

@Inject
@ConfigProperty(name = "BOOL_PROP", defaultValue = "no")
boolean boolProp;

...
Optional<String> foo = config.getOptionalValue("FOO", String.class);
...
```

There is really not much to the Config API. It is a simple API that hides all the complexity of gathering configuration from various places so that the application can focus on using the values.

One important feature of the API is that you can define the importance of the config sources.
If a property is defined in many sources, the value from the config source with the higher importance will be used.
This allows to have for example default values in the code or in a properties file (with low importance) that are used when the application is tested locally.
When the application is deployed in a container, environment variables defined by the container will have higher importance and be used instead of the default ones.

## Instructions

The code above comes from the [example](https://github.com/jmesnil/microprofile-config-extension/blob/master/example/src/main/java/net/jmesnil/microprofile/config/example/HelloWorldEndpoint.java) that I wrote as a part of my work on the Config API.

To run the example, you need to first install my [project](https://github.com/jmesnil/microprofile-config-extension) and then run the example project:

```
$ cd example
$ mvn wildfly-swarm:run
...
2017-04-14 10:35:24,416 WARN  [org.wildfly.swarm] (main) WFSWARM0013: Installed fraction: Eclipse MicroProfile Config - UNSTABLE        net.jmesnil:microprofile-config-fraction:1.0-SNAPSHOT
...
2017-04-14 10:35:30,676 INFO  [org.wildfly.swarm] (main) WFSWARM99999: WildFly Swarm is Ready
```

It is a simple Web application that will return the value of some variable and fields that are configured using the Config API:

```
$ curl http://localhost:8080/hello
FOO property = Optional[My FOO property comes from the microprofile-config.properties file]
BAR property = my BAR property comes from the code
BOOL_PROP property = false
```

We then run the application again with environment variables:

```
$ BOOL_PROP="yes" FOO="my FOO property comes from the env" BAR="my BAR property comes from the env" mvn wildfly-swarm:run
```

If we call the application, we see that the environment variables are now used to configure the application:

```
$ curl http://localhost:8080/hello
FOO property = Optional[my FOO property comes from the env]
BAR property = my BAR property comes from the env
BOOL_PROP property = true
```

The example is using Swarm and for those familiar with it, only requires to add two fractions to use the Config API:

```
<dependency>
  <groupId>org.wildfly.swarm</groupId>
  <artifactId>cdi</artifactId>
</dependency>
<dependency>
  <groupId>net.jmesnil</groupId>
  <artifactId>microprofile-config-fraction</artifactId>
  <version>1.0-SNAPSHOT</version>
</dependency>
</dependency>
```

I have not yet released a version of my implementation as it is not clear yet where it will actually be hosted (and which Maven coordinates will be used).

# Conclusion

This first post is a gentle introduction to the Config API. The [specification](https://github.com/eclipse/microprofile-config/blob/master/spec/src/main/asciidoc/microprofile-config-spec.asciidoc) is not final and I have left outside some nice features (such as converters) that I will cover later.

The next post will be about my experience of writing an implementation of this API and the way to make it available to Java EE applications deployed in the WildFly application server or to MicroServices built with WildFly Swarm.

[mpio]: https://microprofile.io/
[gh]: https://github.com/jmesnil/microprofile-config-extension
[wildfly]: https://wildlfy.org/
[swarm]: http://wildfly-swarm.io/
[empcfg]: https://github.com/eclipse/microprofile-config/
