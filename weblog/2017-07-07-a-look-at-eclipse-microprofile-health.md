---
layout: post
title: "A Look At Eclipse MicroProfile Healthcheck"
date: '2017-07-07 12:44:18'
category:
tags:
- work
- java
---

I recently looked at the [Eclipse MicroProfile Healthcheck API][emphc] to investigate its support in [WildFly][wildfly].  
[WildFly Swarm][swarm] is providing the sample implementation so I am very interested to make sure that WildFly and Swarm can both benefit from this specification.

This specification and its API are currently designed and anything written in this post will likely be obsolete when the final version is release. But without further ado...

## Eclipse MicroProfile Healthcheck

The Eclipse MicroProfile Healthcheck is a [specification][spec] to determine the healthiness of an application.
It defines a `HealthCheckProcedure` interface that can be implemented by an application developer. It contains a single method that returns a `HealthStatus`: either `UP` or `DOWN` (plus some optional metadata relevant to the health check).
Typically, an application would provide one or more health check procedures to check healthiness of its parts.
The overall healthiness of the application is then determined by the aggregation of all the procedures provided by the application. If any procedure is `DOWN`, the overall outcome is `DOWN`. Else the application is considered as `UP`.

The specification has a [companion document][protocol] that specifies an HTTP endpoint and JSON format to check the healthiness of an application.

Using the HTTP endpoint, a container can ask the application whether it is healthy.
If it is not healthy, the container can take actions to deal with it. It can decide to stop the application and eventually respin a new instance.
The canonical example is Kubernetes that can configure a [liveness probe][kube] to check this HTTP health URL ([OpenShift][openshift] also exposes this liveness probe).

## WildFly Extension prototype

I have written a prototype of a WildFly extension to support health checks for applications deployed in WildFly *and* some provided directly by WildFly:

[https://github.com/jmesnil/wildfly-microprofile-health](https://github.com/jmesnil/wildfly-microprofile-health)

The `microprofile-health` subsystem supports an operation to check the health of the app server:

```
[standalone at localhost:9990 /] /subsystem=microprofile-health:check
{
    "outcome" => "success",
    "result" => {
        "checks" => [{
            "id" => "heap-memory",
            "result" => "UP",
            "data" => {
                "max" => "477626368",
                "used" => "156216336"
            }
        }],
        "outcome" => "UP"
    }
}
```

It also exposes an (unauthenticated) HTTP endpoint: [http://localhost:8080/health/](http://localhost:8080/health/)

```
$ curl http://localhost:8080/health/
{
   "checks":[
      {
         "id":"heap-memory",
         "result":"UP",
         "data":{
            "max":"477626368",
            "used":"160137128"
         }
      }
   ],
   "outcome":"UP"
}
```

This HTTP endpoint can be used to configure OpenShift/Kubernetes liveness probe.

Any deployment that defines Health Check Procedures will have them registered to determine the overall healthiness of the process. The prototype has a simple example of a Web app that adds a health check procedure that randomly returns `DOWN` (which is not very useful ;).

### WildFly Health Check Procedures

The Healthcheck specification mainly targets user applications that can apply application logic to determine their healthiness.
However I wonder if we could reuse the concepts *inside* the application server (WildFly in my case). There are "things" that we could check to determine if the server runtime is healthy, e.g.:

* The amount of heap memory is close to the max
* some deployments have failed
* Excessive GC
* Running out of disk space
* Some threads are deadlocked

These procedures are relevant regardless of the type of applications deployed on the server.

Subsystems inside WildFly could provide Health check procedures that would be queried to check the overall healthiness.
We could for example provide a health check that the used heap memory is less that 90% of the max:

```java
HealthCheck.install(context, "heap-memory", () -> {
   MemoryMXBean memoryBean = ManagementFactory.getMemoryMXBean();
   long memUsed = memoryBean.getHeapMemoryUsage().getUsed();
   long memMax = memoryBean.getHeapMemoryUsage().getMax();
   HealthResponse response = HealthResponse.named("heap-memory")
      .withAttribute("used", memUsed)
      .withAttribute("max", memMax);
   // status is is down is used memory is greater than 90% of max memory.
   HealthStatus status = (memUsed < memMax * 0.9) ? response.up() : response.down();
   return status;
});
```

## Summary

To better integrate WildFly with Cloud containers such as OpenShift (or Docker/Kunernetes), it should provide a way to let the container checks the healthiness of WildFly. The Healthcheck specification is a good candidate to provide such feature.
It is worth exploring how we could leverage it for user deployments and also for WildFly internals (when that makes sense).

[swarm]: http://wildfly-swarm.io
[emphc]: https://github.com/eclipse/microprofile-health
[spec]: https://github.com/eclipse/microprofile-evolution-process/blob/master/proposals/0003-health-checks.md
[protocol]: https://github.com/eclipse/microprofile-evolution-process/blob/master/proposals/0003-spec.md
[wildfly]: http://wildfly.org
[openshift]: https://docs.openshift.com/enterprise/3.0/dev_guide/application_health.html
[kube]: https://kubernetes.io/v1.0/docs/user-guide/walkthrough/k8s201.html#health-checking
