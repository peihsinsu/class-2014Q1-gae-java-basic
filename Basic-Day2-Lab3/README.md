Basic-Day2-Lab3
----

## 實作一個資料庫查詢列表頁面

請參考下頁範例程式碼

```
String selectSQL = "SELECT USER_ID, USERNAME FROM DBUSER WHERE USER_ID = ?";
try {
  dbConnection = getDBConnection();
  preparedStatement = dbConnection.prepareStatement(selectSQL);
  preparedStatement.setInt(1, 1001);
  ResultSet rs = preparedStatement.executeQuery(); // execute select SQL stetement
  while (rs.next()) {
    String userid = rs.getString("USER_ID");
    String username = rs.getString("USERNAME");
    System.out.println("userid : " + userid);
    System.out.println("username : " + username);
  }
} catch ...

```

## 概念

本篇概念在於熟悉GAE framework上操作SQL的方式，包含建立connection, prepared statement與新、刪、改、查的執行方式。


## 附註

資料表以classicmodels.sql為主，資料庫之位置與資訊，請依所需修改。