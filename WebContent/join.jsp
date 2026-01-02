
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/join.css">
<title>Insert title here</title>

</head>
<body>
	<div id="project_container">

		<br>
		<br>
		<br>
		<div id="top">
			<img class="img" src="images/icon/arrow.png" onclick="history.back()"
				style="width: 23px; height: 23px;">
		</div>


		<div class="row align-content-center w-100 h-100">
			<p class="fs-1 text-center">회원가입</p>
			<form action="controller?cmd=joinAction" method="post">
				<div
					class="row g-2 d-flex align-items-center justify-content-center pt-2 pb-2">
					<div class="col-3 text-end p-0">
						<label class="col-form-label">아이디</label>
					</div>
					<div class="col-7 ms-1">
						<input name="userId" type="text" id="idCheck"
							class="form-control-sm">
						<div id="idCheckFeedBack"></div>
					</div>
					<div class="col-3 text-end p-0">
						<label for="inputPassword6" class="col-form-label" >비밀번호</label>
					</div>
					<div class="col-7 ms-1">
						<input name="userPw" type="password"  id="password"
							class="form-control-sm" aria-describedby="passwordHelpInline">
					</div>
					<div class="col-3 text-end p-0">
						<label for="inputPassword6" class="col-form-label">비밀번호 확인</label>
					</div>
					<div class="col-7 ms-1">
						<input name="userPw" type="password" class="form-control-sm"
							aria-describedby="passwordHelpInline" id="checkPassword">
						<div id = "passwordCheckDiv"></div>	
					</div>
					<div class="col-3 text-end p-0">
						<label class="col-form-label">이름</label>
					</div>
					<div class="col-7 ms-1">
						<input name="name" type="text" id="inputId"
							class="form-control-sm">
					</div>
					<div class="col-3 text-end p-0">
						<label class="col-form-label">닉네임</label>
					</div>
					<div class="col-7 ms-1">
						<input name="nickname" type="text" id="nickCheck"
							class="form-control-sm">
							<div id = "nickCheckFeedBack"></div>
					</div>
					<div class="col-3 text-end p-0">
						<label class="col-form-label">전화번호</label>
					</div>
					<div class="col-7 ms-1">
						<input name="phoneNumber" type="text" id="inputId"
							class="form-control-sm">
					</div>
					<div class="col-3 text-end p-0">
						<label class="col-form-label">이메일</label>
					</div>
					<div class="col-7 ms-1">
						<input name="email" type="text" id="inputId"
							class="form-control-sm">
					</div>
					<div class="col-3 text-end p-0">
						<label class="col-form-label pt-1 mb-4">주소</label>
					</div>
					<div class="col-7 ms-1">
						<select class="form-select form-select-sm mb-2"
							aria-label=".form-select-sm example" name="cityAddress"
							onchange="selectBox1(this.value);">
							<option selected value="서울특별시">서울특별시</option>
						</select> <select class="form-select form-select-sm"
							aria-label=".form-select-smexample" name="districtAddress"
							onchange="selectBox2(this.value);">
							<option selected value="강남구">강남구</option>
							<option value="강동구">강동구</option>
							<option value="강북구">강북구</option>
							<option value="강서구">강서구</option>
						</select>
					</div>

					<div class="d-grid ps-5 pe-5 text-center mt-4 mb-3">
						<button type="submit" class="btn btn-primary btn-lg" onclick="return passwordTest()">
							<div class="text-center m">JOIN</div>
						</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<script>
/* 		function passwordTest() {

			var p1 = document.getElementById('password').value;
			var p2 = document.getElementById('checkPassword').value;
			console.log(p1);
			console.log(p2);
			if (p1 != p2) {
				alert("비밀번호가 일치 하지 않습니다");
				return false;
			} else {

				return true;
			}
		} */

		
		
 		
/*   		$("idCheck").on("change", function() {
			$.ajax({
				url : "controller?cmd=idCheckAction",
				type : "POST",
				data : {
					userId : $(this).val()
				},
				success : function(resonseText) {
					result_data = JSON.parse(resonseText);
					$("idCheckFeedBack").html(result_data.result);
					//alert(result_data.result);
				}
			});
		}); */  
		 
		//비밀번호 일치하는 지 확인
		 $(document).ready(function() {
			 $("#checkPassword").on("change", function() {
				    let nick = $(this).val();
				    $('.passwordCheckSpan').remove();
			var p1 = document.getElementById('password').value;
			var p2 = document.getElementById('checkPassword').value;

				if (p1 != p2) {
					$('#passwordCheckDiv').after("<span class='passwordCheckSpan' id='spanPassword' style='font-size:10px; color:red;'>비밀번호가 일치하지 않습니다.</span>")
				} else {
					$('#passwordCheckDiv').after("<span class='passwordCheckSpan' id='spanPassword' style='font-size:10px; color:green;'>비밀번호가 일치합니다.</span>")
				}
			 });
		 });
		
		
		
		//닉네임 중복체크
   		 $(document).ready(function() {
			  $("#nickCheck").on("change", function() {
			    let nick = $(this).val();
			    $('.nickCheckFeedBackSpan').remove();
			    $.post("controller?cmd=nickCheckAction", { nick: nick }, function(responseText) {
			    	result_data = JSON.parse(responseText);
			    	//$("nickCheckFeedBack").html(result_data.result);
			    	//alert(result_data.result);
			    	if(result_data.result == '다른 유저가 사용중인 닉네임입니다.'){
			    		$('#nickCheckFeedBack').after("<span class='nickCheckFeedBackSpan' id='spanNickname' style='font-size:10px; color:red;'>"+result_data.result+"</span>")
			    	} else {
			    		$('#nickCheckFeedBack').after("<span class='nickCheckFeedBackSpan' id='spanNickname' style='font-size:10px; color:green;'>"+result_data.result+"</span>")
			    	}	
			    });
			  });
			});   
		
		
		// 아이디 중복체크
   		$(document).ready(function() {
			  $("#idCheck").on("change", function() {
			    let id = $(this).val();
			    $('.idCheckFeedBackSpan').remove();			
			    $.post("controller?cmd=idCheckAction", { id: id }, function(responseText) {
			    	result_data = JSON.parse(responseText);
			    	//$("idCheckFeedBack").html(result_data.result);
			    	//alert(result_data.result);
			    	if(result_data.result == '다른 유저가 사용중인 아이디입니다.'){
			    		$('#idCheckFeedBack').after("<span class='idCheckFeedBackSpan' id='spanId' style='font-size:10px; color:red;'>"+result_data.result+"</span>")
			    	} else {
			    		$('#idCheckFeedBack').after("<span class='idCheckFeedBackSpan' id='spanId' style='font-size:10px; color:green;'>"+result_data.result+"</span>")
			    	} 
			    });
			  });
			}); 		
		
		
   		
   		
   		
   		
   		

    	function passwordTest() {
			var spanId = document.getElementById('spanId');
			var spanNickname = document.getElementById('spanNickname');
			var spanPassword = document.getElementById('spanPassword');
			
			if(spanId.style.color === 'red' || spanNickname.style.color === 'red' || spanPassword.style.color === 'red'){
				alert('회원가입이 불가능합니다.')
				return false;
			} else {
				return true;
			}
			
    		
    	}
   		
   		
		
	</script>

</body>
</html>