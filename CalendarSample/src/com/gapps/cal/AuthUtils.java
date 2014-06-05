package com.gapps.cal;

import java.io.IOException;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import com.google.api.client.auth.oauth2.AuthorizationCodeFlow;
import com.google.api.client.extensions.appengine.datastore.AppEngineDataStoreFactory;
import com.google.api.client.extensions.appengine.http.UrlFetchTransport;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow.Builder;
import com.google.api.client.http.GenericUrl;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.jackson.JacksonFactory;
import com.google.api.services.calendar.CalendarScopes;

public class AuthUtils {

  /* 設定Web Application的認證資訊 */
  public static final String clientId = 
		  "467751377063-vq...6g0lqu.apps.googleusercontent.com";
  public static final String clientSecret = "lzZfWz...-1rS";
  public static final String callbackurl = "/oauth2callback";
  
  public static Set<String> SCOPES;
  
  public static Set<String> addScopes(String scope) {
	  if(SCOPES == null)
		  SCOPES = new HashSet<String>();
	  SCOPES.add(CalendarScopes.CALENDAR);
	  return SCOPES;
  }
  
  public static Set<String> addScopes(Set<String> scopes) {
	  if(SCOPES == null)
		  SCOPES = new HashSet<String>();
	  SCOPES.addAll(scopes);
	  return SCOPES;
  }
  
  
  // The HttpTransport and JacksonFactory are needed for the authorization process
  static final HttpTransport httpTransport = new UrlFetchTransport();
  static final JacksonFactory jsonFactory = new JacksonFactory();
  private static final AppEngineDataStoreFactory DATA_STORE_FACTORY = AppEngineDataStoreFactory.getDefaultInstance();

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

    flowBuilder.setApprovalPrompt("force");
    flowBuilder.setAccessType("offline");
    flowBuilder.setDataStoreFactory(DATA_STORE_FACTORY);
    
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