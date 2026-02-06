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
<link rel="stylesheet" href="css/setPW.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.0.0/crypto-js.min.js"></script>
<title>비밀번호 찾기 : 비밀번호 수정</title>
<style>
.passwordH6{
	font-size:12px;
}
.img{
  width: 23px;
  height: 23px;
}
#top{
	grid-area: 1/1/2/2;
	display: flex;
	justify-content: space-between;
	align-items: center;
	width: inherit;
	height: 40px;
    position: absolute;
	transform:translateY(-650%);
	display:flex;
	flex-wrap: wrap-reverse;
}
#top h1{
	margin-left: 5px;
	font-size: 20px;
	font-weight: 600;
}
#top > img{
	width: 23px;
	height: 23px;
	cursor: pointer; 
}
#top-head {
  font-size: 20px;
  font-weight: 600;
}
.container {

}

.setPWH1 {
    grid-area : 1/1/2/2;
    display : flex;
    justify-content : center;
}
.setPW{
    grid-area : 2/1/3/2;
    display : flex;
    justify-content : center;
    transform: translateX(7px);
}
.checkPassword{
    grid-area : 3/1/4/2;
    display : flex;
    justify-content : center;
	  white-space:nowrap;
    transform: translateY(-25px);
}
input:focus {outline: none;}
.setPWBtn{
    grid-area : 4/1/5/2;
    display:flex;
    justify-content : center;
    padding:1em 3em;
    font-size:1.75em;
}
.container{
	transform: translateX(-8px);
}
.inputNewPW{
	background-color:#D9D9D9; 
	border:none; 
	border-radius:3px; 
	width:140px; 
	height:31px;
}
.inputNewPWCheck{
	background-color:#D9D9D9; 
	border:none; 
	border-radius:3px; 
	width:140px; 
	height:31px;
}
.lgbt{
    color:#FFFFFF;
    background-color:#FF992E;
    border:none;
    border-radius:10px;
    padding:8px 90px;
    transform:translateY(-25px);
}
.fontFindPasswordH1{
	font-size:27.4px;

}
</style>
</head>
<body>
	<div id="project_container">
		<br><br><br>
			  <div id="top">
				<img class="img ms-2 mt-2" src="images/icon/arrow.png" onclick="history.back()">
		  	  </div>		
	
		<div class="container">
			<form action="controller?cmd=setPWAction" method="post" id="setPWForm" onsubmit="hashFormData(event)">
		
			<div class="setPWH1 mb-4">
				<p class="fontFindPasswordH1 text-center">비밀번호 찾기</p>
			</div>
			<input type="hidden" name="id" value="<%= session.getAttribute("id") %>">
			<div class="setPW mt-4">
				<label class="passwordH6 col-form-label">새 비밀번호ㅤ</label><input type="password" name="password" class="inputNewPW" id="password"><br>
			</div>

			<div class="checkPassword mb-0">
				<label class="passwordH6 col-form-label">비밀번호 확인ㅤ</label><input type="password" name="checkPassword" class="inputNewPWCheck" id="checkPassword">
				<div id = "passwordCheckDiv"></div><br>
			</div>

			<div class="setPWBtn mt-0">
				<div>
					<input type="submit" value="O K" class="lgbt" onclick = "return passwordTest()">
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
//	function passwordTest(){
//		 var input1 = document.getElementById('password');
//		 var input2 = document.getElementById('checkPassword');
//		 
//		 if(input1.value == ''|| input2.value == ''){
//			alert('정보를 입력해주세요.') 
//			return false;		 
//		 } else {
//			return true;
//		 }
//		
//		var p1 = document.getElementById('password').value;
//			var p2 = document.getElementById('checkPassword').value;
//			if (p1 != p2) {
//				alert("비밀번호가 일치 하지 않습니다.");
//				return false;
//			} else {
//				alert("비밀번호 변경 완료")
//				return true;
//			}			
//		}
	</script>

  <script>
  function hashFormData(event) {
    event.preventDefault();
    var form = document.getElementById("setPWForm");
    var formData = new FormData(form);  
    var password = formData.get("password");
    var checkPassword = formData.get("checkPassword");
    if(password === '' || checkPassword === ''){
        form.submit();
        return;
    }    
    var hashedPassword = CryptoJS.SHA256(password).toString(CryptoJS.enc.Hex);
    var hashedCheckPassword = CryptoJS.SHA256(checkPassword).toString(CryptoJS.enc.Hex);
    document.getElementById("password").value = hashedPassword;
    document.getElementById("checkPassword").value = hashedCheckPassword;
    form.submit();
  }
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