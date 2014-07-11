// use this to run a faux web server to act as a CDN during development

var express = require('express');
var app = express();

app.all('*', function(req, res, next) {
	res.header("Access-Control-Allow-Origin", "http://localhost:8080");
	res.header("Access-Control-Allow-Headers", "X-Requested-With");
	next();
});

// simple logging
app.use(function(req, res, next){
	console.log('%s %s', req.method, req.url);
	next();
});

// static directory
app.use('/', express.static(__dirname + '/public'));

// and listen.
app.listen(8081);

console.log('webapp development cdn listening on port 8081');