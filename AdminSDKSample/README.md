AdminSDK Sample Project
====

## Working flow

1. open http://your-app-id.appspot.com/admin
2. browser will redirect to google's authenticate and authorize page
3. after auth, page will redirect back to /admin

## Code

### AuthUtils.java

Code for help auth. These static method will used by other api calls.

```
public class AuthUtils {

  /* 設定Web Application的認證資訊 */
  public static final String clientId = "467751377063-vqrq...07798n86g0lqu.apps.googleusercontent.com";
  public static final String clientSecret = "lzZfW....C-1rS";
  public static final String callbackurl = "/oauth2callback";
  
  private static final AppEngineDataStoreFactory DATA_STORE_FACTORY = AppEngineDataStoreFactory.getDefaultInstance();
  
  public static Set<String> DIRECTORY_SCOPES = DirectoryScopes.all();
  
  
  // The HttpTransport and JacksonFactory are needed for the authorization process
  static final HttpTransport httpTransport = new UrlFetchTransport();
  static final JacksonFactory jsonFactory = new JacksonFactory();

  /*
   * initializeFlow() 開始詢問使用者賦予本應用程式授權操作Google API
   * scopeList決定哪些API的哪些權限可以被本應用程式操作
   */
  public static AuthorizationCodeFlow initializeFlow(Iterable<String> scopeList) throws IOException {
    /* 
     * 建立GoogleAuthorizationCodeFlow並透過builder去執行認證的authorization proces 
     */
    Builder flowBuilder =
        new GoogleAuthorizationCodeFlow.Builder(httpTransport, jsonFactory, clientId, clientSecret,
            (Collection<String>) scopeList);

    // Save the credentials in the App Engine datastore
    flowBuilder.setDataStoreFactory(DATA_STORE_FACTORY);

    // Request offline access so that we get a refresh token
    // to prolong the duration of the permission before the user
    // is asked to give permission again.
    flowBuilder.setAccessType("offline");
    
    // Return the GoogleAuthorizationCodeFlow
    return flowBuilder.build();
    
  }

  /*
   * 回覆callback path，該path需要符合定義於API Console中的redirects URI
   */
  public static String getRedirectUri(HttpServletRequest req)
      throws ServletException, IOException {
    GenericUrl url = new GenericUrl(req.getRequestURL().toString());
    url.setRawPath(callbackurl);
    return url.build();
  }

}
```

### web.xml

Set up the rule for force login

```
<security-constraint>
  <web-resource-collection>
    <web-resource-name>any</web-resource-name>
    <url-pattern>/*</url-pattern>
  </web-resource-collection>
  <auth-constraint>
    <role-name>*</role-name>
  </auth-constraint>
</security-constraint>
```

### OAuthCallback.java

The authenticate callback route.

```
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
```

## ShowAppAdminInfo.java

Execute the admin sdk api and output to page.

```
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
```


