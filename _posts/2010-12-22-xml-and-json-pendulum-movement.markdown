---
date: '2010-12-22 22:42:19'
layout: post
slug: xml-and-json-pendulum-movement
status: publish
title: XML and JSON Pendulum Movement
wordpress_id: '1528'
tags:
- xml
---

A few weeks ago, I [linked][link] to [James Clark's post about "XML vs the Web"][clark].

I concluded by writing that:

> I believe than XML (and its associated technologies) will end up as an enterprise technology and a opaque content model (e.g. to save OpenOffice documents) and be less and less prevalent on the Web where HTML (with microformats) and JSON are better suited to represent data.

To sum up very broadly: _XML for document, JSON for data_.

Developers have been bitten by XML shortcomings for _data exchange_ and moved to use JSON instead.
It seems the benefits were (rightly) so convincing that there is now a __pendulum movement__ away from XML and towards JSON for _document representation_. When all you have is a hammer...

Case in point: [Apache Avro][avro].

Avro defines a serialization system. It has very interesting features (rich data structures, binary format, schema inlined in the persisted files, etc.) and one shortcoming: it expresses its schema in JSON.

Here is an example from its documentation:


    
    
    {
      "type": "record", 
      "name": "LongList",
      "aliases": ["LinkedLongs"],                      // old name for this
      "fields" : [
        {"name": "value", "type": "long"},             // each element has a long
        {"name": "next", "type": ["LongList", "null"]} // optional next element
      ]
    }
    



Today, I spent too much time for the simple task of writing a schema in JSON to represent a map whose values were arrays of strings.


The signal-to-noise ratio when JSON is used to represent a schema is different to XSD or RelaxNG but not better.  
Simple schemas are simple to express but the signal-to-noise ratio increases tenfold with the complexity of the schema. Funnily enough, XML Schema have an advantage here: they are very complex for the simplest schema but their ratio increases linearly with the schema complexity.

I don't think JSON is well suited to represent a document schema. A DSL is a better tool for this.
For example, Google [Protocol Buffers][protobuf] uses a simpler format to define their schema:

    message Person {
      required int32 id = 1;
      required string name = 2;
      optional string email = 3;
    }

I have not used protocol buffers enough to see how it changes with schema complexity but, at first glance, I expect it to remain more readable that a comparable JSON schema.

The difference between document and data depends on the use cases (you know it when you see it). But using JSON to represent a schema is a general step in the wrong direction to me. A DSL is a better tool for that.

 After the "document representation" pendulum will have moved towards JSON too much and expose its shortcomings, I expect it to move again, away from JSON and towards DSL. Time will tell...

[link]: http://jmesnil.net/weblog/2010/11/30/james-clark-xml-vs-the-web/
[clark]: http://blog.jclark.com/2010/11/xml-vs-web_24.html
[greogorio]: http://bitworking.org/news/2010/12/json-xml-web
[avro]: http://avro.apache.org
[protobuf]: http://code.google.com/p/protobuf/
