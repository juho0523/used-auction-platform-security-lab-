<%@page import="com.google.gson.JsonObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ID 확인</title>
</head>
<body>
    <script>
        var id = '<%= request.getAttribute("id") %>'; 
        alert('아이디: ' + id);
        location.href = "controller?cmd=loginAction";
    </script>
</body>
</html>   
    
    