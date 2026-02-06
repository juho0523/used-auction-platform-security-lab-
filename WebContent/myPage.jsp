<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${userId eq null}">
	<c:redirect url="controller?cmd=loginUI" />
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="css/common.css">
<!-- <link rel="stylesheet" href="css/myPage.css"> -->
<title>호박마켓 : 마이페이지</title>
<style>
.suicideBtn:hover {
      background-color:#FFD9AC;
		color:#000000;
  }
  
.stopSuicideBtn:hover{
	color:#000000;
	background-color:#FFD9AC;
}

#imgIcon {
	width: 60px;
	height: 60px;
}

.pointTxt {
	text-align: center;
	transform: translateX(40%);
}

.pointFont {
	font-size: 2em;
}

.nicknameP {
	transform: translateY(40%);
	font-size: 15px;
	text-align: right
}

.rateP {
	transform: translateY(-5%);
	font-size: 15px;
	text-align: right;
	width: 100px;
}

.modal-header {
	background-color: #FF922E;
}

.modal-body {
	background-color: #FF922E;
}

.modal-title {
	background-color: #FF922E;
	color: #FFFFFF;
}

.modal-footer {
	background-color: #FF922E;
}

#modalBtn {
	background-color: #FFD9AC !important;
	color: #000000;
}

a {
	text-decoration: none;
	color: #FFFFFF;
}

.btn {
	background-color: #FF922E;
	border: none;
}

#myActButton {
	z-index: 10;
	transform: translateX(40%);
}

.nickRateP {
	transform: translateY(20%);
}

.imgLocation {
	
}

.cBeB {
	display: flex;
	flex-wrap: nowrap;
	transform: translateX(20%);
}

.chargeButton {
	transform: translateX(-25%);
}

.aButtons {
	transform: translateX(17%);
}

.loPointFont {
	transform: translateX(17%);
}


button {
	white-space: nowrap;
}

.exchangeButton {
	transform: translateX(40%);
}

.suicideBtn{
	background-color:#FFD9AC;
	color:#000000;
}

