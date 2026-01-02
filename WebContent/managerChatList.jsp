<!-- <<<<<<< HEAD -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
 <link rel="stylesheet" href="css/common.css">
 <link rel="stylesheet" href="css/managerChatList.css">
<title>Insert title here</title>
</head>
<style>
a {
	text-decoration: none;
	color:#000000;
	
}

</style>
<body>

<div id="project_container">
	<div class = "container-fulid" >
	<ul class="list-group">
      <li class="list-group-item border-0 p-0">
		<table class = "table">
			<thead>
 
 				<!-- 테이블을 누르면 사용자와의 채팅방이 열려야 함 -->
 				<!-- 빨간 점(reddot.png)은 위의 조건을 만족해야 없어짐 -->
 				<!-- 테이블 클릭 시 #isRead는 display:none -->
 				
				<tr class="table-borderless" >
					<th class="col-md-3">
					<a href="managerChat.jsp">
		  				<img src="images/icon/reddot.png" class="img rounded-circle" id="isRead">
						<img src="images/icon/icon.png" class="img rounded-circle border">
					</a>	
					</th>
					<th class="usersChat mt-0 mb-0">
					<a href="managerChat.jsp">
						<p class="nicknameP mt-0 mb-0" name="userId">nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234</p>
						<!-- 3번째 "서버가 불안정합니다" 중 "서바가"에서 끊김 -->
						<p class="chatP mt-1 mb-0" name="phoneNumber">서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 </p>
					</a>	
					</th>
					<th class="lineUp"></th>
				</tr>
				
								
				<tr class="table-borderless" >
					<th class="col-md-3">
					<a href="managerChat.jsp">
		  				<img src="images/reddot.png" class="img rounded-circle" id="isRead">
						<img src="images/icon.png" class="img rounded-circle border">
					</a>	
					</th>
					<th class="usersChat mt-0 mb-0">
					<a href="managerChat.jsp">
						<p class="nicknameP mt-0 mb-0" name="userId">nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234nickname1234</p>
						<!-- 3번째 "서버가 불안정합니다" 중 "서바가"에서 끊김 -->
						<p class="chatP mt-1 mb-0" name="phoneNumber">서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 서버가 불안정합니다 </p>
					</a>	
					</th>
					<th class="lineUp"></th>
				</tr>
				
 			
				<tr class="table-borderless">
					<th class="col-md-3">
					<a href="managerChat.jsp">
						<img src="images/reddot.png" class="img rounded-circle" id="isRead">
						<img src="images/icon.png" class="img rounded-circle border">
					</a>	
					</th>
					<th class="usersChat mt-0 mb-0">
					<a href="managerChat.jsp">
						<p class="nicknameP mt-0 mb-0" name="userId">nickname1234</p>
						<p class="chatP mt-1 mb-0" name="phoneNumber">서버가 불안정합니다</p>
					</a>
					</th>
					<th class="lineUp"></th>
				</tr>
								
								
			
			</thead>
		</table>
		</li>
	  </ul>
	</div>	
</div>

<script type="text/javascript">

/* function readChat(){
	document.getElementById("isRead").style.display = "none";
} */

</script>
</body>
<!-- >>>>>>> branch 'main' of https://github.com/choimw0213/UsedAuctionPlatform
 --></html>