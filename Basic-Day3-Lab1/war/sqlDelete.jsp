<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<c:if test="${pageContext.request.method=='POST'}">

<sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://173.194.241.187:3306/classicmodels"
     user="root"  password="1234"/>

<sql:update dataSource="${ds}" var="count">
  DELETE FROM `customers` WHERE customerNumber = '<%=request.getParameter("id") %>'
</sql:update>

Delete record done by SQL:
<pre>
DELETE FROM `customers` WHERE customerNumber = '<%=request.getParameter("id") %>';
</pre>

<button onclick="window.history.go(-1)">Go Back</button>

</c:if>
