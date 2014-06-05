AdminSDK Sample Project
====

## Working flow

1. open http://your-app-id.appspot.com/admin
2. browser will redirect to google's authenticate and authorize page
3. after auth, page will redirect back to /admin

## Code

### AuthUtils.java

Code for help auth.

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

    // Force the user to give permission again if they previously gave access for a different scope
    // flowBuilder.setApprovalPrompt("force");


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