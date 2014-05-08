package com.gae.basic;

import java.io.IOException;
import java.util.Scanner;

import javax.servlet.http.*;

@SuppressWarnings("serial")
public class FibServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		resp.setContentType("text/plain");
		if(req.getParameter("n") != null) {
			int n = Integer.parseInt(req.getParameter("n"));
			resp.getWriter().println(getFib(n));
		} else {
			resp.getWriter().println("Please use http://localhost:8888/fib?n=[your number] for compute...");
		}
	}
	
	public String getFib(int number) {
		String out = "";
		for(int i=1; i<=number; i++){
            out += (fibonacciRecusion(i) +" ");
        }
        return out;
    } 
 
    public int fibonacciRecusion(int number){
        if(number == 1 || number == 2){
            return 1;
        }
        return fibonacciRecusion(number-1) + fibonacciRecusion(number -2); //tail recursion
    }
}
