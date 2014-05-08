package com.gae.basic;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.*;

import com.google.appengine.labs.repackaged.org.json.JSONException;
import com.google.appengine.labs.repackaged.org.json.JSONObject;

@SuppressWarnings("serial")
public class TimeServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		resp.setContentType("application/json");
		JSONObject obj = new JSONObject();
		try {
			obj.put("time", new Date().toString());
			resp.getWriter().println(obj.toString());
		} catch (JSONException e) {
			e.printStackTrace();
			resp.getWriter().println("Prase json error...");
		}
	}
}
