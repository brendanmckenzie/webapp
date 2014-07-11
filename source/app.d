import vibe.d;

version (development) {
	const string CDN_ROOT = "http://localhost:8081/";
}
version (staging) {
	const string CDN_ROOT = "http://cdn-staging.webapp.com/";
}
version (production) {
	const string CDN_ROOT = "http://cdn.webapp.com/";
}

shared static this()
{
	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	listenHTTP(settings, &home);

	logInfo("webapp now running.");
}

void home(HTTPServerRequest req, HTTPServerResponse res)
{
	res.render!("index.dt", CDN_ROOT);
}