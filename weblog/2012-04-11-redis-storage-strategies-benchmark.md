---
layout: post
title: "Redis Storage Strategies Benchmark"
date: '2012-04-11 15:46:19'
category: 
tags: []
link: http://www.tomslabs.com/index.php/2012/04/a-little-redis-storage-strategies-benchmark/
---

An analysis of using Redis to store data by my former colleague [Brice Laurencin][brissou]:
> Do not over think your data schema when storing to Redis, it is faster than you may think, and a simple software compression may help you contain your data growth.

I have used a little [Redis][redis] for a pet project and it is a great key/value store. Its [sorted set][sset] data structure is invaluable to store time-based data.

[redis]: http://redis.io/
[sset]: http://redis.io/commands#sorted_set
[brissou]: https://twitter.com/brisssou
