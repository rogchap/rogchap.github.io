---
layout: post
title: Custom Navigation Bar Background and Custom Buttons
---

The default `UINavigationBar` color is a bit boring and even changing the tint color only adds a little to the desired effect. More iPhone apps are displaying more "fancy" designs and the bulk standard navigation bar needs the same treatment.

This is the sort of navigation bar we are trying to achieve:

![Custom Nav](http://rogchap.com/images/custom_nav.png)

## Navigation Bar background

To change the background of the navigation bar be need to override the the `drawRect:` method, but I also only wanted to change the navigation background for the default navigation style. This way I could still have an app that can use the semi-transparent navigation bar when necessary. To achieve this we store the original `drawRect:` method and only override when the `barStyle` is equal to `UIBarStyleDefault`.

I placed this code at the end of my app delegate:

	#import <objc/runtime.h>
	
	static void (*_origDrawRect)(id, SEL, CGRect);

	static void OverrideDrawRect(UIToolbar *self, SEL _cmd, CGRect r) {
	  if ( self.barStyle == UIBarStyleDefault ) {
	    self.tintColor = UIColorFromRGB(0x008A35);
	    [[UIImage imageNamed:@"top_navbar"] drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	  } else {
	    // Call default method
	    _origDrawRect(self, _cmd, r);
	  }
	}

	@implementation UINavigationBar (UINavigationBarCategory)

	+ (void)load {
	  Method origMethod = class_getInstanceMethod(self, @selector(drawRect:));
	  _origDrawRect = (void *)method_getImplementation(origMethod);

	  if(!class_addMethod(self, @selector(drawRect:), (IMP)OverrideDrawRect, method_getTypeEncoding(origMethod)))
	    method_setImplementation(origMethod, (IMP)OverrideDrawRect);
	}
	
This will now set the background of all `UINavigationBar`s to `top_navbar.png` for the default style. You can also use similar code to change `UITabBar`s.

## Custom Navigation Bar Buttons

At this point your navigation bar will have your new background image but the buttons will still have the default look based on the tint color you specified. This maybe what you want but if you want custom buttons I created the following category:

	// UIBarButtonItem+Image.h
	
	@interface UIBarButtonItem (Image)

	-(id)initWithImage:(UIImage *)image title:(NSString*)title target:(id)target action:(SEL)action;

	@end
	
	//  UIBarButtonItem+Image.m
	
	@implementation UIBarButtonItem (Image)

	-(id)initWithImage:(UIImage *)image title:(NSString*)title target:(id)target action:(SEL)action {
	  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	  button.frame= CGRectMake(0.0, 0.0, image.size.width, image.size.height);
	  button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
	  button.titleLabel.shadowOffset = CGSizeMake(0, -1);
	  button.titleLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.5];

	  [button setTitle:title forState:UIControlStateNormal];
	  [button setBackgroundImage:image forState:UIControlStateNormal];
	  [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

	  UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height) ];
	  [view addSubview:button];

	  self = [[UIBarButtonItem alloc] initWithCustomView:view];

	  [view release];
	  [image release];

	  return self;
	}

	-(void)setEnabled:(BOOL)enabled {
	  if (self.customView) {
	    if ([[self.customView.subviews objectAtIndex:0] isKindOfClass:[UIButton class]]) {
	      ((UIButton*)[self.customView.subviews objectAtIndex:0]).enabled = enabled;
	    }
	  }
	}
	
The `setEnabled` method allows you to set a disabled state on the `UIBarButtonItem` and that state be reflected in the custom button.

In order to use your custom button in the nav bar you must set the left/right bar button item:

	#import "UIBarButtonItem+Image.h"
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"custom_button"] title:@"Cancel" target:self action:@selector(cancel)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"custom_button_blue"] title:@"Continue" target:self action:@selector(continue)];

Your left and right button should now look like you custom buttons. One down side to this is that you would have to manually set the back button each time with a `popViewController` action if you wanted a custom back button, but that's no real headache.
	
## Bonus: UIColorFromRGB

You'll have notice that I used a macro in the `OverrideDrawRect` method to set the tint color of the navigation bar:

	#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
	
This was a macro provided by [Cocoa-Matic](http://cocoamatic.blogspot.com/2010/07/uicolor-macro-with-hex-values.html).
