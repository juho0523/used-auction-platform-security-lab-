<%@page import="vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${userId eq null}">
	<c:redirect url="controller?cmd=loginUI" />
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>호박마켓 : 메인</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<link rel='stylesheet'
	href='https://cdn-uicons.flaticon.com/2.3.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' 
	href='https://cdn-uicons.flaticon.com/2.3.0/uicons-bold-rounded/css/uicons-bold-rounded.css'>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<link rel="stylesheet" href="css/mainUI.css" />
<link rel="stylesheet" href="css/common.css" />
</head>
<body>
	<div id="project_container" class="d-flex">
		<!-- 상단바 -->
		<div class="row d-flex sticky-top pt-2 w-100" id="top1">
			<div class="d-flex align-items-center justify-content-between p-2 ">
				<div class="dropdown" id="region">
					<button class="btn btn-sm dropdown-toggle" type="button"
						id="regionBtn" data-bs-toggle="dropdown" aria-expanded="false">강남구</button>
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton"
						id="region">
						<a class="dropdown-item active" href="#">강남구</a> <a class="dropdown-item"
							href="#">강동구</a> <a class="dropdown-item" href="#">강북구</a> <a
							class="dropdown-item" href="#">강서구</a> <a class="dropdown-item"
							href="#">관악구</a><a class="dropdown-item"
							href="#">광진구</a>
					</div>
				</div>

				<input class="input-field" value="" id="search"/>
				<div class="me-2">
					<button class="input-button border-0 bg-body" id="searchBtn">
						<i class="fi fi-rr-search"></i>
					</button>
					<button class="input-button border-0 bg-body" id="noti">
						<div class="alarm"></div>
						<i class="fi fi-rr-bell"></i>
					</button>
				</div>
			</div>
		</div>
		<!-- 메인내용 -->
		<div class="row w-100 g-2">
			<div class="btn-group justify-content-between g-0 p-2 pb-0">
				<div class="dropdown" id="category">
					<button class="btn btn-sm dropdown-toggle" type="button"
						id="categoryBtn" data-bs-toggle="dropdown" aria-expanded="false">전체</button>
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
						<a class="dropdown-item active" href="#">전체</a>
						<a class="dropdown-item" href="#">디지털 기기</a> <a
							class="dropdown-item" href="#">가구/인테리어</a> <a
							class="dropdown-item" href="#">유아동</a> <a class="dropdown-item"
							href="#">의류</a> <a class="dropdown-item" href="#">잡화</a>
					</div>
				</div>

				<div class="dropdown" id="hopelist">
					<button class="btn btn-sm dropdown-toggle" type="button"
						id="hopelistBtn" data-bs-toggle="dropdown" aria-expanded="false">등록순</button>
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
						<a class="dropdown-item active" href="#">등록순</a>
						<a class="dropdown-item" href="#">입찰건순</a> <a
							class="dropdown-item" href="#">마감임박순</a>
					</div>
				</div>
			</div>
		</div>	
		<div class="row d-flex align-content-start justify-content-center overflow-y-auto w-100 h-100 p-2 pt-0"
				id="scroll">			
			<c:choose>
				<c:when test="${empty list}">
						<div class="card d-flex align-items-center border-0 mt-5 pt-5">
			 				<img src="./images/product/uploaded/logo.png" class="logo">
			  			<div class="card-body">
			    			<p class="card-text">물품이 없습니다.</p>
			  			</div>
					</div>
				</c:when>
				<c:otherwise>
			<c:forEach items='${list}' var='p'>
					<div class="card d-flex align-items-center border-0 p-2 productlist"
						data-productseq="${p.getProductSeq()}">
						<div class="row align-content-center w-100">
							<div
								class="d-flex align-items-center justify-content-center p-0">
								<div>
									<img src="uploaded/${p.getImgURL()}"
									class="thumbnail" />
								</div>
	
								<div class="ms-2 w-100">
									<div
										class="card-text d-flex align-items-start justify-content-between">
										<h6>${p.getTitle()}</h6>
										<div class="d-flex justify-content-end ms-1">
											<span class="badge badge-s">경매중</span>
										</div>
									</div>
									<div class="d-flex text-group pt-1">
										<p class="product-info">${p.getCategory()}</p>
										<p class="product-info ms-2 me-2">|</p>
										<p class="product-info">${p.getAddress()}</p>
									</div>
									<div class="text-group-point pt-1 pb-1">
										<p class="bpr m-0 text-danger" id="bidMax">
										<c:choose>
											<c:when test = "${p.getBidMax() == 0}">
												${p.getStartPrice()}
											</c:when>
											<c:otherwise>
												${p.getBidMax()}
											</c:otherwise>
										</c:choose>
										
										</p>
										<p class="pr m-0" id="nowprice">${p.getPrice()}</p>
									</div>
									<div class="d-flex justify-content-between text-group">
										<p class="product-info endDate">${p.getEndDate()}</p>
										<p class="product-info me-2">입찰 ${p.getBidCount()}건</p>
									</div>
								</div>
							</div>
						</div>
					</div>
					<hr class="m-0">
				</c:forEach>
				</c:otherwise>
			</c:choose>		
		</div>

    <% String messageContent = (String)session.getAttribute("messageContent"); %>
    <% if(messageContent != null){ %>
    <div id="alertMessage">
        <%= messageContent %>
    </div>
    <% session.removeAttribute("messageContent"); } %>

		<div class="row d-flex addProduct">
			<button class="btn btn-primary floating-btn border-0" id="addProduct">
				<i class="fi fi-br-plus"></i>
			</button>
		</div>
		<jsp:include page="/navbar_home.jsp"></jsp:include>
	</div>


	<script>
	
		// 색변경
		var userAddress = "${address}";
		$("#regionBtn").text(userAddress);
		$("#region div > a").removeClass("active");
		$("#region div > a").css("background-color", "transparent");
		$("#region div > a").each(function(){
			if(userAddress === $(this).text()){
				$(this).addClass("active");
				$(this).css("background-color", "#FF922E");
			}
		})
		$("#categoryBtn").text("전체");
		$("#category div > a").removeClass("active");
		$("#category div > a").css("background-color", "transparent");
		$("#category div > a").each(function(){
			if("전체" === $(this).text()){
				$(this).addClass("active");
				$(this).css("background-color", "#FF922E");
			}
		})
		
		$("#hopelistBtn").text("등록순");
		$("#hopelist div > a").removeClass("active");
		$("#hopelist div > a").css("background-color", "transparent");
		$("#hopelist div > a").each(function(){
			if("등록순" === $(this).text()){
				$(this).addClass("active");
				$(this).css("background-color", "#FF922E");
			}
		})

		
		// url 이동
		$("#noti").on('click', function() {
			location.href = "controller?cmd=notiUI";
		})
		$("#addProduct").on('click', function() {
			location.href = "controller?cmd=addProductUI";
		})
		
		$(document).ready(function() {
			dropboxList();
			getNoti();
			getInfiniteNoti();
			searchBtn();
			cardClick();
			priceShow();
			timeShow();
		});
		
		timeShow = function(){
			$(".endDate").each(function(){
				var str = $(this).text().split('T');
				$(this).text(str[0] + " " + str[1]);
			})
		}
	
		priceShow = function(){
			$(".bpr").each(function(){
				$(this).text("입찰가 " + Number($(this).text()).toLocaleString('ko-KR') + "P");
			})
			$(".pr").each(function(){
				$(this).text("즉구가 " + Number($(this).text()).toLocaleString('ko-KR') + "P");
			})
		}
		
		dropboxList = function() {
			// 드롭다운 text 변경
			$("#region div > a").on('click', function() {
				$("#regionBtn").text($(this).text());
				regionList($(this).text(), "지역별"); // 비동기작동
			})
			$("#category div > a").on('click', function() {
				$("#categoryBtn").text($(this).text());
				categoryList($("#regionBtn").text(), $(this).text(), "카테고리별");
			})
			$("#hopelist div > a").on('click', function() {
				$("#hopelistBtn").text($(this).text());
				hopeList($(this).text(), "선택별");
			})

			//마우스 눌렀을 경우 active 변화
			$("#region div > a").on('mousedown',function() {
				$("#region div > a").removeClass("active");
				$("#region div > a").css("background-color", "transparent");
				$(this).addClass("active");
				$(this).css("background-color", "#FF922E");
			})
			$("#category div > a").on('mousedown',function() {
				$("#category div > a").removeClass("active");
				$("#category div > a").css("background-color", "transparent");
				$(this).addClass("active");
				$(this).css("background-color", "#FF922E");
			})
			$("#hopelist div > a").on('mousedown',function() {
				$("#hopelist div > a").removeClass("active");
				$("#hopelist div > a").css("background-color", "transparent");
				$(this).addClass("active");
				$(this).css("background-color", "#FF922E");
			})
		}
		
		regionList = function(reg, sort) { // 지역별 리스트
			$.ajax({
				url : "controller?cmd=sortAction",
				type : "POST",
				data : {
					region : reg,
					sort : sort
				},
				success : function(response) {
					categoryInit();
					hopeInit();
					$("#search").val("");
					$("#scroll").html(response);
					cardClick();
					priceShow();
					timeShow();
				}
			});
		}
		
		categoryList = function(reg, cg, sort){	// 카테고리별
			$.ajax({
				url : "controller?cmd=sortAction",
				type : "POST",
				data : {
					region : reg,
					category : cg,
					sort : sort
				},
				success : function(response) {
					hopeInit();
					$("#search").val("");
					$("#scroll").html(response);
					cardClick();
					priceShow();
					timeShow();
				}
			});
		}
		
		
		
		hopeList = function(h, sort){		// 등록순, 입찰건순, 마감임박순
			$.ajax({
				url : "controller?cmd=sortAction",
				type : "POST",
				data : {
					region : userAddress,
					hope : h,
					sort : sort
				},
				success : function(response) {
					$("#search").val("");
					regionInit();
					categoryInit();
					
					$("#scroll").html(response);
					cardClick();
					priceShow();
					timeShow();
				}
			});
		}
	
		searchBtn = function() { // 상품검색
			$("#searchBtn").on("click", function() {
				$.ajax({
					url : "controller?cmd=sortAction",
					type : "POST",
					data : {
						search : $("#search").val(),
						region : userAddress,
						sort : "검색"
					},
					success : function(response) {
						regionInit();
						categoryInit();
						hopeInit();
				
						$("#scroll").html(response);
						cardClick();
						priceShow();
						timeShow();
					}
				});
			})
		};
		
		cardClick = function(){
			$(".productlist").on('click', function() {
				location.href = "controller?cmd=productInfoUI&productSeq="+ this.dataset.productseq;
			})
		}
		
		// 초기화
		
		regionInit = function(){
			$("#regionBtn").text(userAddress);
			$("#region div > a").removeClass("active");
			$("#region div > a").css("background-color", "transparent");
			$("#region div > a").each(function(){
				if(userAddress === $(this).text()){
					$(this).addClass("active");
					$(this).css("background-color", "#FF922E");
				}
			})
		}
		
		categoryInit = function(){
			$("#categoryBtn").text("전체");
			$("#category div > a").removeClass("active");
			$("#category div > a").css("background-color", "transparent");
			$("#category div > a").each(function(){
				if("전체" === $(this).text()){
					$(this).addClass("active");
					$(this).css("background-color", "#FF922E");
				}
			})
		}
		
		hopeInit = function(){
			$("#hopelistBtn").text("등록순");
			$("#hopelist div > a").removeClass("active");
			$("#hopelist div > a").css("background-color", "transparent");
			$("#hopelist div > a").each(function(){
				if("등록순" === $(this).text()){
					$(this).addClass("active");
					$(this).css("background-color", "#FF922E");
				}
			})
		}
		
		function getInfiniteNoti(){
			setInterval(function(){
				getNoti();
			},3000);		
		}
		
		function getNoti(){
			$.ajax({
				type: "POST",
				url: "controller?cmd=getUnreadAction",
				data: {	},
				success: function(result){
					var data = JSON.parse(result);
					if(data.noti === "f"){
						$(".alarm").show();
					}
					else if(data.noti === "t" || data.noti === "null"){
						$(".alarm").hide();
					}
					
				}
			});	
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

