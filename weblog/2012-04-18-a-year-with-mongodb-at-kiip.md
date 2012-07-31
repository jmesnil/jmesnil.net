---
layout: post
title: "A Year With MongoDB at Kiip"
date: '2012-04-18 12:11:08'
link: http://blog.engineering.kiip.me/post/20988881092/a-year-with-mongodb
---

> Over the past 6 months, we've "scaled" MongoDB by moving data off of it. [...]
>  For key-value data, we switched to Riak, which provides predictable read/write latencies and is completely horizontally scalable. For smaller sets of relational data where we wanted a rich query layer, we moved to PostgreSQL.

As usual, take this with a grain of salt (performance varies with data size, use cases, read/write ratio, etc).

I had a short experience developing with [MongoDB][mongodb] and I like it. Unfortunately, I had not the opportunity to see how it behave in production use.

[mongodb]: http://www.mongodb.org/
