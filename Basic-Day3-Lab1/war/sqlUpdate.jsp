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

<sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://173.194.241.187:3306/classicmodels"
     user="root"  password="1234"/>

<%
String custId = request.getParameter("id") != null ? request.getParameter("id") : null;

%>

<sql:query dataSource="${ds}" var="results">
	select `customerNumber`, `customerName`, `contactLastName`, `contactFirstName`, `phone`, `addressLine1`, 
		`addressLine2`, `city`, `state`, `postalCode`, `country`, `salesRepEmployeeNumber`, `creditLimit` 
	from customers where customerNumber = ?
	<sql:param value="<%=custId %>" />
</sql:query>
      
<c:if test="${pageContext.request.method=='GET'}">
<h1>Update a customer...</h1>
<c:forEach var="result" items="${results.rows}">
<form action="sqlUpdate.jsp" method="POST">
	<div>Customer Number: <input type="text" disabled name="customerNumber" value="<c:out value="${result.customerNumber}"/>"/></div>
	<div>Customer Name: <input type="text" name="customerName" value="<c:out value="${result.customerName}"/>"/></div>
	<div>Contact Last Name: <input type="text" name="contactLastName" value="<c:out value="${result.contactLastName}"/>"/></div>
	<div>Contact First Name: <input type="text" name="contactFirstName" value="<c:out value="${result.contactFirstName}"/>"/></div>
	<div>Phone: <input type="text" name="phone" value="<c:out value="${result.phone}"/>"/></div>
	<div>Postal Code: <input type="text" name="postalCode" value="<c:out value="${result.postalCode}"/>"/></div>
	<div>Address Line1: <input type="text" name="addressLine1" style="width:400px" value="<c:out value="${result.addressLine1}"/>"/></div>
	<div>Address Line2: <input type="text" name="addressLine2" style="width:400px" value="<c:out value="${result.addressLine2}"/>"/></div>
	<div>City: <input type="text" name="city" value="<c:out value="${result.city}"/>"/></div>
	<div>State: <input type="text" name="state" value="<c:out value="${result.state}"/>"/></div>
	<div>Country: <input type="text" name="country" value="<c:out value="${result.country}"/>"/></div>
	<div>Sales Rep Employee Number: <input type="text" name="salesRepEmployeeNumber" value="<c:out value="${result.salesRepEmployeeNumber}"/>"/></div>
	<div>Credit Limit: <input type="text" name="creditLimit" value="<c:out value="${result.creditLimit}"/>"/></div>
	<br/>
	<input type="submit" value="Submit"/>
</form>
</c:forEach>

</c:if>

<c:if test="${pageContext.request.method=='POST'}">

Do the SQL: 
<pre>
UPDATE `customers` SET customerName = '<%=request.getParameter("customerName") %>', 
	  	contactLastName = '<%=request.getParameter("contactLastName") %>',
	  	contactFirstName = '<%=request.getParameter("contactFirstName") %>',
	  	phone = '<%=request.getParameter("phone") %>',
	  	addressLine1 = '<%=request.getParameter("addressLine1") %>',
	  	addressLine2 = '<%=request.getParameter("addressLine2") %>',
	  	city = '<%=request.getParameter("city") %>',
	  	state = '<%=request.getParameter("state") %>',
	  	postalCode = '<%=request.getParameter("postalCode") %>',
	  	country = '<%=request.getParameter("country") %>',
	  	salesRepEmployeeNumber = '<%=request.getParameter("salesRepEmployeeNumber") %>',
	  	creditLimit = '<%=request.getParameter("creditLimit") %>'
	  	where customerNumber = '<%=request.getParameter("customerNumber") %>'
</pre>
<sql:update dataSource="${ds}" var="count">
  UPDATE `customers` SET customerName = '<%=request.getParameter("customerName") %>', 
	  	contactLastName = '<%=request.getParameter("contactLastName") %>',
	  	contactFirstName = '<%=request.getParameter("contactFirstName") %>',
	  	phone = '<%=request.getParameter("phone") %>',
	  	addressLine1 = '<%=request.getParameter("addressLine1") %>',
	  	addressLine2 = '<%=request.getParameter("addressLine2") %>',
	  	city = '<%=request.getParameter("city") %>',
	  	state = '<%=request.getParameter("state") %>',
	  	postalCode = '<%=request.getParameter("postalCode") %>',
	  	country = '<%=request.getParameter("country") %>',
	  	salesRepEmployeeNumber = '<%=request.getParameter("salesRepEmployeeNumber") %>',
	  	creditLimit = '<%=request.getParameter("creditLimit") %>'
	  	where customerNumber = '<%=request.getParameter("customerNumber") %>'
</sql:update>

Date Update Done, Effected rows: <c:out value="${count}"/><br/>

</c:if>


</body>
</html>