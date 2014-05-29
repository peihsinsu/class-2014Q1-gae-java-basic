<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.UploadOptions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Cloud Storage (Blobstore) Upload Form</h1>
<%
    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
    UploadOptions uploadOptions = 
    		UploadOptions.Builder.withGoogleStorageBucketName("simontest1234");
    String uploadUrl = //blobstoreService.createUploadUrl("/done.jsp", uploadOptions); //upload using jsp
    		blobstoreService.createUploadUrl("/upload", uploadOptions); //using servlet
    
%>
<form action="<%=uploadUrl %>" method="POST" enctype="multipart/form-data">

	Upload File: <input type="file" name="file"><br>
	<input type="submit" name="submit" value="Submit">

</form>  
</body>
</html>