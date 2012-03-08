---
date: '2009-08-19 14:07:22'
layout: post
slug: how-clojure-forces-me-to-rewire-my-brain-in-a-good-way
status: publish
title: How Clojure Forces Me to Rewire My Brain (In a Good Way)
wordpress_id: '712'
tags:
- misc
---

Part of my process to learn a new language is to write an application/library complex enough to be confronted with interesting challenges.

My current learning language is [Clojure][clojure] and I am writing a web application using the [Compojure][compojure] framework.

I was confronted with a simple challenge recently.
I had a map containing HTTP parameters, all of the values being either strings or `nil`:


{% highlight clojure %}    
    ;; my HTTP parameters
    user=>(def params {:a "true" :b nil :c "false" :d "3"})
    #'user/params
    user=>(params :a)
    -> "true"
    user=>(params :b)
    -> nil
    user=>(params :d)
    -> "3"
{% endhighlight %}    
    



If you are not familiar with Clojure:

* the character `;` is used for comment 
* `user=>` is the prompt where you type the code  
* `->` is the result of the evaluation. For example `(params :a)` evaluates to the string `"true"` 
* `:a` is a symbol. It is used to identify keys in the map
* evaluating `(m k)` returns the value associated to the key `k` in the map `m`.

I have a map with values which are either strings or nil.  
But I want to persist these parameters in my storage with _types_. For example, values of `:a` and `:b` must be stored as booleans, and value of `:d` as a double.

{% highlight clojure %}    
    ; I want to persist:
    (def persisted-params {:a true :b nil :c false :d 3.0})
{% endhighlight %}    



How can I do that using Clojure?<sup id="fnr1-2009-08-19"><a href="#fn1-2009-08-19">1</a></sup>

First, I want a function which will return the map with the value of
a key replaced by a boolean if the value is not nil:

{% highlight clojure %}    
    (defn to-b
      "replace the value of key in the map by a Boolean instance if the value is not nil"
      [map key]
      (if (not (nil? (map key)))
        (assoc map key (Boolean. (map key)))
        map))
{% endhighlight %}    
    
Once you know the Clojure idioms, the code is straightforward: 

> if the value of key in the map  - `(map key)` - is not nil, returns the map with the key associated to the value - `(Boolean. (map key))` -, else return the map unchanged - `map` -.

Another Clojure idiom:

* `(Boolean. value)` corresponds to calling the java.lang.Boolean contructor with the specified value.

Let's try it:

{% highlight clojure %}    
    user=> (to-b params :a)
    -> {:a true, :b nil, :c "false", :d "3"}
    user=> (to-b params :b)
    -> {:a "true", :b nil, :c "false", :d "3"}
    user=> (to-b params :c)
    -> {:a "true", :b nil, :c false, :d "3"}
{% endhighlight %}    
    



It works: when we call it on `:a` it changes its value from the String `"true"` to the boolean `true`. It does the same for `:c` but it did not change the value of `:b` which is `nil`.

Second step is to call this function, not for a single key, but for a list of keys and returns the map where all the values corresponding to the keys' list have been "booleanified". Clojure provides a basic function for that: `reduce`.

{% highlight clojure %}    
    (defn booleanify [map klist]
      "Replace all the non-nil values in the map for the keys in klist by their Boolean equivalent"
      (reduce to-b map klist))
{% endhighlight %}    

Starting with `map` as the initial value, `reduce` will return the result of applying `to-b` to to the map and the first item of `klist`, then apply `to-b` to that result and the 2nd item, etc.
This works as we expect:

{% highlight clojure %}    
    ; booleanify nothing
    user=> (booleanify params [])        
    -> {:a "true", :b nil, :c "false", :d "3"}
    
    ; booleanify value of :a
    user=> (booleanify params [:a])      
    -> {:a true, :b nil, :c "false", :d "3"}
    
    ; booleanify values of :a :b & :c
    user=> (booleanify params [:a :b :c])
    -> {:a true, :b nil, :c false, :d "3"}
{% endhighlight %}    



That's good: I have solved my problem for the boolean fields.
But I wanted to also have a double type for `:d`.

How can I leverage what I have just done for the booleans?

This is very similar to my previous problem, the only changing part is the function used to modify the value.
Let's rewrite `booleanify` using a more general function `modify-values`:

