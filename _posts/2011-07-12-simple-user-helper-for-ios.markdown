---
layout: post
title: Simple User Helper for iOS
---

I'm sure there are many ways to store user information to remember if a user is logged in or not, using the key chain api for example. However, I like to keep things really really simple, so I created a simple helper class to deal with my user object and store the info using `NSUserDefaults` and have a static constructor:

{% highlight objc %}
// UserHelper.h
	
@interface UserHelper : NSObject {
	NSString *currentUserId;
	NSUserDefaults *_defaults;
}

@property(nonatomic,retain) NSString *currentUserId;

-(BOOL) isValid;
-(void) clear;

+(UserHelper *) default;

@end
	
// UserHelper.m
	
#import "UserHelper.h"

@implementation UserHelper
@synthesize currentUserId;

//////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject

static NSString *kcurrentUser = @"currentUser";

+(UserHelper *) default {
	static UserHelper *helper = nil;

	if (helper == nil) {
		helper = [[UserHelper alloc] init];
	}

	return helper;
}

-(id) init {

	if (self == [super init]) {
		_defaults = [NSUserDefaults standardUserDefaults];
		currentUserId = [_defaults stringForKey:kcurrentUser];
	}

	return self;
}

//////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private

-(void)setCurrentUserId:(NSString *)_id {
	currentUserId = _id;
	[_defaults setObject:currentUserId forKey:kcurrentUser];
	[_defaults synchronize];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"UserSignedIn" object:nil];
}

//////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public

-(BOOL) isValid {
	return [currentUserId isKindOfClass:[NSString class]] && [currentUserId length] > 0;
}

-(void) clear {

	currentUserId = nil;
	[_defaults removeObjectForKey:kcurrentUser];
	[_defaults synchronize];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"UserSignedOut" object:nil];
}

@end
{% endhighlight %}
	
In this helper method I'm only storing the user Id, but you could always store a user object and serialize/deserialize to JSON to store as `NSString`

Hope this may help someone who is after simple authentication persistence. 

