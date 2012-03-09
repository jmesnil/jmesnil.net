---
date: '2010-09-23 21:38:28'
layout: post
slug: how-to-handle-events-when-the-user-taps-a-mkmapview
status: publish
title: How to Handle Events When the User Taps a MKMapView
wordpress_id: '1199'
tags:
- apple
---

For a iPhone application I am writing on my spare time, I have added a `MKMapView` which displays a small map with a fixed coordinate.  
The `MKMapView` does not allow user interaction, it is for information purpose only, to give some geolocation context. However, I want the user to be able to tap the map view to open it full screen and interact with it (zoom, scroll or open it in Maps).
The idea is very similar to geolocated tweet in Twitter for iPhone.

The issue I encountered is that `MKMapView` captures user events and there is no way to retrieve them (subclassing `MKMapView` is discouraged).
I searched for a solution on internet to know when the user taps the `MKMapView` but none of the solution were simple enough (or elegant enough) to my liking.

I ended up solving it using a `UIView` and a block.

The basis of the solution is to add a `UIView` on top of the `MKMapView` to handle the `touchesBegan:withEvent:` method when the user taps on the map view (or so he thinks...).  
When this `UIView`'s `touchesBegan:withEvent:` method is called, we call a block passed by my main `UIViewController`. This allows to keep all the logic inside the main view controller.

This solutions requires few lines of code and no changes to the NIB file.

In the NIB file, I just placed a `MKMapView` (with zoom and scroll disabled) that is connected to its controller through an `IBOutlet`.  
I added a `mapTouchView` which is _not_ an `IBOutlet`, it will be created and configured directly from the code.

{% highlight objc %}
// MyController.h

#import <MapKit/MapKit.h>

@interface MyController : UIViewController {
    IBOutlet MKMapView *mapView;
    UIView* mapTouchView
}

@end
{% endhighlight %}

In the implementation file, I create an instance of a `MapTouchView` in the _initialization method_:

{% highlight objc %}
// MyController.m

#import "MapTouchView.h"

@implementation MyController
    
- (void)displayFullMap {
    NSLog(@"user has tapped the map");
    ...
}

- (id)init {
    ...
    mapTouchView = [[MapTouchView alloc] initWithBlockForTouchesBegan:^(NSSet *touches, UIEvent *event) {
       [self displayFullMap];
    }];

    return self;
}
{% endhighlight %}

The `MapTouchView`'s _initialization method_ takes a block that will be called when its `touchesBegan:withEvent:` method is called.  
In this case, when that happens, `MyController` will call its own `displayFullMap` method.

In `MyController`'s `viewDidLoad`, we make sure to insert the `mapTouchView` __above__ the `mapView`:

{% highlight objc %}
- (void)viewDidLoad {
    [super viewDidLoad];
    ...
    [self.view insertSubview:mapTouchView aboveSubview:mapView];
}
{% endhighlight %}

And when the view will appear, we update the `mapTouchView`'s `frame` with the `mapView`'s `frame`:

{% highlight objc %}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ...
    mapTouchView.frame = mapView.frame;
 }
{% endhighlight %}

With these few lines, we have displayed an _invisible_ `UIView` on top of the `MKMapView`.
To verify this, you can change the background color of `mapTouchView` in `viewDidLoad`:

{% highlight objc %}
mapTouchView.backgroundColor = [UIColor orangeColor];
{% endhighlight %}

Instead of the map, an orange box will be displayed.
    
It is important to note that no event will be passed to `MKMapView` but that was acceptable  as I have disabled user interactions on it anyway.

The `MapTouchView` class is deceptively simple:

{% highlight objc %}
// MapTouchView.h
    
#import <UIKit/UIKit.h>

@interface MapTouchView : UIView {
   void (^block)(NSSet *, UIEvent *);
}

- (id)initWithBlockForTouchesBegan:(void (^)(NSSet *, UIEvent *))aBlock;

@end
{% endhighlight %}

We keep a `block` attribute which is set in the _initialization method_ and will be called when the user touches the view.
The implementation is straightforward too:

{% highlight objc %}
// MapTouchView.m

#import "MapTouchView.h"

@implementation MapTouchView

- (id)initWithBlockForTouchesBegan:(void (^)(NSSet *, UIEvent *))aBlock {
    if (self = [super init]) {
        block = [aBlock copy];
    }
    return self;
}

- (void)dealloc {
    [block release];
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   block(touches, event);
}

@end
{% endhighlight %}

When the _initialization method_ is called, we copy the `block` passed in argument.  
When the `touchesBegan:withEvent:` method is called, we call the block passing the method's arguments.

In my controller's case, I don't need any of these arguments but I preferred to have the block's argument match the event method arguments so that this `MapTouchView` can be reused in other contexts which requires them (to know the tap count for example).

This solution is simple (and reusable), all the logic remains in `MyController` and `MapTouchView` does not contain any code specific to my application.
It would be possible to make `MapTouchView` even more generic (e.g. have the block return a `BOOL` to determine if the event must be passed to the map view, implement other event methods, etc.) but it solves my problem as it is.

It was also the opportunity to use blocks in iOS and it is a great new tool that I have added to my toolbox to write simpler, more elegant code.

