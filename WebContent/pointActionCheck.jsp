<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>		
${"result":"${pointActCheck}"}

<%-- <script type="text/javascript">
var resultData = <%= request.getAttribute("pointActCheck") %>;
var actPoint = parseInt(resultData);
if (actPoint > 0) {
    alert('포인트 충전 완료.');
  } else if (actPoint < 0) {
    alert('포인트 환전 완료.');
  } else {
    alert('알 수 없는 오류가 발생했습니다.');
  }
</script> --%>

