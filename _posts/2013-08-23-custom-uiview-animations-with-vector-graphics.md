---
layout: post
title: Custom UIView Animations with Vector Graphics
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

![Custom UIView Animation]({{site.url}}/images/custom_ui_animation.gif)

## Custom Control CALayer

The key to creating a custom animation lies within the view's layer class. The `CALayer`'s `drawInContext:` method will draw the curved arrow and by changing the `percentage` property will determine the x position of the arrow head's frame:

{% gist 6337586 RCArrowControlLayer.h %}
{% gist 6337586 RCArrowControlLayer.m %}

The important parts to creating this animation layer is making sure that the `percentage` property is `@dynamic` and that we update the display when the `percentage` property changed.

We also set the action for the `percentage` to return a nice `CABasicAnimation`. This means that when we change `percentage` from 1 to 0 the actual property transitions from 1 to 0.9 to 0.8 ... 0.2 to 0.1 to 0.0 with the given easing function.

## Usage

Once we have created a the layer we can easily create the `UIView` that implements this layer and add this to our `UIViewController` either via code or Interface Builder.

I've created a sample project on GitHub that contains all the source and shows the implementation here:

[https://github.com/rogchap/.../CustomUIViewAnimation](https://github.com/rogchap/SampleProjects/tree/master/CustomUIViewAnimation)