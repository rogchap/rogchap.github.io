---
layout: post
title: HTML 5, Mobile Web and Websokets; What More do You Want?
published: true
---

I've done a cool (I think it is anyway) experiment: I wanted to use my mobile web browser to control my desktop browser. The app was to be built using HTML5 technologies and no Flash or native mobile application.

## Technologies

For the server side code I used [Node.js](http://www.http://nodejs.org/), HTML5's canvas and JavaScript on the client, and transport over websockets via [socket.io](http://socket.io/)

Moble detection was nice and easy in Node:

{%highlight javascript%}
app.get('/', function(req, res){

	var ua = req.header('user-agent');
	if(/mobile/i.test(ua)) {
		res.render('mobile.html');
	} else {
		res.render('desktop.html');
	}
});
{%endhighlight%}

## So, what does the app do?

Basically, it allows you to use your mobile's touch screen to draw on the canvas that resides on your desktop screen:

![Node Drawing](https://github.com/rogchap/SampleProjects/raw/master/NodeDrawing/Screenshot.png)

## Demo

A demo is availible at:

<http://drawing.labs.rogchap.com>

Ps. It's been tested on Chrome, Firefox and Safari, with an iPhone and an Android Phone. Don't bother with IE or a Windows 7 Phone or Blackberry: It just won't work! ;)

## Source

Once again (as always) source is available on GitHub:

[https://github.com/rogchap/SampleProjects/tree/master/NodeDrawing](https://github.com/rogchap/SampleProjects/tree/master/NodeDrawing)

