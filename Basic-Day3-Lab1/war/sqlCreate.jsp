<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
</head>
<body>

<c:if test="${pageContext.request.method=='GET'}">
<h1>Add a customer...</h1>
<form action="sqlCreate.jsp" method="POST">
	<div>Customer Name: <input type="text" name="customerName"/></div>
	<div>Contact Last Name: <input type="text" name="contactLastName"/></div>
	<div>Contact First Name: <input type="text" name="contactFirstName"/></div>
	<div>Phone: <input type="text" name="phone"/></div>
	<div>Postal Code: <input type="text" name="postalCode"/></div>
	<div>Address Line1: <input type="text" name="addressLine1" style="width:400px"/></div>
	<div>Address Line2: <input type="text" name="addressLine2" style="width:400px"/></div>
	<div>City: <input type="text" name="city"/></div>
	<div>State: <input type="text" name="state"/></div>
	<div>Country: <input type="text" name="country"/></div>
	<div>Sales Rep Employee Number: <input type="text" name="salesRepEmployeeNumber"/></div>
	<div>Credit Limit: <input type="text" name="creditLimit"/></div>
	<br/>
	<input type="submit" value="Submit"/>
</form>
</c:if>

<c:if test="${pageContext.request.method=='POST'}">

<sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://173.194.241.187:3306/classicmodels"
     user="root"  password="1234"/>

<sql:update dataSource="${ds}" var="count">
  INSERT INTO `customers` (`customerName`, 
	`contactLastName`, `contactFirstName`, `phone`, `addressLine1`, 
	`addressLine2`, `city`, `state`, `postalCode`, `country`, 
	`salesRepEmployeeNumber`, `creditLimit`)
	  VALUES ('<%=request.getParameter("customerName") %>',
	  	'<%=request.getParameter("contactLastName") %>',
	  	'<%=request.getParameter("contactFirstName") %>',
	  	'<%=request.getParameter("phone") %>',
	  	'<%=request.getParameter("addressLine1") %>',
	  	'<%=request.getParameter("addressLine2") %>',
	  	'<%=request.getParameter("city") %>',
	  	'<%=request.getParameter("state") %>',
	  	'<%=request.getParameter("postalCode") %>',
	  	'<%=request.getParameter("country") %>',
	  	'<%=request.getParameter("salesRepEmployeeNumber") %>',
	  	'<%=request.getParameter("creditLimit") %>'
	  );
</sql:update>
Date Create Done, Effected rows: <c:out value="${count}"/><br/>

</c:if>


</body>
</html>