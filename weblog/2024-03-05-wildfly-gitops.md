---
layout: post
title: "WildFly - The GitOps Way"
date: '2024-03-05 11:54:32'
tags:
- development
- gitops
---

We have improved the Maven plug-in for [WildFly][wildfly] to be able to provision and configure WildFly application server directly from the application source code.
This make it very simple to control the server configuration and management model and make sure it is tailor-made for the application requirements.

This is a good model for DevOps team where a single team is responsible for the development and deployment of the application.

However, we have users that are in a different organisational structure where the Development team and the Operational team work in silos.

In this article, we will show how it is possible to leverage the WildFly Maven plugin to handle the configuration and deployment of WildFly separately from the application development in a loose __GitOps__ manner.

## Provision the WildFly Server

We will use a Maven project to control the application server installation and configuration.

```bash
mkdir wildfly-gitops
cd wildfly-gitops
touch pom.xml
```

The `pom.xml` will configure the provisioning and configuration of WildFly

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>org.wildfly.gitops</groupId>
  <artifactId>wildfly-gitops</artifactId>
  <version>1.0.0-SNAPSHOT</version>

  <packaging>pom</packaging>
  <properties>
    <!-- Specify the version of WildFly to provision -->
    <version.wildfly>31.0.0.Final</version.wildfly>
    <version.wildfly.maven.plugin>4.2.2.Final</version.wildfly.maven.plugin>
  </properties>

  <build>
    <plugins>
      <plugin>
        <groupId>org.wildfly.plugins</groupId>
        <artifactId>wildfly-maven-plugin</artifactId>
        <version>${version.wildfly.maven.plugin}</version>
        <configuration>
          <feature-packs>
            <feature-pack>
              <groupId>org.wildfly</groupId>
              <artifactId>wildfly-galleon-pack</artifactId>
              <version>${version.wildfly}</version>
            </feature-pack>
          </feature-packs>
        </configuration>
        <executions>
          <execution>
            <id>provision-widfly</id>
            <phase>package</phase>
            <goals>
              <goal>provision</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>
</project>
```

This `pom.xml` will provision (install and configure) WildFly. The version
of WildFly is configured with the `version.wildfly` property (set `31.0.0.Final` in the snippet above).

Let's now install it with:

```bash
mvn clean package
```

Once the execution is finished, you have a WildFly server ready to run in `target/server` and you can run it with the command:

```bash
cd target/server
./bin/standalone.sh
```

The last log will show that we indeed installed WildFly 31.0.0.Final:

```
13:21:52,651 INFO  [org.jboss.as] (Controller Boot Thread) WFLYSRV0025: WildFly Full 31.0.0.Final (WildFly Core 23.0.1.Final) started in 1229ms - Started 280 of 522 services (317 services are lazy, passive or on-demand) - Server configuration file in use: standalone.xml
```

At this point you can init a Git repository from this  `wildfly-gitops` directory and you have the foundation to manage WildFly in a GitOps way.

The Maven Plugin for WildFly provides rich features to configure WildFly including:

* using [Galleon Layers][galleon-layers] to trim the server according to the deployment capabilities
* Running CLI scripts to configure its subsystems (for example, the [Logging Guide][logging-guide] illustrates how you can add a Logging category for your own deployments)

# [Aside] Create Application Deployments 

To illustrate how to manage the deployments of application in this server without direct control of the application source code, we must first create these deployments.

When Dev and Ops teams are separate, the Dev team will have done these steps and the Ops team would only need to know the Maven coordinates of the deployments.

For this purpose, we will compile and install 2 quickstarts examples from WildFly in our local maven repository:

```bash
cd /tmp
git clone --depth 1 --branch 31.0.0.Final https://github.com/wildfly/quickstart.git
cd quickstart
mvn clean install -pl helloworld,microprofile-config
```

We have only built the `helloworld` and `microprofile-config` quickstarts and put them in our local Maven repository.

We now have two deployments that we want to deploy in our WildFly Server with the Maven coordinates:

* `org.wildfly.quickstarts:helloworld:31.0.0.Final`
* `org.wildfly.quickstarts:microprofile-config:31.0.0.Final`

# Assemble The WildFly Server With Deployments

Now that we have deployments to work with, let's see how we can include them in our WildFly server in a GitOps manner.

We will use a Maven assembly  to control the deployments in our server.
To do so, we will create a `assembly.xml` file in the `wildfly-gitops` directory:

```xml
<assembly xmlns="http://maven.apache.org/ASSEMBLY/2.1.1"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/ASSEMBLY/2.1.1 http://maven.apache.org/xsd/assembly-2.1.1.xsd">
  <id>gitops-server</id>
  <formats>
    <format>dir</format>
  </formats>
  <fileSets>
    <fileSet>
      <directory>target/server</directory>
      <outputDirectory/>
    </fileSet>
  </fileSets>
    
  <dependencySets>
    <dependencySet>
      <includes>
        <include>*:war</include>
      </includes>
      <outputDirectory>standalone/deployments</outputDirectory>
      <outputFileNameMapping>${artifact.artifactId}.${artifact.extension}</outputFileNameMapping>
    </dependencySet>
  </dependencySets>
</assembly>
```

All this verbose file does is:

* create a directory that is composed of:
  * the content of the `target/server` (that contains the WildFly Server)
  * add any `war` dependency to the `standalone/deployments` of this directoy
    * and rename them to `xxx.war` (instead of the whole Maven coordinates)

We also need to update the `pom.xml` to use this assembly:

```xml
<project>
  [...]
  <build>
    [...]
    <plugins>
      [...]
      <plugin>
        <artifactId>maven-assembly-plugin</artifactId>
        <configuration>
          <finalName>wildfly</finalName>
        </configuration>
        <executions>
          <execution>
            <id>make-assembly</id>
            <phase>package</phase>
            <goals>
              <goal>single</goal>
            </goals>
            <configuration>
              <descriptors>
                <descriptor>assembly.xml</descriptor>
              </descriptors>
            </configuration>
          </execution>
        </executions>
      </plugin>
  [...]
