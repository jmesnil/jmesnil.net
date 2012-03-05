---
date: '2004-11-08 14:57:25'
layout: post
slug: stringified-representation-of-arrays-in-java
status: publish
title: ⚑ Stringified representation of arrays in Java
wordpress_id: '55'
tags:
- java
---

When you call the `toString()` method on an array in Java, you don't get an useful representation:

    
    <code><verbatim>Object[] foo = {"bar", "baz"};
    System.out.println(foo);
    
    >>> [Ljava.lang.Object;@e0b6f5</verbatim></code>


I used to create my own representation of the array:

    
    <code><verbatim>StringBuffer buff = new StringBuffer("[");
    for (int i = 0; i < foo.length; i++) {
       if (i > 0) {
          buff.append(", ");
       }
       buff.append(foo[i]);
    }
    buff.append("]");
    System.out.println(buff.toString());
    
    >>> ["bar", "baz"]</verbatim></code>


But I recently discovered that the [Collections Framework](http://java.sun.com/j2se/1.4.2/docs/guide/collections/overview.html) already offers this function:

    
    <code>System.out.println(<a href="http://java.sun.com/j2se/1.4.2/docs/api/java/util/Arrays.html#asList(java.lang.Object[])">Arrays.asList(foo)</a>);
    
    >>> ["bar", "baz"]</code>


The trick is that you rely on the stringified representation of a `[List](http://java.sun.com/j2se/1.4.2/docs/api/java/util/List.html)` to get the stringified representation of the array.

