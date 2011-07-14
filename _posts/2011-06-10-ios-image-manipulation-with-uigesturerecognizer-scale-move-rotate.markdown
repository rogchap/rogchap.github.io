---
layout: post
title: "iOS Image Manipulation with UIGestureRecognizer: scale, move, rotate"
---

I promised to share with you my code that I used on the [Twibbon iPhone app](http://itunes.apple.com/us/app/twibbon/id441719849?mt=8&ls=1#), to manipulate images using touch gestures. This solution uses `UIGestureRecognizer`s and therefore only work in iOS 3.2 and above. The full source to a sample applications is available at the end.

## Setting up the UI

On your main view you first want to set up an `UIView` that will act as your canvas. This canvas will contain your `UIImageView` for your photo. Setting the canvas view to *Clip Subviews* will make sure that your photo view will be masked inside of the canvas.

## Create your UIGestureRecognizers

Once we have set up the basic UI we then need to make sure our app responds to your touch gestures on the screen, like so:

{% highlight objc %}
- (void)viewDidLoad {
	[super viewDidLoad];

	UIPinchGestureRecognizer *pinchRecognizer = [[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)] autorelease];
	[pinchRecognizer setDelegate:self];
	[self.view addGestureRecognizer:pinchRecognizer];

	UIRotationGestureRecognizer *rotationRecognizer = [[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)] autorelease];
	[rotationRecognizer setDelegate:self];
	[self.view addGestureRecognizer:rotationRecognizer];

	UIPanGestureRecognizer *panRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)] autorelease];
	[panRecognizer setMinimumNumberOfTouches:1];
	[panRecognizer setMaximumNumberOfTouches:1];
	[panRecognizer setDelegate:self];
	[canvas addGestureRecognizer:panRecognizer];

	UITapGestureRecognizer *tapProfileImageRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)] autorelease];
	[tapProfileImageRecognizer setNumberOfTapsRequired:1];
	[tapProfileImageRecognizer setDelegate:self];
	[canvas addGestureRecognizer:tapProfileImageRecognizer];
}
{% endhighlight %}

You'll notice that the pinch and rotate actions have been added to the whole view whereas the move has only been added to the `canvas`; this is because I felt that it gives a better user experience especially as it gives the user more screen to use two fingers.

## Hook up the manipulation methods

Once we have the gestures set up we can now use some animation to manipulate the photo based on the users touch gestures:

{% highlight objc %}
-(void)scale:(id)sender {

    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
      _lastScale = 1.0;
    }

    CGFloat scale = 1.0 - (_lastScale - [(UIPinchGestureRecognizer*)sender scale]);

    CGAffineTransform currentTransform = photoImage.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);

    [photoImage setTransform:newTransform];

    _lastScale = [(UIPinchGestureRecognizer*)sender scale];
    [self showOverlayWithFrame:photoImage.frame];
}

	-(void)rotate:(id)sender {

    if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {

      _lastRotation = 0.0;
      return;
    }

    CGFloat rotation = 0.0 - (_lastRotation - [(UIRotationGestureRecognizer*)sender rotation]);

    CGAffineTransform currentTransform = photoImage.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);

    [photoImage setTransform:newTransform];

    _lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
    [self showOverlayWithFrame:photoImage.frame];
}


-(void)move:(id)sender {

  CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:canvas];

  if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
    _firstX = [photoImage center].x;
    _firstY = [photoImage center].y;
  }

  translatedPoint = CGPointMake(_firstX+translatedPoint.x, _firstY+translatedPoint.y);

  [photoImage setCenter:translatedPoint];
  [self showOverlayWithFrame:photoImage.frame];
}

-(void)tapped:(id)sender {
  _marque.hidden = YES;
}
{% endhighlight %}

# Added bonus code snipet: selection marque overlay

You'll notice in some of the code above making reference to a `_marque`, This is the *marching ants* you see when you have selected the photo and allows you to easily see the boundary line of the image. 

First we set up a `CAShapeLayer` object using QuartzCore:

{% highlight objc %}
if (!_marque) {
	_marque = [[CAShapeLayer layer] retain];
	_marque.fillColor = [[UIColor clearColor] CGColor];
	_marque.strokeColor = [[UIColor grayColor] CGColor];
	_marque.lineWidth = 1.0f;
	_marque.lineJoin = kCALineJoinRound;
	_marque.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:5], nil];
	_marque.bounds = CGRectMake(photoImage.frame.origin.x, photoImage.frame.origin.y, 0, 0);
	_marque.position = CGPointMake(photoImage.frame.origin.x + canvas.frame.origin.x, photoImage.frame.origin.y + canvas.frame.origin.y);
}
[[self.view layer] addSublayer:_marque];
{% endhighlight %}
	
Then we show the marque when we move (rotate, resize) the photo and add the *marching ants* animation.

{% highlight objc %}
-(void)showOverlayWithFrame:(CGRect)frame {

	if (![_marque actionForKey:@"linePhase"]) {
		CABasicAnimation *dashAnimation;
		dashAnimation = [CABasicAnimation animationWithKeyPath:@"lineDashPhase"];
		[dashAnimation setFromValue:[NSNumber numberWithFloat:0.0f]];
		[dashAnimation setToValue:[NSNumber numberWithFloat:15.0f]];
		[dashAnimation setDuration:0.5f];
		[dashAnimation setRepeatCount:HUGE_VALF];
		[_marque addAnimation:dashAnimation forKey:@"linePhase"];
	}

	_marque.bounds = CGRectMake(frame.origin.x, frame.origin.y, 0, 0);
	_marque.position = CGPointMake(frame.origin.x + canvas.frame.origin.x, frame.origin.y + canvas.frame.origin.y);

	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect(path, NULL, frame);
	[_marque setPath:path];
	CGPathRelease(path);

	_marque.hidden = NO;
}
{% endhighlight %}
 
# Example project and source on GitHub

The full source of the above code is available within my [Sample Projects GitHub account](https://github.com/rogchap/SampleProjects) under the **ImageManipulation** folder. Running this app should produce a lovely frame of Steve Jobs:

![Image Manipulation iPhone sample app](https://github.com/rogchap/SampleProjects/raw/master/ImageManipulation/Screenshot.png)

	