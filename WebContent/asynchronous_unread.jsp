<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${userId eq null}">
	<c:redirect url = "controller?cmd=loginUI"/>
</c:if>
{"count":<%= request.getAttribute("count") %>, 
"noti": "<%= request.getAttribute("noti") %>"}

