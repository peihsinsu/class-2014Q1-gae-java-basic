package com.gapps.cal;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.api.client.auth.oauth2.AuthorizationCodeFlow;
import com.google.api.client.extensions.appengine.auth.oauth2.AbstractAppEngineAuthorizationCodeServlet;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.jackson.JacksonFactory;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.model.FileList;
import com.google.appengine.api.users.UserServiceFactory;

/*
 * The following imports require that the Google Calendar APIs have been added to your project. In
 * Eclipse, select the Google menu > Add Google APIs > Calendar API
 */

public class DriveExampleServlet extends AbstractAppEngineAuthorizationCodeServlet {

  private static final long serialVersionUID = -156275561843799745L;
  private static final String APP_NAME = "DRIVE_SAMPLE";
// For a single scope, turn the scope into a singleton collection
//  Iterable<String> scopeList = Collections.singleton(CalendarScopes.CALENDAR);

  // Get future events from the user's calendar.
  // doGet() gets invoked after the authentication process has completed.
  public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

    resp.setContentType("text/html; charset=UTF-8");
    resp.setCharacterEncoding("UTF-8");
    PrintWriter writer = resp.getWriter();

    writer.println("<html><head><meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\" /></head>");
    writer.println("<p>The current user is： " + UserServiceFactory.getUserService().getCurrentUser().getEmail());

    // Get the httpTransport and jsonFactory, which are needed
    // to instantiate the Calendar service
    HttpTransport httpTransport = AuthUtils.httpTransport;
    JacksonFactory jsonFactory = AuthUtils.jsonFactory;
    
    Drive client = new Drive.Builder(httpTransport, jsonFactory, getCredential()).setApplicationName(APP_NAME).build();
    FileList files = client.files().list().execute();
    
    writer.println("<div>"+ files.toPrettyString() +"</div>");
    
    writer.println("</html>");
    

  }
  

  @Override
  protected AuthorizationCodeFlow initializeFlow() throws IOException {
	  AuthorizationCodeFlow flow = AuthUtils.initializeFlow(AuthUtils.SCOPES);
	  return flow;
  }

  @Override
  public String getRedirectUri(HttpServletRequest req) throws ServletException, IOException {
    return AuthUtils.getRedirectUri(req);
  }
}