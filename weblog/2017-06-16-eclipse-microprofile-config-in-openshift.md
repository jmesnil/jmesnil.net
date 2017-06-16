---
layout: post
title: "Eclipse MicroProfile Config in OpenShift"
date: '2017-06-16 14:51:29'
category:
tags:
- work
- java
---

This is another post that covers some work I have been doing around the [Eclipse MicroProfile Config][empcfg] as a part of my job working on [WildFly][wildfly] and [Swarm][swarm] (first post is [here](/weblog/2017/04/25/eclipse-microprofile-config-part-i/)).

This post is about some updates of the project status and work being done to leverage the Config API in [OpenShift][openshift] (or other [Docker][docker]/[Kubernetes][kubernetes]-based environment).

## Project update

Since last post, WildFly and Swarm projects agreed to host the initial work I did in their GitHub projects and the Maven coordinates have been changed to reflect this.
For the time being, everything is hosted at [wildfly-extras/wildfly-microprofile-config](https://github.com/wildfly-extras/wildfly-microprofile-config).

The Eclipse MicroProfile Config 1.0 API should be released soon. Once it is released, we can then release the 1.0 version of the WildFly implementation and subsystem. The Swarm fraction will be moved to the Swarm own Git repo and will be available with future Swarm releases.

Until the Eclipse MicroProfile Config 1.0 API is released, you still have to build everything from [wildfly-extras/wildfly-microprofile-config](https://github.com/wildfly-extras/wildfly-microprofile-config) and uses the Maven coordinates:

```
<dependency>
  <groupId>org.wildfly.swarm</groupId>
  <artifactId>microprofile-config</artifactId>
  <version>1.0-SNAPSHOT</version>
</dependency>
```

## Directory-based Config Source

We have added a new type of `ConfigSource`, [DirConfigSource](https://github.com/wildfly-extras/wildfly-microprofile-config/blob/master/implementation/src/main/java/org/wildfly/microprofile/config/DirConfigSource.java), that takes a `File` as a parameter.

When this ConfigSource is created, it scans the file (if that is a directory) and creates a property for each file in the directory. The key of the property is the name of the file and its value is the content of the file.

For example, if you create a directory named `/etc/config/numbers-app` and add a file in it named `num.size` with its content being `5`, it can be used to configure the following property:

```
@Inject
@ConfigProperty(name = "num.size")
int numSize;
```

There are different ways to use the corresponding `DirConfigSource` depending on the type of applications.

### WildFly Application

If you are deploying your application in WildFly, you can add this config source to the `microprofile` subsystem:

```
<subsystem xmlns="urn:wildfly:microprofile-config:1.0">
    ...
    <config-source name="numbers-config-source" dir="/etc/config/numbers-app" />
</subsystem>
```

### Swarm Application

If you are using Swarm, you can add it to the `MicroProfileFraction` from your `main` method:

```java
swarm.fraction(new MicroProfileConfigFraction()
    .configSource("numbers-config-source", (cs) -> {
        cs.ordinal(600)
            .dir("/etc/config/numbers-app/");
}));
```

### Plain Java Application

If you are using the WildFly implementation of the Config API outside of WildFly or Swarm, you can add it to a custom-made `Config` using the Eclipse MicroProfile `ConfigBuilder` API.

## OpenShift/Kubernetes Config Maps

What is the use case for this new type of `ConfigSource`?

It maps to the concept of __[OpenShift/Kubernetes Config Maps](https://docs.openshift.org/latest/dev_guide/configmaps.html)__ so that an application that uses the Eclipse MicroProfile Config API can be deployed in a container and used its config maps as a source of its configuration.

I have added an [OpenShift example](https://github.com/wildfly-extras/wildfly-microprofile-config/tree/master/examples/openshift) that shows a simple Java application running in a variety of deployment and configuration use cases.

The application uses two properties to configure its behaviour. The application returns a list of random positive integers (the number of generated integers is controlled by the `num.size`property and their maximum value by the `num.max` property):

```java
@Inject
@ConfigProperty(name = "num.size", defaultValue = "3")
int numSize;

@Inject
@ConfigProperty(name = "num.max", defaultValue = "" + Integer.MAX_VALUE)
int numMax;
```

The application can be run as a __standalone Java application__ configured with __System Properties__:

```
$ java -Dnum.size=5 -Dnum.max=10 -jar numbers-app-swarm.jar
```

It can also be run in __Docker__ configured with __environment variables__:

```
$ docker run -e "num.size=2" -e "num.max=10" -p 8080:8080 numbers/numbers-app
```

It can also be run in __OpenShift__ configured with __Config Maps__:

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: numbers-config
  namespace: numbers
  ...
data:
  num.size: '5'
  num.max: '100'
```

This highlights the benefit of using the Eclipse MicroProfile Config API to configure a Java application: the application code remains simple and use the injected values from the Config API.
The implementation then figures out all the sources where the values can come from (System properties, properties files, environment, __and container config maps__) and inject the appropriate ones.

[mpio]: https://microprofile.io/
[gh]: https://github.com/jmesnil/microprofile-config-extension
[wildfly]: https://wildlfy.org/
[swarm]: http://wildfly-swarm.io/
[empcfg]: https://github.com/eclipse/microprofile-config/
[openshift]: https://docs.openshift.org/latest/welcome/index.html
[docker]: https://www.docker.com
[kubernetes]: https://kubernetes.io
