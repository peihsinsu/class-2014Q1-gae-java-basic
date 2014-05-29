<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>

<%@ page import="java.util.Date" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%
DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
Query query = new Query("Employee");
ArrayList list = new ArrayList();
list.add(100);
list.add(90);
Query.Filter filter1 = new Query.FilterPredicate( "age", Query.FilterOperator.IN, list);
Query.Filter filter2 = new Query.FilterPredicate( "name", Query.FilterOperator.EQUAL, "Simon Su");

Query.Filter comboFilter = Query.CompositeFilterOperator.and(filter1, filter2);

query.setFilter(filter2);
//query.setFilter(comboFilter);

PreparedQuery results = datastore.prepare(query);

Iterator iter = results.asIterator();
while(iter.hasNext()) {
	Entity entity = (Entity)iter.next();
	out.println("name="+entity.getProperty("name"));
}
%>