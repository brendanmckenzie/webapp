module webapp.api.auth;

import webapp.session;
import vibe.http.rest : before;

struct LoginResult {
	bool success;
	string userName;
}

interface IAuthApi {
	@before!getSession("session")
	LoginResult postLogin(WebAppSession session, string email, string password);

	@before!getSession("session")
	WebAppSession getLogout(WebAppSession session);
}

class AuthApi : IAuthApi {
	LoginResult postLogin(WebAppSession session, string email, string password) {
		// authenticate the user, create a session, return the session object.
		return LoginResult(true, "Hello.");
	}

	WebAppSession getLogout(WebAppSession session) {
		return session;
	}
}