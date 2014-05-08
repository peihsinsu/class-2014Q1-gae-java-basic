<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SQL Query Sample</title>
</head>
<body>

<div>
<h1 style="">Query Customer</h1>
<div style="float:right;" align="right"><a href="sqlCreate.jsp">Create New Record</a></div>
</div>
<form action="sqlQuery.jsp" method="POST">
	<input type="text" name="id"/>
	<input type="submit" value="Submit"/>
</form>


<table border="1" width="100%">
	<tr>
		<th>Customer ID</th>
		<th>Customer Name</th>
		<th>Phone</th>
		<th>Edit</th>
		<th>Remove</th>
	</tr>

<c:if test="${pageContext.request.method=='POST'}">

<%
String custId = request.getParameter("id") != null ? request.getParameter("id") : null;
%>
<sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://173.194.241.187:3306/classicmodels"
     user="root"  password="1234"/>

<p>
Query by customer id: <c:out value="<%=custId %>"/>
</p>


<% if("all".equalsIgnoreCase(custId)) { %>
  <sql:query dataSource="${ds}" var="result">
	  select customerNumber, customerName, phone from customers
  </sql:query>
<% } else { %>
  <sql:query dataSource="${ds}" var="result">
	  select customerNumber, customerName, phone from customers where customerNumber = ?
	  <sql:param value="<%=custId %>" />
  </sql:query>
<% } %>

	<c:forEach var="row" items="${result.rows}">
		<tr>
			<td><c:out value="${row.customerNumber}" /></td>
			<td><c:out value="${row.customerName}" /></td>
			<td><c:out value="${row.phone}" /></td>
			<td>
				<form action="sqlUpdate.jsp" method="GET">
				<input type="hidden" id="id" name="id" value="<c:out value="${row.customerNumber}"/>">
				<input type="submit" value="Edit"/>
				</form>
			</td>
			<td>
				<form action="sqlDelete.jsp" method="POST">
				<input type="hidden" id="id" name="id" value="<c:out value="${row.customerNumber}"/>">
				<input type="submit" value="Delete"/>
				</form>
			</td>
		</tr>
	</c:forEach>

</c:if>


</table>

<br/><br/>


</body>
</html>