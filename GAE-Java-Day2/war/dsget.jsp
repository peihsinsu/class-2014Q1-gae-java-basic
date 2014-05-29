<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Transaction" %>
<%@ page import="java.util.Date" %>

<%@ page import="com.google.appengine.api.memcache.ErrorHandlers"%>
<%@ page import="com.google.appengine.api.memcache.MemcacheService"%>
<%@ page import="com.google.appengine.api.memcache.MemcacheServiceFactory"%>
<%@ page import="java.util.logging.Level" %>

<%
DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

MemcacheService cache = MemcacheServiceFactory.getMemcacheService();
cache.setErrorHandler(
    ErrorHandlers.getConsistentLogAndContinue(Level.INFO));

String userid = "simonsu@mitac.com.tw";

if("Y".equalsIgnoreCase(request.getParameter("isUseCache"))) {
	out.println("[USING CACHE]");
	if(cache.get(userid) == null) {
		out.println("Query again....");
		Key userKey = KeyFactory.createKey("Employee", userid);
		Entity user = datastore.get(userKey);
		out.println("Get user.name: " + user.getProperty("name"));
		out.println("Get user.sex: " + user.getProperty("sex"));
		out.println("Get user.age: " + user.getProperty("age"));
		cache.put(userid, user);
	} else {
		out.println("From cache...");
		Entity user = (Entity)cache.get(userid);
		out.println("Get user.name: " + user.getProperty("name"));
		out.println("Get user.sex: " + user.getProperty("sex"));
		out.println("Get user.age: " + user.getProperty("age"));
	}
} else {
	out.println("[NO CACHE]");
	Key userKey = KeyFactory.createKey("Employee", userid);
	Entity user = datastore.get(userKey);
	out.println("Get user.name: " + user.getProperty("name"));
	out.println("Get user.sex: " + user.getProperty("sex"));
	out.println("Get user.age: " + user.getProperty("age"));
}

%>
