<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.UploadOptions" %>
<%@ page import="com.google.appengine.api.blobstore.FileInfo" %>
<%@ page import="com.google.appengine.api.blobstore.BlobKey" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
  BlobstoreService blobstoreService = 
		  BlobstoreServiceFactory.getBlobstoreService();


  Map<String, BlobKey> blobs = 
		  blobstoreService.getUploadedBlobs(request);


  BlobKey key = blobs.get("file");
  if (key == null) {
      response.sendRedirect("/");
  } else {
      response.sendRedirect("/serve?blob-key=" + key.getKeyString());
  }
%>
</body>
</html>