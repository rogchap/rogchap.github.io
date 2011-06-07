---
layout: post
title: iOS5 and Automatic Reference Counting
---

Well today is another day and it would be impossible to to write a blog post without mentioning [Apple's Keynote](http://events.apple.com.edgesuite.net/11piubpwiqubf06/event/) at WWDC 2011. There were some awesome announcements for OSX Lion, iOS5 and iCloud; all with some amazing features.

For iOS there are some cool new features and applications which you can get an overview [here](http://www.apple.com/ios/ios5/), but there are some equally cool features for Developers:

## Automatic Reference Counting (ARC)

Apple's definition:

> Automatic Reference Counting (ARC) is a compiler-level feature that simplifies the process of managing the lifetimes of Objective-C objects. Instead of you having to remember when to retain or release an object, ARC evaluates the lifetime requirements of your objects and automatically inserts the appropriate method calls at compile time.

Coming from a C# background, memory management became a thing of the past, however when I entered the iOS and Objective-C world I had to learn (and learn fast) about retaining, releasing objects. Now thanks to Apple's new LLVM Compiler (3.0) I won't have to type a retain or release again. That make me a very happy developer. Now I can concentrate on building great apps without the fear of the app crashing because of a memory leak or and object being auto-released.

I'm looking forward to using this new feature as well as [storyboards and other great features](http://developer.apple.com/technologies/ios5/), but because it's just a beta I won't be able to try it out in anger until a little bit closer to Fall, when iOS5 is set to be released. 