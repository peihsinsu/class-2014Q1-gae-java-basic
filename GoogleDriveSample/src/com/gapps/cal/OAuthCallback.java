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
public class OAuthCallback extends AbstractAppEngineAuthorizationCodeCallbackServlet {

  // The scope of the APIs for which permission is needed
  //Iterable<String> scopeList = Collections.singleton(CalendarScopes.CALENDAR);

  @Override
  // This method is called when the authorization process is successful.
  // Typically, you would redirect back to the servlet that initiated the authorization process.
  protected void onSuccess(HttpServletRequest req, HttpServletResponse resp, Credential credential)
      throws ServletException, IOException {
    resp.sendRedirect("/drive");
  }

  @Override
  // This method is called when the authorization process is NOT successful.
  // Typically, you would display an error message, 
  // or redirect back to a servlet that handles the failure with grace
  // and keeps the application running without accessing the requested APIs
  protected void onError(HttpServletRequest req, HttpServletResponse resp,
      AuthorizationCodeResponseUrl errorResponse) throws ServletException, IOException {
    resp.setStatus(200);
    resp.addHeader("Content-Type", "text/html");
    resp.getWriter().print("<h1>Sorry, access to the calendar has been denied.</h1>");

  }

  @Override
  // This method is required by AbstractAppEngineAuthorizationCodeCallbackServlet.
  // It initializes the authorization flow.
  protected AuthorizationCodeFlow initializeFlow() throws IOException {
    return AuthUtils.initializeFlow(AuthUtils.SCOPES);


  }

  @Override
  // This method is required by AbstractAppEngineAuthorizationCodeCallbackServlet.
  // It must return the URI to redirect to when the authorization flow completes
  // (which actually is the URI that invokes this servlet!)
  public String getRedirectUri(HttpServletRequest req) throws ServletException, IOException {
    return AuthUtils.getRedirectUri(req);
  }

}