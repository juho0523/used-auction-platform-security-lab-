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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="css/common.css">
<title>호박마켓 : 아이디 찾기</title>
<style>
.img {
	width: 23px;
	height: 23px;
}

#top {
	grid-area: 1/1/2/2;
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
	grid-template-rows: 120px 50px 50px 50px 250px;
	height: 548px;
	margin-top: 50px;
}

.findIdH1 {
	grid-area: 1/1/2/2;
	display: flex;
	flex-content:center;
	
}

.fontFindIdH1{
	font-size:27.4px;
}

.fontFindIdH1 {
	display: flex;
	justify-content: center;
	margin-top: 30%;
	margin-left: 30%;
}

.addName {
	grid-area: 2/1/3/2;
	display: flex;
	justify-content: center;
	transform: translateX(6px);

}

.addEmail {
	grid-area: 3/1/4/2;
	display: flex;
	justify-content: center;
	
}

.addPhoneNumber {
	grid-area: 4/1/5/2;
	display: flex;
	justify-content: center;
	transform: translateX(-5px);
}

input:focus {
	outline: none;
}

.findIdBtn {
	grid-area: 5/1/6/2;
	display: flex;
	justify-content: center;
	padding: 1em 3em;
	font-size: 1.75em;
}

.container {
	transform: translateX(-25px);
}

.inputTxt {
	background-color: #D9D9D9;
	border: none;
	border-radius: 3px;
	width: 140px;
	height: 31px;
}



.lgbt {
	color: #FFFFFF;
	background-color: #FF992E;
	border: none;
	border-radius: 10px;
	padding: 8px 90px;
}



</style>
</head>
<body>
	<div id="project_container">
		<div id="top">
			<img class="img ms-2 mt-2" src="images/icon/arrow.png" onclick="history.back()">
		</div>
		<div class="container">
			<form action="controller?cmd=findIDAction" method="post">
			<div class="findIdH1 mb-3">
				<p class="fontFindIdH1 text-center">아이디 찾기</p>
			</div>
			
				<div class="addName mt-4 mb-0">
					<label class="col-form-label">이름ㅤ</label>
					<input type="text" name="name" class="inputTxt" id="name"><br>
				</div>
				<div class="addEmail mt-2 mb-0">
					<label class="col-form-label">이메일ㅤ</label>
					<input type="text" name="email" class="inputTxt" id="email"><br>
					<br>
				</div>
				<div class="addPhoneNumber mt-1">
					<label class="col-form-label">전화번호ㅤ</label>
					<input type="text" name="phoneNumber" class="inputTxt" id="phoneNumber"><br>
				</div>
				<div class="findIdBtn">
					<div>
						<input type="submit" value="O K" class="lgbt" id="searchIDBtn" onclick="return submitInput()">
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
// var input1 = document.getElementById('name');
// var input2 = document.getElementById('email');
// var input3 = document.getElementById('phoneNumber');
 
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