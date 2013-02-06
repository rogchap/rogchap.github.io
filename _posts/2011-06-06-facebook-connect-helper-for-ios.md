---
layout: post
title: Facebook Connect Helper for iOS
---

Many iPhone/iPad apps use Facebook Connect, and Facebook have made this really easy with their [Facebook iOS SDK](https://github.com/facebook/facebook-ios-sdk).

One thing that you will always most likely want to do is make sure that the user only has to log in once, and every time time they want to use your app that they are already authenticated with Facebook. This means two things: first you need to make sure you authenticate the user with the `offline_access` flag and secondly, save the access tokens for the next time your app is used.

This led me to create a very simple helper class that I use in conjunction with the Facebook SDK to make my life a little easier:

	// FacebookHelper.h
	
	#import "FBConnect.h"
	@interface FacebookHelper : NSObject {
	
	}
	
	+(Facebook*)fb;
	+(void) resume;
	+(void) save;
	+(void) revoke;

	@end
	
	//FacebookHelper.m
	
	static NSString* kFBAccessToken = @"FBAccessToken";
	static NSString* kFBExpirationDate = @"FBExpirationDate";

	@implementation FacebookHelper

	+(Facebook*)fb {
		static Facebook *fb = nil;

		if (fb == nil) {
			fb = [[Facebook alloc] initWithAppId:FB_APP_ID];
		}

		return fb;
	}

	+(void) resume {
	  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	  Facebook *facebook = [FacebookHelper fb];
	  facebook.accessToken = [defaults stringForKey:kFBAccessToken];
	  facebook.expirationDate = (NSDate*)[defaults objectForKey:kFBExpirationDate];
	}

	+(void) save {
	  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	  Facebook *facebook = [FacebookHelper fb];

	  [defaults setObject:facebook.accessToken forKey:kFBAccessToken];
	  [defaults setObject:facebook.expirationDate forKey:kFBExpirationDate];
	  [defaults synchronize];
	}

	+(void) revoke {
	  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	  [defaults removeObjectForKey:kFBAccessToken];
	  [defaults removeObjectForKey:kFBExpirationDate];
	  [defaults synchronize];
	}

	@end

As you can see I have a static object for the Facebook SDK, and three simple static method to help me deal with login and logout. Now in my `applicationDidFinishLaunching` method on my `AppDelegate` I simply call:
	[FacebookHelper resume];
And when `fbDidLogin` and `fbDidLogin` are called:
	[FacebookHelper save];
and
	[FacebookHelper revoke];

Simple!
