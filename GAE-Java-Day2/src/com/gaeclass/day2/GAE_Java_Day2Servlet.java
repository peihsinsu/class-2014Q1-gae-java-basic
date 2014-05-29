package com.gaeclass.day2;

import java.io.IOException;
import java.util.Date;
import java.util.logging.Level;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Transaction;
import com.google.appengine.api.memcache.ErrorHandlers;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;


@SuppressWarnings("serial")
public class GAE_Java_Day2Servlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

		Entity employee = new Entity("Employee", "simonsu@mitac.com.tw");
		employee.setProperty("name", "Simon Su");
		employee.setProperty("hireDate", new Date());
		Key empKey = datastore.put(employee);
		
		Query query = new Query("Person");

		Query.Filter nameFilter = new Query.FilterPredicate("name", Query.FilterOperator.EQUAL, "John");

		query.setFilter(nameFilter); 

		PreparedQuery results = datastore.prepare(query);

		Transaction txn = datastore.beginTransaction();

		
		MemcacheService cache = MemcacheServiceFactory.getMemcacheService();
		cache.setErrorHandler(
		    ErrorHandlers.getConsistentLogAndContinue(Level.INFO));

		
		resp.setContentType("text/plain");
		resp.getWriter().println("Data saved... empKey = " + empKey.getId());
	}
}
