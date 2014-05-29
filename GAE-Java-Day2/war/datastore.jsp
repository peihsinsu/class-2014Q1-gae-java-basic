<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Transaction" %>
<%@ page import="java.util.Date" %>

<%
DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
Key empKey = null;
Transaction txn = datastore.beginTransaction();
try {
	Entity employee = new Entity("Employee", "simonsu@mitac.com.tw");
	employee.setProperty("name", "Simon Su");
	employee.setProperty("sex", "M");
	employee.setProperty("age", 100);
	employee.setProperty("hireDate", new Date());
	empKey = datastore.put(employee);
	txn.commit();
} catch (Exception e) {
	e.printStackTrace();
} finally {
	if(txn.isActive()) {
		txn.rollback();
	}
}
%>

Saved result:<%=empKey.getId() %>

<%
Key userKey = KeyFactory.createKey("Employee", "simonsu@mitac.com.tw");
Entity user = datastore.get(userKey);
out.println("Get user.name: " + user.getProperty("name"));
out.println("Get user.sex: " + user.getProperty("sex"));
out.println("Get user.age: " + user.getProperty("age"));
%>