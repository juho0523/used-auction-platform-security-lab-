<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
				<img src="images/menu/chat active.png" /><br>
				채팅<div id="unread"></div>
			</a> 
			<a href="controller?cmd=sellListUI">
				<img src="images/menu/sellList.png" /><br>
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
</body>
</html>