{% highlight clojure %}    
    (defn modify-values [map fun klist]
      "Apply a fun to the non-nil values in the map for the keys in klist"
      (reduce
        (fn [m k]
          (if (not (nil? (m k)))
            (assoc m k (fun (m k)))
            m))
        map klist))
    
    ; booleanify call modify-values with a anonymous function to create booleans:
    (defn booleanify [map klist]
      (modify-values map #(Boolean. %) klist))
{% endhighlight %}    


Another Clojure idiom:

* `#(Boolean. %)` is an anonymous function which invokes the java.lang.Boolean constructor with a parameter

This is "almost" plain english: to booleanify a list, we modify the values in map and replace them with Boolean instances for all the keys in the list (although the name `modify-values` is ill-suited: the original map is never modified, instead the function builds a _new map_ from the content of the original one).

It is now straightforward to "doublify" `:d`:

{% highlight clojure %}    
    (defn doublify [map klist]
      (modify-values map #(Double. %) klist))
{% endhighlight %}    

This works as expected:

{% highlight clojure %}    
    user=> (doublify params [:d])
    -> {:a "true", :b nil, :c "false", :d 3.0}
{% endhighlight %}    
    
I like the way `modify-values` is written, it _almost_ reads like English<sup id="fnr2-2009-08-19"><a href="#fn2-2009-08-19">2</a></sup>:

> accumulate - `reduce` - in the map the  association  - `assoc` - of the key - `k` - and a new value - `(fun (m k)))` - or the unchanged map - `m` - if the value is nil, and do this for all the keys in the list - `klist` -.

Simple, isn't it?  
...  
Alright, I admit it: this is a lie: This is __not__ the way I solved this problem and found the final code.


I would have followed this reasoning if my brain was used to declarative languages, but that's not the case.
I'm so accustomed to think imperatively (using Java) that I was not able to figure out how I want to solve this problem "functionally".

What I really did was look at the source of a function with a similar behavior, `rename-keys`, which was returning a map with some renamed keys. I realized this was the same kind of a behavior than mine, except that I wanted to "rename" values rather than keys.
I studied the function and when I understood it, I was finally able to know how I wanted to write `booleanify`.

While I found the final code elegant and simple, writing it was anything but straightforward.  
It seems this is my major obstacle to use Clojure. The language is good, the documentation is good, the book - [Programming Clojure][prog-clojure] - is a great introduction (I plan to review it later) but my brain is not good at thinking declaratively.
I need to rewire my brain to adapt it to solve problems using functional languages such as Clojure.

I rarely think "declaratively" in my daily job using Java. I started thinking this way when I learnt Ruby and Javascript (closures and functions as 1st class-citizen). With these languages, I am still able to fall back to imperative statements if I was not able to solve a problem functionally (or if that does not make sense to do it that way).  
With Clojure, it is more difficult.

To complement this exerice, I wrote a solution in Java too:

{% highlight java %}    
    public class MapTest extends TestCase {
    
       public void testMap() {
          Map params = new HashMap();
          params.put("a", "true");
          params.put("b", null);
          params.put("c", "false");
          params.put("d", "3.0");
    
          assertEquals("true", params.get("a"));
          assertNull(params.get("b"));
          assertEquals("false", params.get("c"));
          assertEquals("3.0", params.get("d"));
    
          Map booleanified = booleanify(params, "a", "b", "c");
          assertEquals(true, booleanified.get("a"));
          assertNull(booleanified.get("b"));
          assertEquals(false, booleanified.get("c"));
    
          Map doublified = doublify(params, "d");
          assertEquals(3.0, doublified.get("d"));
       }
    
       private static Map booleanify(Map params, String... keys) {
          return modify(params, new Modifyable() {
             public Object modify(Object original) {
                return new Boolean(original.toString());
             }
          }, keys);
       }
    
       private static Map doublify(Map params, String... keys) {
          return modify(params, new Modifyable() {
             public Object modify(Object original) {
                return new Double(original.toString());
             }
          }, keys);
       }
    
       private static Map modify(Map params, Modifyable fun, String... keys) {
          for (String key : keys) {
             Object value = params.get(key);
             if (value != null) {
                params.put(key, fun.modify(value));
             }
          }
          return params;
       }
    
       private interface Modifyable {
          public Object modify(Object original);
       }
{% endhighlight %}   



I find Clojure code more simple, elegant *and* powerful than the corresponding Java solution (albeit more difficult to read at fist glance).  I wrote the Java code after the Clojure code and it shows. Had I started thinking in Java, it is likely my code would have been different.
I would have _designed_ the code differently to avoid that challenge in the first place (e.g. using explicit parameters instead of a Map and typify at the top of the chain).


I also find interesting that the declarative language (Clojure) is closer to the natural language (English) I used to describe the problem and, still, my first instinct is to translate it in an imperative language (Java) first<sup id="fnr3-2009-08-19"><a href="#fn3-2009-08-19">3</a></sup>.


I sometimes uses this type of "functional" Java code in test cases when I want to have common code and a simple change in behavior in many tests but I rarely use it in production code.

Learning Clojure is a fun exercise as I have a special fondness for Lisp and its ability to express data and code together.  
But the important part of this exercise is to increase my ability to solve problems, to learn to think differently (to think "declaratively" in addition to "imperatively") to approach challenges from different angles and have an open mindset to solve them. That's the fun part of software engineering.



---

1. <a id="fn1-2009-08-19"></a>That I find this a _challenge_ really shows my inexperience with Clojure and functional languages...&nbsp;<a href="#fnr1-2009-08-19"  class="footnoteBackLink"  title="Jump back to footnote  in the text.">&#8617;</a>
2. <a id="fn2-2009-08-19"></a>English is not my native language. As you can see, I am very open-minded on what reads like English! &nbsp;<a href="#fnr2-2009-08-19"  class="footnoteBackLink"  title="Jump back to footnote  in the text.">&#8617;</a>
3. <a id="fn3-2009-08-19"></a>I am reading [Gödel, Bach, Escher][geb] and pay lot of attention these days to the relations between languages.&nbsp;<a href="#fnr3-2009-08-19"  class="footnoteBackLink"  title="Jump back to footnote  in the text.">&#8617;</a>

[clojure]: http://clojure.org/
[compojure]: http://github.com/weavejester/compojure/
[prog-clojure]: http://www.pragprog.com/titles/shcloj/programming-clojure
[geb]: http://en.wikipedia.org/wiki/Gödel,_Escher,_Bach
