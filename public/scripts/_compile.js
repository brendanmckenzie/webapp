var UglifyJS = require("uglifyjs");
var fs = require('fs');

var root = 'public/scripts/';

fs.readFile(root + 'config.json', function(err, data) {
	data = JSON.parse(data);

	// init javascript
	for (var i = 0; i < data.files_init.length; i++) {
		data.files_init[i] = root + 'init/' + data.files_init[i];
	}
	var result = UglifyJS.minify(data.files_init, {
		outSourceMap: 'site.init.js.map'
	});

	fs.writeFileSync(root + '../site.init.js', result.code);
	fs.writeFileSync(root + '../site.init.js.map', result.map);

	// post-init javascript
	for (var i = 0; i < data.files.length; i++) {
		data.files[i] = root + data.files[i];
	}
	var result = UglifyJS.minify(data.files, {
		outSourceMap: 'site.js.map'
	});

	fs.writeFileSync(root + '../site.js', result.code);
	fs.writeFileSync(root + '../site.js.map', result.map);
});
