package com.gapps.cal;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.api.client.auth.oauth2.AuthorizationCodeFlow;
import com.google.api.client.extensions.appengine.auth.oauth2.AbstractAppEngineAuthorizationCodeServlet;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.jackson.JacksonFactory;
import com.google.api.services.admin.directory.Directory;
import com.google.api.services.admin.directory.model.Groups;
import com.google.api.services.admin.directory.model.User;
import com.google.api.services.admin.directory.model.Users;
import com.google.appengine.api.users.UserServiceFactory;

public class ShowAppAdminInfo extends AbstractAppEngineAuthorizationCodeServlet {

  private static final long serialVersionUID = -156275561843799745L;
  private static final String APPLICATION_NAME = "arecord-cloud-project";

  public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

    resp.setContentType("text/html; charset=UTF-8");
    resp.setCharacterEncoding("UTF-8");
    PrintWriter out = resp.getWriter();

    out.println("<html><head><meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\" /></head>");
    out.println("<p>The current user is： " + UserServiceFactory.getUserService().getCurrentUser().getEmail());

    HttpTransport httpTransport = AuthUtils.httpTransport;
    JacksonFactory jsonFactory = AuthUtils.jsonFactory;
    
    Directory directory = new Directory.Builder(httpTransport, jsonFactory, getCredential()).setApplicationName(APPLICATION_NAME).build();

    /*
     * Sample1: List group informations
     */
    Groups group = directory.groups().list().setDomain("gs.arecord.us").execute();
    out.println("<br/>Groups==>" + group.toPrettyString());
    
    out.println("<br/>Access Token: " + getCredential().getAccessToken() + "<br/>");
    out.println("Refresh Token: " + getCredential().getRefreshToken() + "<br/><br/><br/>");
    out.println("<hr/>");
    
    /*
     * Sample2: List user
     */
    List<User> allUsers = new ArrayList<User>();
    Directory.Users.List request = directory.users().list().setCustomer("my_customer");

    // Get all users
    do {
      try {
        Users currentPage = request.execute();
        allUsers.addAll(currentPage.getUsers());
        request.setPageToken(currentPage.getNextPageToken());
      } catch (IOException e) {
        System.out.println("An error occurred: " + e);
        request.setPageToken(null);
        out.println("Got exception:" + e.getMessage());
        throw e;
      }
      
    } while (request.getPageToken() != null &&
             request.getPageToken().length() > 0 );

    // Print all users
    for (User currentUser : allUsers) {
      out.println(currentUser.getPrimaryEmail());
    }
    
    out.println("</html>");
  }
  

  @Override
  protected AuthorizationCodeFlow initializeFlow() throws IOException {
	  AuthorizationCodeFlow flow = AuthUtils.initializeFlow(AuthUtils.DIRECTORY_SCOPES);
	  return flow;
  }

  @Override
  public String getRedirectUri(HttpServletRequest req) throws ServletException, IOException {
    return AuthUtils.getRedirectUri(req);
  }
}