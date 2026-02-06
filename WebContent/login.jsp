<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${userId ne null}">
  <c:redirect url="controller?cmd=mainUI" />
</c:if>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/common.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.0.0/crypto-js.min.js"></script>
<title>호박마켓 : 로그인</title>
<style>
.fontLoginP{
	font-size:27.4px;
}
</style>
</head>
<body>
  <div id="project_container">
  
    <form action="controller?cmd=loginAction" method="post" id="loginForm" onsubmit="hashFormData(event)">
      <div class="row align-items-center">
        <p class="fontLoginP text-center">로그인</p>
        <div class="row g-2 d-flex align-items-center justify-content-center pt-2">
          <div class="col-4 text-end">
            <label class="col-form-label">아이디</label>
          </div>
          <div class="col-7">
            <input name="userId" type="text" id="inputId"
              class="form-control-sm">
          </div>
          <div class="col-4 text-end">
            <label for="inputPassword6" class="col-form-label">비밀번호</label>
          </div>
          <div class="col-7">
            <input name="userPw" type="password" id="pw"
              class="form-control-sm" aria-describedby="passwordHelpInline">
          </div>
        </div>
      </div>

      <div class="container text-center mt-3" id="linkA">
        <a href="controller?cmd=findIDUI"
          class="link-secondary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover m-1"
          id="findIDA">아이디 찾기</a>
        <p>|</p>
        <a href="controller?cmd=findPWUI"
          class="link-secondary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover m-1"
          id="findPWA">비밀번호 찾기</a>
        <p>|</p>
        <a href="controller?cmd=joinUI"
          class="link-secondary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover m-1"
          id="joinA">회원가입</a>
      </div>
      <div class="d-grid ps-5 pe-5 mt-3 mb-3 text-center">
        <button type="submit" class="btn btn-primary btn-lg">
          <div class="text-center m">LOGIN</div>
        </button>
      </div>
    </form>
    
    <% String messageContent = (String)session.getAttribute("messageContent"); %>
    <% if(messageContent != null){ %>
    <div id="alertMessage">
        <%= messageContent %>
    </div>
    <% session.removeAttribute("messageContent"); } %>
    
  </div>

  <script>
  function hashFormData(event) {
    event.preventDefault();
    var form = document.getElementById("loginForm");
    var formData = new FormData(form);  
    var password = formData.get("userPw");
    if(password === ''){
      form.submit();
    	return;
    }    
    var hashedPassword = CryptoJS.SHA256(password).toString(CryptoJS.enc.Hex);
    document.getElementById("pw").value = hashedPassword;
    form.submit();
  }
//  $("button").on("click", function(){
//	  if($("#inputId").val() == ""){
//		  alert("아이디를 입력해주세요.");
//		  return false;
//	  }
//	  if($("#pw").val() == ""){
//		  alert("비밀번호를 입력해주세요.");
//		  return false;
//	  }
//  })
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