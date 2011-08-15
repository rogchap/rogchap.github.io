---
layout: post
title: Simple API Creation with Node.js - Part 2
published: false
---

In [Part 1](http://rogchap.com/2011/06/25/simple-api-creation-with-nodejs/) we set up a really simple web server with Node.js and express. Coming from an ASP.NET MVC background my first thought was to set up my node
 project in an MVC manner.
 
## Directories
 
In the last post express should have created the following folder structure:
 
	- /
		- logs
		- node-modules
		- pids
		- public
		- views

We going to add two more folders `controllers` and `models`:
 
	- /
		- controllers
		- logs
		- models
		- node-modules
		- pids
		- public
		- views

Now we have the folders for our **M**odels **V**iews and **C**ontrollers.
 
## Bootstrap
 
Create two functions, one for controllers and one for models, so that any files we place in the `Controllers` or `Models` folders will be included into our application:
 
	// app.js
	
	var fs = require('fs');
	
	function bootModels(app, next) {
		fs.readdir(__dirname + '/models', function(err, files){
    			if(err) throw err;
    			files.forEach(function(file){
      				var name = file.replace('.js', '');
      				var model = __dirname + '/models' + name;
      				require(model)(app);
      				next();
    			});
  		});
	};

	function bootControllers(app, next) {
  		fs.readdir(_dirname + '/controllers', function(err, files){
    			if(err) throw err;
    			files.forEach(function(file){
      				var name = file.replace('js', '');
      				var controller = __dirname + '/controllers' + name;
    			});
  		});
	};

We then create one more boot function that will call our two previous functions in turn and boot any other requirements, e.g. view engines, routing, static content etc. This function will be a rearrangement of some of the current code if you've been following along.

	// app.js

	function bootApplication
