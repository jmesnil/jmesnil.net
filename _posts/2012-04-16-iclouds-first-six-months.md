---
layout: post
title: "iCloud's First Six Months"
date: '2012-04-16 15:11:20'
link: http://www.macstories.net/stories/iclouds-first-six-months-the-developers-weigh-in/
---

> The past six months have also shown that, without proper developer tools and a clear explanation of how things work in backend, things don’t “just work” — in fact, quite the opposite: some developers have given up entirely on building iCloud apps for now, others are wishing for new APIs that would make the platform suitable to their needs, while the ones who did implement iCloud in their apps are torn better the positive feedback of “it just works” users, and the frustration of those struggling to keep their data in sync on a daily basis.

I played a little bit with [iCloud][icloud] on a iOS personal project. Unsurprisingly, it is _hard_ to get syncing right.


It was obvious from the start that supporting iCloud would not been easy. There are many [fallacies][fallacies] to avoid once an application depends on the network (especially when it is as unreliable and spotty as a cellular network) and version conflict resolution works best with a deep knowledge of your domain.

Apple documentation for iCloud is too high-level to be helpful. The best resources I found about iCloud development are lectures 17 &amp; 18  of [Stanford's iPad and iPhone Application Development by Paul Hegarty][stanford]. These lectures give the correct mindset to comprehend and work with iCloud.

Supporting iCloud is not an easy task and it requires to _really_ think about it. It is not just about dropping files in a directory. However when it works seamlessly, it improves and simplifies the user experience. The user benefit is worth the developer pain. With the release of [Mountain Lion][mountain-lion] I expect Apple to continue to improve iCloud API and features and make more developer resources available as they learn from adding iCloud to their own apps.

(via [The Loop][loop])

[fallacies]: http://en.wikipedia.org/wiki/Fallacies_of_Distributed_Computing
[icloud]: https://developer.apple.com/icloud/index.php
[stanford]: http://itunes.apple.com/us/itunes-u/ipad-iphone-application-development/id473757255
[loop]: http://www.loopinsight.com/
[mountain-lion]: http://www.apple.com/macosx/mountain-lion/features.html#icloud
