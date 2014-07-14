import vibe.d;

import webapp.session;
import webapp.api.auth;

version (development) {
	const CDN_ROOT = "http://localhost:8081/";
}
version (staging) {
	const CDN_ROOT = "http://cdn-staging.webapp.com/";
}
version (production) {
	const CDN_ROOT = "http://cdn.webapp.com/";
}

// app

shared static this() {
	auto routes = new URLRouter;
	routes.any("*", &checkSession);
	routes.registerRestInterface(new AuthApi);
	routes.get("/", &home);

	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	listenHTTP(settings, routes);

	logInfo("webapp now running.");
}

void home(HTTPServerRequest req, HTTPServerResponse res) {
	res.headers["Access-Control-Allow-Origin"] = CDN_ROOT ~ "*";
	res.render!("index.dt", CDN_ROOT);
}