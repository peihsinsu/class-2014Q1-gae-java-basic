package com.mitac.objectify;
import static com.mitac.objectify.OfyService.ofy;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.Query;

@SuppressWarnings("serial")
public class GaeObjectifyServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		resp.setContentType("text/plain");
		PrintWriter out = resp.getWriter();
		/**
		 * Open Source See: https://code.google.com/p/objectify-appengine/wiki/BestPractices#Use_Your_Own_Service
		 * Usage See: https://groups.google.com/forum/#!topic/google-appengine-java/RGeYbq8BeIs
		 */
		switch(req.getParameter("type")) {
		case "ADD":
			ofy().put(new Car("audi", "audi a3"));
			Car car = ofy().get(Car.class, "audi");

			out.println("Hello, world ==> " + car.name );
			
			break;
		case "QUERY":
			Query<Car> query = ofy().query(Car.class);
			query.filter("name = ", "audi a3").order("name");
			
			List<Car> cars = //ofy().prepare(query).asList();
					query.list();
			
			Iterator iter = cars.iterator();
			while(iter.hasNext()) {
				Car c = (Car) iter.next();
				out.println("Hello, world ==> " + c.name );
			}
			
			break;
		}
		
	}
}
