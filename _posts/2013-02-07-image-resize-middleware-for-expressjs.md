--- 
layout: post 
title: "Image Resize Middleware for Express.js"
--- 

I love node.js and I love using express.js. One of the cool things with express is being able to add your own middleware. The following code snippit is a simple middleware that handles resizing images in my public folder.

The benifit of using this middleware is that I do not need a seperate controller to dynamically resize imagery. For example:

	<!-- original image: -->
	<img src="/images/logo.png" />

	<!-- I don't want this: -->
	<img src="/imagereziser?image=/images/logo.png&w=100$h=100" />

	<!-- I'd rather have this: -->
	<img src="/images/logo.png?size=100x100" />


This is a simple code snippet for the basic middleware; it can easily be extending to check for image types (you don't want to resise css or javascript files!) and it could take a optional parameter to handle `crop` instead of just resize.

## Dependencies

This middleware requires imagemagick and the mkdirp node module:
	
	$ brew install imagemagick
	$ npm install mkdirp

## Middleware

	// image-resize.js
	var path = require('path'),
    exec = require('child_process').exec,
    mkdirp = require('mkdirp');

	module.exports = ir = {};

	// express.js middleware
	ir.static = function(rootPath) {

	  var root = path.normalize(rootPath),
	    cache_path = path.join(root, '.cache');

	  return function (req, res, next){

	    var file = req.url.replace(/\?.*/,''),
	      size = req.query.size,
	      orig = path.normalize(root + file),
	      dst = path.join(cache_path, type, size, file);

	    function send_if_exists(file, callback) {
	      fs.exists(file, function(exists){

	        if (!exists) return callback();

	        return fs.stat(file, function(err, stats){
	          if (err){
	            console.error(err);
	          }
	          else if (stats.isFile()){
	            return res.sendfile(file);
	          }
	          return callback();
	        });
	      });
	    }

	    if (!size){
	      return send_if_exists(orig, next);
	    }

	    send_if_exists(dst, function() {

	      mkdirp(path.dirname(dst));

	      exec('convert ' + orig + ' -resize '+ size +' ' + dst , function(err) {
	        if(err) {
	          console.error(err);
	          res.send(err);
	        } else {
	          res.sendfile(dst);
	        }
	      });

	    });

	  };
	};

## Usage

In your `app.js` replace the following:

	//app.use(express.static(path.join(__dirname, 'public')));
	app.use(require('./image-resize').static(path.join(__dirname, 'public')));

The `size` parameter triggers the image resize otherwise it will just fetch the original image. The resized images are also cached for later use. 
