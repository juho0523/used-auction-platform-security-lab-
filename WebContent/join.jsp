<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<link rel="stylesheet" href="css/join.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.0.0/crypto-js.min.js"></script>
	<title>호박마켓 : 회원가입</title>
	<style>
		.fontJoinP {
			font-size: 27.4px;
		}
		.selectItems {
			font-size: 10px;

		}
		.selectCity {
			height: 30px;
		}
		.selectDistrict {
			height: 30px;
		}
	</style>
</head>

<body>
	<div id="project_container">
		<br> <br> <br>
		<div id="top">
			<img class="img ms-2 mt-2" src="images/icon/arrow.png" onclick="history.back()" style="width: 23px; height: 23px;">
		</div>
		<div class="row align-content-center w-100 h-100">
			<p class="fontJoinP text-center">회원가입</p>
			<form action="controller?cmd=joinAction" method="post" id="joinForm" onsubmit="hashFormData(event)">
				<div class="row g-2 d-flex align-items-center justify-content-center pt-2 pb-2">
					<div class="col-3 text-end p-0">
						<label class="col-form-label">아이디</label>
					</div>
					<div class="col-7 ms-1">
						<input name="userId" type="text" id="idCheck" class="form-control-sm">
						<div id="idCheckFeedBack"></div>
					</div>
					<div class="col-3 text-end p-0">
						<label for="inputPassword6" class="col-form-label">비밀번호</label>
					</div>
					<div class="col-7 ms-1">
						<input name="userPw" type="password" id="password" class="form-control-sm" aria-describedby="passwordHelpInline">
					</div>
					<div class="col-3 text-end p-0">
						<label for="inputPassword6" class="col-form-label">비밀번호 확인</label>
					</div>
					<div class="col-7 ms-1">
						<input name="userPw" type="password" class="form-control-sm" aria-describedby="passwordHelpInline" id="checkPassword">
						<div id="passwordCheckDiv"></div>
					</div>
					<div class="col-3 text-end p-0">
						<label class="col-form-label">이름</label>
					</div>
					<div class="col-7 ms-1">
						<input name="name" type="text" id="nameInput" class="form-control-sm">
					</div>
					<div class="col-3 text-end p-0">
						<label class="col-form-label">닉네임</label>
					</div>
					<div class="col-7 ms-1">
						<input name="nickname" type="text" id="nickCheck" class="form-control-sm">
						<div id="nickCheckFeedBack"></div>
					</div>
					<div class="col-3 text-end p-0">
						<label class="col-form-label">전화번호</label>
					</div>
					<div class="col-7 ms-1">
						<input name="phoneNumber" type="text" id="phoneNumberInput" class="form-control-sm">
					</div>
					<div class="col-3 text-end p-0">
						<label class="col-form-label">이메일</label>
					</div>
					<div class="col-7 ms-1">
						<input name="email" type="text" id="emailInput" class="form-control-sm">
					</div>
					<div class="col-3 text-end p-0">
						<label class="col-form-label pt-1 mb-4">주소</label>
					</div>
					<div class="col-7 ms-1">
						<select class="selectCity form-select form-select-sm mb-2" aria-label=".form-select-sm example" name="cityAddress" onchange="selectBox1(this.value);">
							<option selected value="서울특별시">서울특별시</option>
						</select>
						<select class="selectDistrict form-select form-select-sm" aria-label=".form-select-smexample" name="districtAddress" onchange="selectBox2(this.value);">
							<option selected class="selectItems">강남구</option>
							<option value="강동구" class="selectItems">강동구</option>
							<option value="강북구" class="selectItems">강북구</option>
							<option value="강서구" class="selectItems">강서구</option>
							<option value="관악구" class="selectItems">관악구</option>
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

		<% String messageContent=(String)session.getAttribute("messageContent"); %>
			<% if(messageContent !=null){ %>
				<div id="alertMessage">
					<%= messageContent %>
				</div>
				<% session.removeAttribute("messageContent"); } %>

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
		$(document).ready(function () {
			$("#checkPassword").on("change", function () {
				$('.passwordCheckSpan').remove();
				var p1 = document.getElementById('password').value;
				var p2 = document.getElementById('checkPassword').value;

				if (p1 != p2) {
					$('#passwordCheckDiv').after("<span class='passwordCheckSpan' id='spanPassword' style='font-size:10px; color:red;'>비밀번호가 일치하지 않습니다.</span>")
				} else {
					$('#passwordCheckDiv').after("<span class='passwordCheckSpan' id='spanPassword' style='font-size:10px; color:green;'>비밀번호가 일치합니다.</span>")
				}

				if (p1 == '' || p2 == '') {
					$('.passwordCheckSpan').remove();
				}
			});
		});

		$(document).ready(function () {
			$("#password").on("change", function () {
				$('.passwordCheckSpan').remove();
				var p1 = document.getElementById('password').value;
				var p2 = document.getElementById('checkPassword').value;

				if (p1 != p2) {
					$('#passwordCheckDiv').after("<span class='passwordCheckSpan' id='spanPassword' style='font-size:10px; color:red;'>비밀번호가 일치하지 않습니다.</span>")
				} else {
					$('#passwordCheckDiv').after("<span class='passwordCheckSpan' id='spanPassword' style='font-size:10px; color:green;'>비밀번호가 일치합니다.</span>")
				}

				if (p1 == '' || p2 == '') {
					$('.passwordCheckSpan').remove();
				}
			});
		});

		//닉네임 중복체크
		$(document).ready(function () {
			$("#nickCheck").on("change", function () {
				let nick = $(this).val();
				$('.nickCheckFeedBackSpan').remove();
				$.post(
					"controller?cmd=nickCheckAction",
					{
						nick: nick
					},
					function (responseText) {
						result_data = JSON.parse(responseText);
						//$("nickCheckFeedBack").html(result_data.result);
						//alert(result_data.result);
						if (result_data.result == '다른 유저가 사용중인 닉네임입니다.') {
							$('#nickCheckFeedBack').after("<span class='nickCheckFeedBackSpan' id='spanNickname' style='font-size:10px; color:red;'>" + result_data.result + "</span>")
						} else {
							$('#nickCheckFeedBack').after("<span class='nickCheckFeedBackSpan' id='spanNickname' style='font-size:10px; color:green;'>" + result_data.result + "</span>")
						}

						if (nick == '') {
							$('.nickCheckFeedBackSpan').remove();
						}

					});
			});
		});

		// 아이디 중복체크
		$(document).ready(function () {
			$("#idCheck").on("change", function () {
				let id = $(this).val();
				$('.idCheckFeedBackSpan').remove();
				$.post(
					"controller?cmd=idCheckAction",
					{
						id: id
					},
					function (responseText) {
						result_data = JSON.parse(responseText);
						//$("idCheckFeedBack").html(result_data.result);
						//alert(result_data.result);
						if (result_data.result == '다른 유저가 사용중인 아이디입니다.') {
							$('#idCheckFeedBack').after("<span class='idCheckFeedBackSpan' id='spanId' style='font-size:10px; color:red;'>" + result_data.result + "</span>")
						} else {
							$('#idCheckFeedBack').after("<span class='idCheckFeedBackSpan' id='spanId' style='font-size:10px; color:green;'>" + result_data.result + "</span>")
						}

						if (id == '') {
							$('.idCheckFeedBackSpan').remove();
						}

					});
			});
		});

		function passwordTest() {
			var spanId = document.getElementById('spanId');
			var spanNickname = document.getElementById('spanNickname');
			var spanPassword = document.getElementById('spanPassword');

			var idCheck = document.getElementById('idCheck').value;
			var password = document.getElementById('password').value;
			var checkPassword = document.getElementById('checkPassword').value;
			var nameInput = document.getElementById('nameInput').value;
			var nickCheck = document.getElementById('nickCheck').value;
			var phoneNumberInput = document.getElementById('phoneNumberInput').value;
			var emailInput = document.getElementById('emailInput').value;

			if (idCheck == ''
				|| password == ''
				|| checkPassword == ''
				|| nickCheck == ''
				|| phoneNumberInput == ''
				|| emailInput == '') {
				alert('정보를 입력해주세요.')
				return false;
			}

			if (spanId.style.color === 'red'
				|| spanNickname.style.color === 'red'
				|| spanPassword.style.color === 'red') {
				alert('회원가입이 불가능합니다.')
				return false;
			} else {
				alert('회원가입 성공.')
				return true;
			}

		}
	</script>

	<script>
		function hashFormData(event) {
			event.preventDefault();
			var form = document.getElementById("joinForm");
			var formData = new FormData(form);
			var password = formData.get("userPw");
			if (password === '') {
				form.submit();
				return;
			}
			var hashedPassword = CryptoJS.SHA256(password).toString(CryptoJS.enc.Hex);
			document.getElementById("password").value = hashedPassword;
			form.submit();
		}
	</script>

	<script>
		setTimeout(function () {
			var alertElement = document.getElementById('alertMessage');
			if (alertElement) {
				alertElement.classList.add('fade');
				alertElement.addEventListener('transitionend', function () {
					alertElement.remove();
				});
			}
		}, 2000);
	</script>

</body>

</html>