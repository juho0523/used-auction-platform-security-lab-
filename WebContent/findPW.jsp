<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${userId ne null}">
	<c:redirect url="controller?cmd=mainUI" />
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/common.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<title>호박마켓 : 비밀번호 찾기</title>
<style>
.img {
	width: 23px;
	height: 23px;
}

#top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	width: inherit;
	height: 40px;
	position: absolute;
	transform: translateY(-650%);
	display: flex;
	flex-wrap: wrap-reverse;
}

#top h1 {
	margin-left: 5px;
	font-size: 20px;
	font-weight: 600;
}

#top>img {
	width: 23px;
	height: 23px;
	cursor: pointer;
}

#top-head {
	font-size: 20px;
	font-weight: 600;
}

.container {
	display: grid;
}

.findPasswordH1 {
	grid-area: 1/1/2/2;
	display: flex;
	justify-content: center;
	margin-top: -20%;
}

.addUserId {
	grid-area: 2/1/3/2;
	display: flex;
	justify-content: center;
	transform: translateX(-5px);
	margin-top: 20px;
}

.addName {
	grid-area: 3/1/4/2;
	display: flex;
	justify-content: center;
	transform: translateX(2px);
	margin-top: 5px;
}

.addEmail {
	grid-area: 4/1/5/2;
	display: flex;
	justify-content: center;
	transform: translateY(8px);
	transform: translateX(-5px);
	margin-top: 20px;
}

input:focus {
	outline: none;
	
}

.findPasswordBtn {
	grid-area: 5/1/6/2;
	display: flex;
	justify-content: center;
}

.container {
	transform: translateX(-8px);
}

.fontFindPasswordH1 {
	font-size: 2em;
	font-weight: bold;
}

.lgbt {
	color: #FFFFFF;
	background-color: #FF922E;
	border: none;
	margin-top: 20px;
	border-radius: 10px;
	font-size: 1.75em;
	padding:8px 90px;
}

.inputInfos{
  background-color: #D9D9D9; 
  border: none; 
  border-radius: 3px; 
  width: 140px; 
  height: 31px;
}

.fontFindPWP{
	font-weight:normal !important;
	font-size:27.4px;
}
</style>
</head>
<body>
	<div id="project_container">
		<br> <br> <br>
		<div id="top">
			<img class="img ms-2 mt-2" src="images/icon/arrow.png" onclick="history.back()"
				style="width: 23px; height: 23px;">
		</div>
		<div class="container">
			<div class="findPasswordH1">
				<p class="fontFindPWP text-center">ㅤ비밀번호 찾기</p>
			</div>
			<form action="controller?cmd=findPWAction" method="post">
				<div class="addUserId mb-2">
					<label class="col-form-label">아이디ㅤ</label>
					<input type="text" name="userId"
						class = "inputInfos" id="id"><br>
				</div>
				<div class="addName mb-0">
					<label class="col-form-label">이름ㅤ</label>
					<input type="text" name="name"
						class = "inputInfos" id="name"><br>
				</div>
				<div class="addEmail mt-2">
					<label class="col-form-label">이메일ㅤ</label>
					<input type="text" name="email"
						class = "inputInfos" id="email"><br>
				</div>
				<div class="findPasswordBtn">
					<div>
						<input type="submit" value="O K" class="lgbt" onclick="return submitInput()">
					</div>
				</div>
			</form>
		</div>
		
    <% String messageContent = (String)session.getAttribute("messageContent"); %>
    <% if(messageContent != null){ %>
    <div id="alertMessage">
        <%= messageContent %>
    </div>
    <% session.removeAttribute("messageContent"); } %>
		
	</div>
<script type="text/javascript">

//function submitInput(){
// var input1 = document.getElementById('id');
// var input2 = document.getElementById('email');
// var input3 = document.getElementById('name');
 
// if(input1.value == ''|| input2.value == ''|| input3.value == ''){
//	alert('정보를 입력해주세요.') 
//	return false;		 
// } else {
//	true;
// }
 
// }
</script>		

<script>
    setTimeout(function() {
        var alertElement = document.getElementById('alertMessage');
        if (alertElement) {
            alertElement.classList.add('fade');
            alertElement.addEventListener('transitionend', function() {
                alertElement.remove();
            });
        }
    }, 2000);
</script>

</body>
</html>