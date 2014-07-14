module webapp.session;
import vibe.d;

int nextSessionId = 0;
WebAppSession[int] sessions;

const SessionCookieName = "webapp:session";

public class WebAppSession {
	int id;
	int userId;

	this (int id, int userId) {
		this.id = id;
		this.userId = userId;
	}
}

WebAppSession getSession(HTTPServerRequest req, HTTPServerResponse res) {
	auto inCookie = req.cookies.get(SessionCookieName, null);
	auto outCookie = res.cookies.get(SessionCookieName, null);
	int sessionId = -1;
	if (outCookie !is null) {
		sessionId = to!int(outCookie.value);
	}
	else if (inCookie !is null) {
		sessionId = to!int(inCookie);
	}
	else {
		return null;
	}

	return sessions[sessionId];
}

void checkSession(HTTPServerRequest req, HTTPServerResponse res) {
	auto sessionId = req.cookies.get(SessionCookieName, null);

	if (sessionId == null || ((to!int(sessionId) in sessions) == null)) {
		auto sesh = new WebAppSession(nextSessionId++, -1);

		sessions[sesh.id] = sesh;

		res.setCookie(SessionCookieName, to!string(sesh.id));
	}
}