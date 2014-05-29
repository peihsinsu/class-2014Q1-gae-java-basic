<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="messageService"
	class="com.mitac.JSTLSample.MessageService" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>core sample</title>
</head>
<body>

	<%--default scop is page , if u need session scope , pls setup appengine-web.xml --%>
	<c:set var="name" value="sunny" />
	<li>Hello , my name is <c:out value="${name}" /></li> JSTL reference:
	<a target="new"
		href="http://www.tutorialspoint.com/jsp/jsp_standard_tag_library.htm">http://www.tutorialspoint.com/jsp/jsp_standard_tag_library.htm</a>
	<hr />
	<h1>forTokens demo:</h1>
	<c:forTokens var="token" delims="," items="Java,C++,C,JavaScript">
    ${token} <br>
	</c:forTokens>
	<hr />
	<h1>forEach demo</h1>
	<table style="text-align: left; width: 100%;" border="1">
		<tr>
			<td>名稱</td>
			<td>訊息</td>
		</tr>
		<c:forEach var="message" items="${messageService.messages}">
			<tr>
				<td>${message.name}</td>
				<td>${message.text}</td>
			</tr>
		</c:forEach>
	</table>
	<hr />
	<h1>choose demo:</h1>
	<c:choose>
		<c:when test="${name!=null && name=='sunny'}">
			<li>
				<%--<jsp:getProperty name="user" property="name"/>登入成功 --%> User is
				sunny
			</li>
		</c:when>
		<c:otherwise>
			<li>User is not sunny</li>
		</c:otherwise>
	</c:choose>
	<hr />
	<h1>if demo:</h1>
	<c:if test="${name!=null && name=='sunny'}">
		<li>Test success!!</li>
	</c:if>
	<hr />
	<h1>sql Demo:</h1>
	<%--com.mysql.jdbc.GoogleDriver -- , jdbc:google:mysql://modern-yeti-407:sunny1st/1st--%>
	<%-- <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://173.194.106.9:3306/1st"
     user="root"  password="jou1aqnfmxu"/> --%>


	<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.GoogleDriver"
		url="jdbc:google:mysql://mitac-cp300:unitestdb/tp26?user=root&password=peceorder" />

	<%-- <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://211.78.254.117:3306/GCP"
     user="sunny4817"  password="jou1aqnfmxu"/>--%>

	<sql:query dataSource="${snapshot}" var="result">  
	 SELECT now() as _T;
	</sql:query>

	<table border="1" width="100%">
		<tr>
			<th>NOW</th>
		</tr>
		<c:forEach var="row" items="${result.rows}">
			<tr>
				<td><c:out value="${row._T}" /></td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>


</body>
</html>