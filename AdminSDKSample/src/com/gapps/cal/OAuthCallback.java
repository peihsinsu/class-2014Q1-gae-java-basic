package com.gapps.cal;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.api.client.auth.oauth2.AuthorizationCodeFlow;
import com.google.api.client.auth.oauth2.AuthorizationCodeResponseUrl;
import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.appengine.auth.oauth2.AbstractAppEngineAuthorizationCodeCallbackServlet;

@SuppressWarnings("serial")
public class OAuthCallback extends
		AbstractAppEngineAuthorizationCodeCallbackServlet {

	@Override
	protected void onSuccess(HttpServletRequest req, HttpServletResponse resp,
			Credential credential) throws ServletException, IOException {
		resp.sendRedirect("/admin");
	}

	@Override
	protected void onError(HttpServletRequest req, HttpServletResponse resp,
			AuthorizationCodeResponseUrl errorResponse)
			throws ServletException, IOException {
		resp.setStatus(200);
		resp.addHeader("Content-Type", "text/html");
		resp.getWriter().print("<h1>Sorry, access to the api has been denied.</h1>");
	}

	@Override
	protected AuthorizationCodeFlow initializeFlow() throws IOException {
		return AuthUtils.initializeFlow(AuthUtils.DIRECTORY_SCOPES);
	}

	@Override
	public String getRedirectUri(HttpServletRequest req)
			throws ServletException, IOException {
		return AuthUtils.getRedirectUri(req);
	}
}