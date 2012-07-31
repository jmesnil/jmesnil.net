---
date: '2009-09-28 19:49:25'
layout: post
slug: how-books-shape-my-appreciation-of-programming-languages
status: publish
title: How Books Shape My Appreciation of Programming Languages
wordpress_id: '818'
tags:
- book
---

This morning, I read this funny tweet from [@carina][carina]:

> "Javascript in a single picture": [http://short.to/rwo6](http://short.to/rwo6) - absolutely awesome. Not sure if I should laugh or cry now. ;)

<figure>
<img src="#{ site.s3.url }images/2009-09-28-book.jpg" width="400" height="300" />
</figure>

Funny and true: there are few good parts in JavaScript but they are really good!

I first learnt JavaScript by reading ["The Definitive Guide"][js-definitive] and I disliked the language. Browser incompatibilities, different DOM support were not helping too, but I found that the language was not "clean" (kind of object-oriented with this weird prototype thing).

A few years later, I had a renewed interest in JavaScript as a language [running on the JVM][js-jvm]. I also started to use [jQuery][jquery] and I was in awe with this library.
I wanted to be able to read and understand jQuery code. I read ["The Good Parts"][js-good-parts] (that I [reviewed][js-good-parts-review] last year) and, finally, I understood how great JavaScript is and how its features are leveraged by jQuery. The book is small but it gives all the keys to understand and _appreciate_ JavaScript while reading the Definitive Guide felt like reading the yellow pages.

When I want to learn a new programming language, I read a book covering it in paralllel of writing exploratory code. This funny tweet makes me wonder how much the first book I read on a language shapes my thoughts on it.

2<sup>nd</sup> example: Ruby. I learnt Ruby by reading the [pickaxe book][pickaxe] and did not find the language compelling. I thought it was a good scripting language, more readable than Perl, but nothing really stood out. Then I read [Why's (poignant) Guide to Ruby][poignant] and was blown away: I better understood Ruby _mindset_, loved it and started to write some non-trivial code<a id="fnr1-2009-09-28" href="#fn1-2009-09-28"><sup>1</sup></a>.

I am currently "evaluating" two languages: [Clojure][clojure] and [Scala][scala].
I started with Clojure and read [Programming Clojure][programming-clojure] by [Stuart Halloway][stuart]. I really enjoyed the book (I plan to review it in a future entry), its examples are relevant and well-thought and it gives a good insight to understand Clojure mindset. I have started to write some pet projects with Clojure and really enjoy the [experience][readlature].

I have also read [Programming Scala][programming-scala] and I am underwhelmed by the language. It looks like a nicer, evolutionary Java but I do not find it appealing. It may be a fine language but it did not click with me like JavaScript did after reading "The Good Parts" or Ruby after reading Why's "(poignant) guide", or Clojure after reading Stuart's book.  
Programming Scala is a good book to learn Scala syntax, etc. but I do not have a better grasp on Scala mindset after reading it.
Anybody interested in Scala should read it but I can not say that it helped me grasp what makes Scala so great.

I was teased enough reading Programming Clojure to enthusiastically dive deep into  Clojure. The main reason is, of course, the Clojure language itself but a big kudos goes to Stuart and his book which made me wanting to learn more.

This is not a "Scala Vs. Clojure" argument. I plan to add both to my toolset eventually but, in the short term, I will focus on Clojure when I need a functional/concurrent programming language.   
This is not specific to Scala, there are other languages that leave me cold. Python is a fine language but it does not appeal to me<a id="fnr2-2009-09-28" href="#fn2-2009-09-28"><sup>2</sup></a>., I prefer Ruby for similar tasks but I can't objectively explain why it is the case.

The common point of "JavaScript: The Good Parts", Why's "(poignant) Guide to Ruby", and "Programming Clojure" is that they describe well the _mindset_ for their respective languages. I am not interested to write Java code in JavaScript, Ruby or Clojure. I want to understand what makes a language unique, its strengths and weaknesses and how to _think_ in the language. Any book which helps me understand that is a book I wholly recommend.


---

1. <a id="fn1-2009-09-28"></a> [jmx4r][jmx4r] meta code comes straight from Why's dwenthy.rb. Thank again, Why, for all your contributions.&nbsp;<a href="#fnr1-2009-09-28">&#8617;</a>
2. <a id="fn2-2009-09-28"></a> Reading [Dive Into Python 3][dip3] will perhaps change my mind...&nbsp;<a href="#fnr2-2009-09-28">&#8617;</a>


[carina]: http://twitter.com/carina/
[clojure]: http://clojure.org/
[programming-clojure]: http://www.pragprog.com/titles/shcloj/programming-clojure
[scala]: http://www.scala-lang.org/
[programming-scala]: http://www.pragprog.com/titles/vsscala/programming-scala
[pickaxe]: http://www.pragprog.com/titles/ruby/programming-ruby
[poignant]: http://en.wikipedia.org/wiki/Why's_(poignant)_Guide_to_Ruby
[dip3]: http://diveintopython3.org/
[jmx4r]: http://github.com/jmesnil/jmx4r
[readlature]: http://github.com/jmesnil/readlature
[jquery]: http://jquery.com/
[js-jvm]:http://jmesnil.net/weblog/2007/05/23/jmx-scripts-with-eclipse-monkey/
[js-definitive]: http://oreilly.com/catalog/9780596000486
[js-good-parts]: http://oreilly.com/catalog/9780596517748
[js-good-parts-review]: http://jmesnil.net/weblog/2008/05/27/review-of-javascript-the-good-parts/
[stuart]: http://twitter.com/stuarthalloway
[programming-in-scala]: http://www.artima.com/shop/programming_in_scala