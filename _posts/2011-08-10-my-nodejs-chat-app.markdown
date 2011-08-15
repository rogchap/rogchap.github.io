---
layout: post
title: My Node.js Chat App
---

I'm a big fan of [node.js](http://nodejs.org/), and when learning node, you can't do it without building a chat room app! Everybody's done one so I thought I would share my node chat app:

## The building blocks

My chat app uses three frameworks:

* [node.js](http://nodejs.org/)
* [express](http://expressjs.com/)
* [socket.io](http://socket.io/)

Socket.IO makes websockets supper simple, and is even [cross browser compatible](http://socket.io/#browser-support). Socket.IO will use the best transport of your messages that is available in that browser, ie. websockets -> websockets over Flash -> ajax polling. So this should mean that my app should work in IE6 (although not tested!).

A very simple socket.io demo:

{% highlight javascript %}

// server.js

var io = require('socket.io').listen(3000);

io.socket.on('connection', function(client){
	client.emit('welcome', 'Welcome to NodeChat!');
});

// client.js

var socket = io.connect('http://localhost:3000');

socket.on('welcome', function(data){
	alert(data);
});

{% endhighlight %}

You can't get more simple than that!

## Source code

As always the complete application is available on GitHub:

[https://github.com/rogchap/SampleProjects/tree/master/NodeChat](https://github.com/rogchap/SampleProjects/tree/master/NodeChat)

All the information is contained in the README file and the best thing to do is download the source and run it.