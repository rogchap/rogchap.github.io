---
layout: post
title: Custom UIView Animations with Vector Graphics
published: false
---

There are may great things that you gain by using vector graphics in your iOS apps:

* Increased performance
* Reduced app file size
* Works on retina and non-retina devices
* Dynamic shapes and colors
* Animations

Because vector graphics are all drawn in-code with `CoreGraphics` we can change values to animate the `UIView`s.

If you've never used vector graphics in your iOS apps before you should take a look at [PaintCode](http://www.paintcodeapp.com/); PaintCode is an awesome vector drawing app that generates Objective-C code that you can copy and paste into your application. I don't build an iOS app without it now.

## Example

What we are going to create is and animation that is similar to the following; please note that this GIF only has 5 frames, our animation will be smooth from start to finish:

![Custom UIView Animation]
