---
layout: post
title: Simple API Creation with Node.js
---

This will be a tutorial for setting up a simple JSON API using [Node.js](http://modejs.org).

Node.js is discribed as "evented I/O for V8 JavaScript" so is perfect for creating simple, lightweight APIs or websites.

## Step 1: Install Node.js

You can download Node.js from the GitHub repository and follow the [installation guide](https://github.com/joyent/node/wiki/Installation), but I'm quite a fan of using package managers so I'm going to install that way, but either way works. Package manager details can be found here: 

[https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager).

Check your Node.js installation:

	$ node -v
	v0.4.8

Now that we have Node.js installed we will want to install npm (Node Package Manager) which will make installing Node.js modules a breeze.

	curl http://npmjs.org/install.sh | sh

Now we have Node.js installed and the Node Package Manager.

## Step 2: Setup API Application

Create the directory for application:

	$ mkdir NodeApi
	$ cd NodeApi

Although we could create our API with Node.js alone I'm going to install [express](http://expressjs.com/) which makes web development simple; well also make sure we have all the dependancies like Jade, a templeting engine:

	$ npm install -g express
	$ npm install -d

Then lets create a default express project:

	$ express

This will create the directories and files for a basic web application. Lets test our new web app:

	$ node app.js
	Express server listening on port 3000 in development mode

	$ curl localhost:3000
	<!DOCTYPE .... etc

Now we have a running web application! You can get more simple and lightweight that that....love it!

## Part 2: Coming soon

I'm going to split this tutorial into a few parts. In the next part we will setup our application with a familier MVC style pattern.

As always I'll be putting the source project on GitHub:

[https://github.com/rogchap/SampleProjects/tree/master/NodeApi](https://github.com/rogchap/SampleProjects/tree/master/NodeApi)
	
