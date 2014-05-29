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
Key userKey = KeyFactory.createKey("Employee", "simonsu@mitac.com.tw");

Query q = new Query("Jobs");
Key ancestor = KeyFactory.createKey("Employee", "simonsu@mitac.com.tw");
q.setAncestor(ancestor);

PreparedQuery results = ds.prepare(q);
Iterator iter = results.asIterable().iterator();
while(iter.hasNext()) {
	Entity ent = (Entity) iter.next();
	out.println(ent.getProperties());
}

%>