.stopSuicideBtn{
	background-color:#FFD9AC;
	color:#000000;
}
</style>
</head>
<body>


	<div id="project_container">
		<div class="container-fulid">
			<table class="table">
				<thead>
					<tr class="table-borderless">
						<th class="col-md-3">
							<div class="imgLocation">
								<img src="images/icon/icon.png"
									class="img-fluid rounded-circle border" id="imgIcon">
							</div>
						</th>
						<th></th>
						<th class="maPageInfo">
							<div class="nickRateP mt-4">
								<p class="nicknameP"><%=request.getAttribute("nickname")%></p>
								<p class="rateP">
									★<%=request.getAttribute("rate")%></p>
							</div>

						</th>
						<th></th>
					</tr>
					<tr>
						<th class="pointTxt">
							<div class="loPointFont" id="loPointFontDiv">
								<p class="pointFont" id="myPoint"><%=request.getAttribute("point")%></p>
							</div>
							<div class="cBeB">
								<div class="chargeButton">

									<button type="button" class="btn btn-primary"
										data-bs-toggle="modal" data-bs-target="#chargeModal">
										충전</button>
								</div>
								<div class="exchangeButton">

									<button type="button" class="btn btn-primary"
										data-bs-toggle="modal" data-bs-target="#exchangeModal">
										환전</button>
								</div>
							</div>
						</th>
						<th></th>
						<th></th>
						<th></th>
					</tr>
					<tr>

						<th id="myActButton" class="border-0">
							<div class="aButtons">
								<br>
								<button type="button" class="btn btn-primary">
									<a href="controller?cmd=setMyInfoUI">회원정보수정</a>
								</button>
								<br> <br>
								<button type="button" class="btn btn-primary">
									<a href="controller?cmd=logoutAction">ㅤ로그아웃ㅤ</a>
								</button>
								<br> <br>
								<button type="button" class="btn btn-primary"
									data-bs-toggle="modal" data-bs-target="#deleteMeModal">
									ㅤ회원탈퇴ㅤ</button>
							</div>
						</th>

					</tr>

				</thead>
			</table>


			<!-- Modal -->
			<div class="modal fade" id="chargeModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div
					class="modal-dialog modal-dialog-centered justify-content-center">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">얼마를 충전하시겠습니까?</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<!-- <form action="controller?cmd=myPointAction" method="post"> -->
						<div class="modal-body">
							<input class="form-control form-control-lg" type="number"
								name="plusPoint" id="plusPoint">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" id="modalBtn"
								data-bs-dismiss="modal">닫기</button>

							<button type="submit" class="btn btn-primary" id="modalBtn">확인</button>

						</div>
						<!-- </form> -->
					</div>
				</div>
			</div>





			<!-- Modal -->
			<div class="modal fade" id="exchangeModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div
					class="modal-dialog modal-dialog-centered justify-content-center">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">얼마를 환전하시겠습니까?</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<!-- <form action="controller?cmd=myPointAction" method="post"> -->
						<div class="modal-body">
							<input class="form-control form-control-lg" type="number"
								name="minusPoint" id="minusPoint">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" id="modalBtn"
								data-bs-dismiss="modal">닫기</button>

							<button type="submit" class="btn btn-primary" id="modalBtn">확인</button>

						</div>
						<!-- </form> -->
					</div>
				</div>
			</div>




			<!-- Modal -->
			<div class="modal fade" id="deleteMeModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div
					class="modal-dialog modal-dialog-centered justify-content-center">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">주의사항</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<!-- <form action="controller?cmd=myPointAction" method="post"> -->
						<div class="modal-body">
							<div class="form-check">
								<input class="form-check-input" type="checkbox" value=""
									id="flexCheckDefault1" > <label
									class="form-check-label" for="flexCheckDefault">
									1. 탈퇴 후 서비스 이용내역 확인이 불가능합니다. </label>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="checkbox" value=""
									id="flexCheckDefault2"> <label
									class="form-check-label" for="flexCheckDefault">
									2. 탈퇴 후 서비스 내에서 충전한 포인트는 소멸됩니다. </label>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="checkbox" value=""
									id="flexCheckDefault4" > <label
									class="form-check-label" for="flexCheckDefault">
									3. 탈퇴 후 동일한 아이디로 재가입이 불가능합니다. </label>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="stopSuicideBtn btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
							<a href="controller?cmd=deleteMyInfoAction">
								<button type="submit" class="suicideBtn btn btn-primary" onclick = "return deleteMe()">확인</button>
							</a>
						</div>
						<!-- </form> -->
					</div>
				</div>
			</div>




		</div>
		<jsp:include page="/navbar_my.jsp"></jsp:include>
	</div>
	<script type="text/javascript">
		$(".pointFont").text(
				Number($(".pointFont").text()).toLocaleString('ko-KR') + "P");

		$(document)
				.ready(
						function() {
							$("#modalBtn.btn-primary")
									.on(
											"click",
											function() {
												var pointAct = 0;
												var numP = parseInt(document
														.getElementById("plusPoint").value) || 0;
												var numM = parseInt(document
														.getElementById("minusPoint").value) || 0;

												var numberStr = document
														.getElementById("myPoint").textContent;
												var numMyPoint = parseInt(numberStr
														.replace(/,/g, ""));

												if (numP < 0 || numM < 0) {
													alert('음수 입력불가.')
													return;
												}

												if (numP > 0) {
													pointAct = pointAct + numP;
												}

												if (numP == 0 && numM == 0) {
													alert('포인트를 입력해주세요.')
													return;
												}

												console.log(numP);
												console.log(numM);
												console.log(numMyPoint);
												if (numM <= numMyPoint) {
													pointAct = pointAct - numM;
												} else {
													alert('포인트가 부족합니다.')
													return;
												}

												$
														.post(
																"controller?cmd=myPointAction",
																{
																	pointAct : pointAct
																},
																function(
																		responseText) {
																	var actPoint = parseInt(pointAct);

																	if (actPoint > 0) {
																		alert('포인트 충전 완료.');
																		$(
																				'#chargeModal')
																				.modal(
																						'hide');
																		location
																				.reload();
																	} else if (actPoint < 0) {
																		alert('포인트 환전 완료.');
																		$(
																				'#exchangeModal')
																				.modal(
																						'hide');
																		location
																				.reload();
																	} else {
																		alert('알 수 없는 오류가 발생했습니다.');
																	}
																});
											});
						});
		
		
		
		function deleteMe(){
		const checkDelete1 = document.getElementById('flexCheckDefault1');
		const checkDelete2 = document.getElementById('flexCheckDefault2');
		const checkDelete4 = document.getElementById('flexCheckDefault4');

		if(checkDelete1.checked && checkDelete2.checked && checkDelete4.checked){
			alert('회원 탈퇴가 완료됐습니다.')
			return true;
		}else{
			alert('주의사항을 확인해주세요.')
			return false;
		}
		
		}
		
		
		
		
		
		
	</script>
</body>
</html>