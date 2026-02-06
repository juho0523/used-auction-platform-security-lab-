<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${userId ne null}">
	<c:redirect url="controller?cmd=mainUI" />
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<% if(request.getSession().getAttribute("userId") != null){ %>
<% response.sendRedirect("controller?cmd=mainUI"); %>
<% } else { %>
<% response.sendRedirect("controller?cmd=loginUI"); %>
<% } %>

</body>
</html>