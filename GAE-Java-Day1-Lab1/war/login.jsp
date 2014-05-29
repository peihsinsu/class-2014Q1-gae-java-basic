<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>

<jsp:include page="page1.jsp"/>

<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	
	if (user != null) 
      pageContext.setAttribute("user", user);
       
%>

<%if (user != null) { %>
Hello <%=user.getEmail() %> 
<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a></p>
<% } else { %>
<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
<% } %>

<p>
<form action="/login.jsp">
	<input type="text" name="username"/>
	<input type="text" name="password"/>
	<input type="submit" value="button"/>
</form>
</p>

<%
if(request.getParameter("username")!=null) {
	session.setAttribute("username", request.getParameter("username"));
} 

if(session.getAttribute("username") != null) {
	out.println("My name:" + session.getAttribute("username"));
}
%>

</body>
</html>