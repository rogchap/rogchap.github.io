---
layout: post
title: MKMapView Moving the Google Logo
---

The terms & conditions of using the MapKit in iOS is that the Google logo has to be visible, but sometimes your UI hides the logo, for example you may have an iAd or toolbar. This is a very simple addition to MKMapView to access the Google logo, so that you can move it to another part of the screen.

**Warning**: Do not hide the logo otherwise your app will get rejected by Apple. As long as the logo is fully visible you should be fine.

	@implementation MKMapView (Additions)

	- (UIImageView*) googleLogo {

		UIImageView *imgView = nil;
		for (UIView *subview in self.subviews) {
			if ([subview isMemberOfClass:[UIImageView class]]) {
				imgView = (UIImageView*)subview;
				break;
			}
		}
		return imgView;
	}
	
	@end
	
As an extra method to make things easy for my particular application I decided to add the use of `UITextAlignment` to align the logo left, center or right (right in my case):

	- (void) alignGoogleLogo:(UITextAlignment) alignment {

	  UIImageView *logo = [self googleLogo];
	  CGRect frame = logo.frame;
	  float padding = 9;

	  if (alignment == UITextAlignmentLeft) {

	    frame.origin.x = padding;

	  } else if (alignment == UITextAlignmentCenter) {

	    frame.origin.x = (self.size.width / 2) - (frame.size.width / 2);

	  } else if (alignment == UITextAlignmentRight) {

	    frame.origin.x = self.size.width - frame.size.width - padding;
	  }

	  [logo setFrame:frame];

	}



