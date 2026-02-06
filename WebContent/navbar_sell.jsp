<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String userId1 = (String)session.getAttribute("userId"); %>
<% if(userId1 == null) response.sendRedirect("controller?cmd=loginUI"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<nav class="navbar mt-auto sticky-bottom w-100 rounded-bottom-4">
	<div class="d-flex w-100 justify-content-center">
		<div id="nav123" class="w-100">
			<a href="controller?cmd=mainUI"> 
				<img src="images/menu/home.png" /><br>
				홈
			</a> 
			<a href="controller?cmd=chatListUI">
				<img src="images/menu/chat.png" /><br>
				채팅<div id="unread"></div>
			</a> 
			<a href="controller?cmd=sellListUI">
				<img src="images/menu/sellList active.png" /><br>
				판매내역
			</a> 
			<a href="controller?cmd=buyListUI">
				<img src="images/menu/buyList.png" /><br>
				구매내역
			</a> 
			<a href="controller?cmd=myPageUI"> 
				<img src="images/menu/myPage.png" /><br>
				나
			</a>
		</div>
	</div>
	</nav>
<script>
function getUnread(){
	$.ajax({
		type: "POST",
		url: "controller?cmd=getUnreadAction",
		data: {
			userId: "<%= userId1 %>"
		},
		success: function(result){
			var data = JSON.parse(result);
			//console.log(data.count);
			if(data.count >= 1){
				showUnread(data.count);
			} else {
				showUnread('');
			}
		}
	});
}

function getInfiniteUnread(){
	setInterval(function(){
		getUnread();
	},3000);
}

function showUnread(result){
	$('#unread').html(result);
}

$(document).ready(function(){
	getUnread();
	getInfiniteUnread();
});
</script>
</body>
</html>
