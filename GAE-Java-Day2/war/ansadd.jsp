<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Transaction" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Iterator" %>

<%
DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
Key userKey = KeyFactory.createKey("Employee", "bbb@mitac.com.tw");
Entity job = new Entity("Jobs", "someid", userKey);

job.setProperty("name", "bbb");
job.setProperty("start", new Date());
try {
	Key k = ds.put(job);
	out.println("Done..." + k.getId());
} catch (Exception e) {
	e.printStackTrace();
}
%>