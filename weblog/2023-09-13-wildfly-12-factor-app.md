---
layout: post
title: "WildFly and the Twelve-factor App Methodology"
date: '2023-09-13 07:30:04'
tags: 
  - development
---

In my daily job at [Red Hat](https://redhat.com), I'm focused these days on making [WildFly](http://wildfly.org) run great on container platforms such as [Kubernetes](https://kubernetes.io).

## "Traditional" way to develop and run applications with WildFly

WildFly is a "traditional" application server for Entreprise Java applications. To use it on the cloud, we are making it more flexible and closer to "cloud-native" applications so that it can be used to develop and run a [12-Factor App](https://12factor.net).

Traditionally, if you were using WildFly on your own machine, the (simplified) steps would be:

1. Download WildFly archive and unzip it
2. Edit its XML configuration to match your application requirements
3. In your code repository, build your deployment (WAR, EAR, etc.) with Maven
4. Start WildFly
5. Copy your deployment
6. Run tests

At this point, your application is verified and ready to use.

There are a few caveats to be mindful of. 

* Whenever a new version of WildFly is available, you have to re-apply your configuration change and verify that the resulting configuration is valid.
* You run tests against your *local* download of WildFly with your *local* modifications. Are you sure that these changes are up to date with the production servers?
* If you are developing multiple applications, are you using different WildFly downloads to test them separately?

## "Cloudy" way to  develop and run applications with WildFly

When you want to operate such application on the cloud, you want to automate all these steps in a reproduceable manner. 

To achieve this, we inverted the traditional application server paradigm.

Before, WildFly was the top-level entity and you were deploying your applications (ie WARs and EARs) on it.
Now, your application is the top-level entity and you are in control of the WildFly runtime.

With that new paradigm, the steps to use WildFly on the cloud are now:

1. In your code repository, configure WildFly runtime (using a Maven plugin)
2. Use Maven to build your application
3. Deploy your application in your target container platform

Step (2) is the key as it automates and centralizes most of the "plumbing" that was previously achieved by hand.

If we decompose this step, it actually achieves the following:

1. Compile your code and generate the deployment
1. "Provision" WildFly to download it, change its configuration to match the application requirements
2. deploy your deployment in the provisioned WildFly server
3. Run integration tests against the _actual_ runtime (WildFly + your deployments) that will be used in production
4. Optionally create a container image using `docker`

Comparing the two ways to develop and run WildFly can look deceiving. However, a closer examination shows that the "Cloudy" way unlocks many improvements in terms of productivity, automation, testing and, at least in my opinion, _developer joy_.

## What does WildFly provide for 12-Factor App development?

The key difference is that *your* Maven project (and its `pom.xml`) is the single [12-factor's Codebase](https://12factor.net/codebase) to track your application. Everything (your application dependencies, WildFly version and configuration changes) is tracked in this repo. You are sure that what is built from this repository will always be consistent. You are also sure that WildFly configuration is up to date with production server because *your* project is _where_ its configuration is updated. You are not at risk of deploying your WAR in a different version of the server or a server that has not been properly configured for your application.

Using the [WildFly Maven Plugin](https://github.com/wildfly/wildfly-maven-plugin) to provision WildFly ensures that all your [12-factor's Dependencies](https://12factor.net/dependencies) are explicitly declared. Wheneve a new version of WildFly is released, you can be notified with something like Dependabot and automatically test your application with this new release.

We have enhanced WildFly configuration capabilities so that you can store your [12-factor's Config](https://12factor.net/config) in your environment. WildFly can now use [environment variables to change any of its management attributes](https://docs.wildfly.org/29/Admin_Guide.html#overridden-attribute-value) or [resolve their expressions](https://docs.wildfly.org/29/Admin_Guide.html#Expression_Resolution). Eclipse MicroProfile Config is also available to store any of your application config in the environment.

Connecting to [12-factor's Backing Services](https://12factor.net/backing-services) is straightforward and WildFly is able to connect to a database with a few env vars representing its URL and credentials with the [datasources feature pack](https://github.com/wildfly-extras/wildfly-datasources-galleon-pack).

Using the [WildFly Maven Plugin](https://github.com/wildfly/wildfly-maven-plugin) in your `pom.xml`, you can simply have different stages to [12-factor's Build, release, run](https://12factor.net/build-release-run) and make sure you build once your release artifact (the application image) and runs it on your container platform as needed.

Entreprise Java application as traditionally stateful so it does not adhere to the [12-factor's Processes](https://12factor.net/processes) unless you refactor your Java application to make it stateless.

WildFly complies with [12-factor's Port binding](https://12factor.net/port-binding) and you can rely on accessing its HTTP port on `8080` and its management interfance on `9990`.

Scaling out your application to handle [12-factor's concurrency](https://12factor.net/concurrency) via the process model is depending on your application architecture. However WildFly can be provisioned in such a way that its runtime can exactly fit your application requirements and "trim" any capabilites that is not needed. You can also split a monolith Entreprise Java application in multiple applications to scale the parts that need it.

[12-factor's Disposability](https://12factor.net/disposability) is achieved by having WildFly fast booting time as well as graceful shutdown capabilities to let applications finish their tasks before shutting down.

[12-factor's Dev/prod parity](https://12factor.net/dev-prod-parity) is enabled when we are able to use continuous deployment and having a single codebase to keep the gap between what we develop and what we operate. Using WildFly with container-based testing tool (such as [Testcontainers](https://testcontainers.com)) ensures that what we test is very similar (if not identical) to what is operated.

WildFly has extensive logging capabilities (for its own runtime as well as your application code) and works out of the bow with [12-factor's Logs](https://12factor.net/logs) by outputting its content on the standard output. For advanced use cases, you can change its output to use a JSON formatter to query and monitor its logs.

[12-factor's Admin processes](https://12factor.net/admin-processes) has been there from the start with WildFly that provides a extensive CLI tool to run management operations on a server (running or not). The same management operations can be executed when WildFly is provisioned by the WildFly Maven Plugin to adapt its configuration to your application.

## Summary

We can develop and operate Entrprise Java applications with a modern software methodology. Some of these principles resonate more if you targeting cloud environment but most of them are still beneficical for traditional "bare metal" deployments.

<i style="color: green;" class="fa fa-solid fa-check"></i>  [I. Codebase](https://12factor.net/codebase)

* Use the [WildFly Maven Plugin](https://github.com/wildfly/wildfly-maven-plugin) to store WildFly information with your application code.

<i style="color: green;" class="fa fa-solid fa-check"></i>  [II. Dependencies](https://12factor.net/dependencies)

* All dependencies (including WildFly) are managed by your application `pom.xml`.

<i style="color: green;" class="fa fa-solid fa-check"></i> [III. Config](https://12factor.net/config)

* Use Eclipse MicroProfile Config and WildFly capabilities to read  configuration from the environment.

<i style="color: green;" class="fa fa-solid fa-check"></i> [IV. Backing Services](https://12factor.net/backing-services)

* Jakarta EE is designed on this principle (eg JDBC, JMS, JCA, etc.).

<i style="color: green;" class="fa fa-solid fa-check"></i> [V. Build, release, run](https://12factor.net/build-release-run)

* With a single `mvn package`, you can build your release artifact and deploy it wherever you want. The WildFly Maven Plugin can generate ate a directory or an application image to suit either bare-metal or container-based platform.

<i class="fa fa-solid fa-question"></i> [VI. Processes](https://12factor.net/processes)
 
* WildFly can run stateless application but you will have to design them this way :) 

<i style="color: green;" class="fa fa-solid fa-check"></i> [VII. Port Binding](https://12factor.net/port-binding)

* `8080` for the application, `9990` for the management interface :)  

<i class="fa fa-solid fa-question"></i>  [VIII. Concurrency](https://12factor.net/concurrency)

* Entreprise Java application have traditionally be scaling up so there is some architecture and application changes to make them scale out instead. The lightweight runtime from WildFly is definitely a good opportunity for scaling out Entreprise Java applications.

<i style="color: green;" class="fa fa-solid fa-check"></i> [IX. Disposability](https://12factor.net/disposability)

* WildFly boots fast and gracefully shuts down.

<i style="color: green;" class="fa fa-solid fa-check"></i> [X. Dev/prod parity](https://12factor.net/dev-prod-parity)

* Use the WildFly Maven Plugin to control WildFly, container-based testing to reduce the integration disparity and keep changes between dev, staging and production to a minimum.

<i style="color: green;" class="fa fa-solid fa-check"></i> [XI. Logs](https://12factor.net/logs)

* WildFly outputs everything on the standard output. Optionally, you can use a JSON formatter to query and monitor your application logs.

<i style="color: green;" class="fa fa-solid fa-check"></i>[XII. Admin processes](https://12factor.net/admin-processes)

* WildFly tooling provides CLI scripts to run management operations. You can store them in your codebase to handle configuration changes, migration operations, maintenance operations.

## Conclusion

Using the "cloudy" way to develop and operate entreprise applications unlocks many benefits regardless of the deployment platform (container-based or bare metal).

It can automate most of the mundane tasks that reduce _developer joy & efficiency_ while improving the running operations of WildFly improving _operator joy & efficiency_.