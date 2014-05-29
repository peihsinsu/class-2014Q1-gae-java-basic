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

Key userKey = //KeyFactory.createKey("Employee", "simonsu@mitac.com.tw");
	KeyFactory.stringToKey("aglub19hcHBfaWRyFQsSCEVtcGxveWVlGICAgICAgMAKDA");
Entity user = datastore.get(userKey);
out.println("Get user.name: " + user.getProperty("name"));
out.println("Get user.sex: " + user.getProperty("sex"));
out.println("Get user.age: " + user.getProperty("age"));
%>