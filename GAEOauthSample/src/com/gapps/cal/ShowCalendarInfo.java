package com.gapps.cal;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.api.client.auth.oauth2.AuthorizationCodeFlow;
import com.google.api.client.extensions.appengine.auth.oauth2.AbstractAppEngineAuthorizationCodeServlet;
import com.google.api.client.extensions.appengine.http.UrlFetchTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.jackson.JacksonFactory;
import com.google.api.services.calendar.Calendar;
import com.google.api.services.calendar.CalendarScopes;
import com.google.appengine.api.users.UserServiceFactory;

public class ShowCalendarInfo extends AbstractAppEngineAuthorizationCodeServlet {

	private static final long serialVersionUID = -156275561843799745L;

	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		resp.setContentType("text/html; charset=UTF-8");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter writer = resp.getWriter();

		writer.println("<html><head><meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\" /></head>");
		writer.println("<p>The current user is： "
				+ UserServiceFactory.getUserService().getCurrentUser()
						.getEmail());

		HttpTransport httpTransport = new UrlFetchTransport();
		JacksonFactory jsonFactory = new JacksonFactory();

		Calendar service = new Calendar(httpTransport, jsonFactory,
				getCredential());

		String calendarInfo = CalendarDetails.getCalendarItems(service);

		writer.println(calendarInfo);

		writer.println("</html>");

	}

	@Override
	protected AuthorizationCodeFlow initializeFlow() throws IOException {
		AuthUtils.addScopes(CalendarScopes.all());
		return  AuthUtils.initializeFlow(AuthUtils.SCOPES);
	}

	@Override
	public String getRedirectUri(HttpServletRequest req)
			throws ServletException, IOException {
		return AuthUtils.getRedirectUri(req);
	}
}