</project>
```

We can now run a Maven command to assemble our server:

```bash
mvn clean package
```

When the command is finished, we now have an assembled server in `target/wildfly-gitops-server/wildfly`

```bash
cd target/wildfly-gitops-server/wildfly
./bin/standalone.sh
```

---
**NOTE**: There are 2 different "servers" after `mvn package` is executed:

* `target/server` contains the provisioned WildFly Server
* `target/wildfly-gitops-server/wildfly` contains the WildFly server (copied from the previous directory) with any additional deployments.

But we did not add any deployment! Let's do it now.

---


In the `wildfly-gitops/pom.xml`, we will add a `dependency` to specify that we want to include the `helloworld` quickstart:

```xml
<project>
  [...]
  <dependencies>
    <dependency>
      <groupId>org.wildfly.quickstarts</groupId>
      <artifactId>helloworld</artifactId>
      <version>31.0.0.Final</version>
      <type>war</type>
    </dependency>
  </dependencies>
```

And that's it!

Let's now run once more `mvn clean package`.

If we now list the `standalone/deployments` directory of the assembled server, the `helloworld.war` deployment is listed:

```bash
ls target/wildfly-gitops-server/wildfly/standalone/deployments
README.txt                      helloworld.war
```

When we run the assembled server, the HelloWorld application is deployed and ready to run:

```bash
cd target/wildfly-gitops-server/wildfly
./bin/standalone.sh

...
14:01:25,307 INFO  [org.jboss.as.server] (ServerService Thread Pool -- 45) WFLYSRV0010: Deployed "helloworld.war" (runtime-name : "helloworld.war")
```

We can access the application by opening our browser at [localhost:8080/helloworld/](http://localhost:8080/helloworld/)

At this stage, we have complete control of the WildFly server and the application(s) we want to deploy on it from this `wildfly-gitops` Git repository.

Let's see what we could do from here.

# Add Another Deployment to The Server

We can now add the `microprofile-config` deployment to the assembled server by adding it as a `dependency` in the `pom.xml`:

```xml
<project>
  [...]
  <dependencies>
    [...]
    <dependency>
      <groupId>org.wildfly.quickstarts</groupId>
      <artifactId>microprofile-config</artifactId>
      <version>31.0.0.Final</version>
      <type>war</type>
    </dependency>
  </dependencies>
```

Let's package the server again and start it:

```bash
mvn clean package
cd target/wildfly-gitops-server/wildfly
CONFIG_PROP="Welcome to GitOps" ./bin/standalone.sh
```

The `microprofile-config` application is deployed and can be accessed from [localhost:8080/microprofile-config/config/value](http://localhost:8080/microprofile-config/config/value)

We have added deployments using Maven dependencies but it is also possible to include them in the assembled server by other means (copy them from a local directory, fetch them from Internet, etc.). The [Assembly Plugin][assembly-plugin] provides additional information for this.

# Update The WildFly Server

The version of WildFly that we are provisioning is specified in the `pom.xml` with the `version.wildfly` property. Let's change it to use a more recent version of WildFly 31.0.1.Final

```xml
<project>
  [...]
  <properties>
    <!-- Specify the version of WildFly to provision -->
    <version.wildfly>31.0.1.Final</version.wildfly>
```

We can repackage the server and see that it is now running WildFly 31.0.1.Final:

```bash
mvn clean package
cd target/wildfly-gitops-server/wildfly
...
14:15:23,909 INFO  [org.jboss.as] (Controller Boot Thread) WFLYSRV0025: WildFly Full 31.0.1.Final (WildFly Core 23.0.3.Final) started in 1938ms - Started 458 of 678 services (327 services are lazy, passive or on-demand) - Server configuration file in use: standalone.xml
```

# Use Dependabot to Be Notified of WildFly Updates

WildFly provisioning is using Maven artifacts. We can take advantage of this to add a "symbolic" dependency to one of this artifact in our `pom.xml` so that Dependabot will periodically check and propose updates when new versions of WildFly are available:

```xml
<project>
  [...]
  <dependencies>
    [...]
    </dependency>
      <!-- We add the WildFly Galleon Pack as a provided POM dependency
           to be able to  use dependabot to be notified of updates -->
      <dependency>
        <groupId>org.wildfly</groupId>
        <artifactId>wildfly-galleon-pack</artifactId>
        <version>${version.wildfly}</version>
        <type>pom</type>
        <scope>provided</scope>
      </dependency>
```

We use a `provided` scope as we don't want to pull this dependency but this will ensure that Dependabot is aware of it and triggers updates when a new version is available.

# Summary

In this article, we show how you can leverage the WildFly Maven Plug-in to manage WildFly in a GitOps way that is not directly tied to the development of the applications that are be deployed to the server.

The code snippets used in this article are available on GitHub at [github.com/jmesnil/wildfly-gitops](https://github.com/jmesnil/wildfly-gitops).

[wildfly]: https://wildfly.org
[logging-guide]: https://www.wildfly.org/guides/application-logging#configure-logging-in-the-wildfly-subsystem
[galleon-layers]: https://docs.wildfly.org/31/Galleon_Guide.html#wildfly_galleon_layers
[assembly-plugin]: https://maven.apache.org/plugins/maven-assembly-plugin/