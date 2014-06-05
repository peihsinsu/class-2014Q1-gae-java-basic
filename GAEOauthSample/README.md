Oauth Sample Project - Access Googl Calendar
====

本篇以Calendar API說明如何建制Oauth2認證流程，並延伸Google Calendar API為例，展示如何使用API。

## Working flow

1. 開啓 http://your-app-id.appspot.com/ 並且 click "LOGIN" 鏈結
2. 瀏覽器將會 redirect 到 google 的認證授權頁面
3. 認證過後，頁面將重導回"/"

如果遇執行登出，可以於 http://your-app-id.appspot.com/ 點選LOGOUT鏈結

## 建制步驟

### 權限申請

至Cloud Console申請Web Application Account，並指定Server位置作為callback url的位置

### 設定專案存取權限

修改AuthUtils，將Client ID, Client Secret設定於下面區塊內，並將Web Application Account所指定的callback url一併設定

```
public static final String clientId = "467751377063-vq...6g0lqu.apps.googleusercontent.com";
public static final String clientSecret = "lzZfWz...-1rS";
public static final String callbackurl = "/oauth2callback";
```

### 延伸Calendar範例，使用其他API

使用ShowCalendarInfo.java作為範例，改寫下面區塊，以呼叫不同API

```
Calendar service = new Calendar(httpTransport, jsonFactory, getCredential());
String calendarInfo = CalendarDetails.getCalendarItems(service);
```

例如操作Drive API

```
HttpTransport httpTransport = AuthUtils.httpTransport;
JacksonFactory jsonFactory = AuthUtils.jsonFactory;

Drive client = new Drive.Builder(httpTransport, jsonFactory, getCredential()).setApplicationName(APP_NAME).build();
FileList files = client.files().list().execute();

writer.println("<div>"+ files.toPrettyString() +"</div>");
```

