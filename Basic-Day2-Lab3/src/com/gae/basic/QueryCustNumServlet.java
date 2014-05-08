package com.gae.basic;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.labs.repackaged.org.json.JSONArray;
import com.google.appengine.labs.repackaged.org.json.JSONObject;

@SuppressWarnings("serial")
public class QueryCustNumServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		resp.setContentType("application/json");
		int custNum = req.getParameter("custNum") != null ? 
				Integer.parseInt(req.getParameter("custNum")) : -1;
		if(custNum > 0) {
			resp.getWriter().println(getData(custNum));
		} else if (custNum == -1) {
			resp.getWriter().println(getAllData());
		} else {
			resp.getWriter().println("{\"error\":true,\"message\":\"parameter error\"}");
		}
	}
	
	public JSONArray getData(int custNum) {
		String selectSQL = "select customerNumber, customerName from customers where customerNumber = ?";
		try {
			Connection dbConnection = getDBConnection();
			PreparedStatement preparedStatement = dbConnection
					.prepareStatement(selectSQL);
			preparedStatement.setInt(1, custNum);
			ResultSet rs = preparedStatement.executeQuery();
			JSONArray arr = new JSONArray();
			while (rs.next()) {
				String customerNumber = rs.getString("customerNumber");
				String customerName = rs.getString("customerName");
				JSONObject obj = new JSONObject();
				obj.put("customerNumber", customerNumber);
				obj.put("customerName", customerName);
				arr.put(obj);
			}

			return arr;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
	
	public JSONArray getAllData() {
		String selectSQL = "select customerNumber, customerName from customers ";
		Connection dbConnection = null;
		try {
			dbConnection = getDBConnection();
			PreparedStatement preparedStatement = dbConnection
					.prepareStatement(selectSQL);
			ResultSet rs = preparedStatement.executeQuery();
			JSONArray arr = new JSONArray();
			while (rs.next()) {
				String customerNumber = rs.getString("customerNumber");
				String customerName = rs.getString("customerName");
				JSONObject obj = new JSONObject();
				obj.put("customerNumber", customerNumber);
				obj.put("customerName", customerName);
				arr.put(obj);
			}

			return arr;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				dbConnection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}
	
	public Connection getDBConnection(){
		Connection connection = null; 
		try { 
			String connectionURL = "jdbc:mysql://173.194.241.187:3306/classicmodels"; 
			Class.forName("com.mysql.jdbc.Driver").newInstance(); 
			connection =  DriverManager.getConnection(connectionURL, "root", "1234");
			return connection;
		} catch (Exception ex) { 
			System.out.println("Unable to connect to database"+ex); 
			return null;
		} 
	}
}
