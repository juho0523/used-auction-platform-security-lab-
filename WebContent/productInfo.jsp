<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${userId eq null}">
	<c:redirect url="controller?cmd=loginUI" />
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/productInfo.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<title>메인 : 게시글 정보</title>
</head>
<body>
<div id="project_container">
	<div id="top">
		<img src="./images/icon/arrow.png" onclick="history.back()">
		<h1>상품정보</h1>
		<img id="option" src="./images/icon/option.png">
	</div>

	<div id="container">

		<div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-inner">
				<div class="d-flex justify-content-center carousel-item active">
					<img
						src="uploaded/<c:out value='${productInfo.imgURL}'/>"
						class="d-block"
						alt="Image 1"
						onerror="this.onerror=null; this.src='images/product/uploaded/logo.png'">
				</div>
			</div>
		</div>

		<div id="nickname">
			<div id="nickname_img_container">
				<img src="./images/icon/person.png">
			</div>
			<div id="nickname_container">
				<p><c:out value="${productInfo.nickName}"/></p>
			</div>
		</div>

		<hr>

		<div id="title_container">
			<span id="title"><c:out value="${productInfo.title}"/></span>
			<span id="category"><c:out value="${productInfo.category}"/></span>
		</div>

		<hr>

		<div id="price">
			<span><c:out value="${productInfo.bidMax}"/>P</span>
			<span>즉시 구매가 <c:out value="${productInfo.price}"/>P</span>
		</div>

		<div id="product_state">
			<span>입찰 <c:out value="${productInfo.bidCount}"/>건</span>
			<span id="end_date"><c:out value="${productInfo.endDate}"/></span>
		</div>

		<hr>

		<div id="content">
			<span><c:out value="${productInfo.content}"/></span>
		</div>

	</div>

	<div class="modal_default" id="bid_modal">
		<div id="bid_modal_container">
			<div id="bid_modal_top">얼마를 입찰 하시겠습니까?</div>
			<div id="bid_modal_input_container">
				<input name="bid_price" placeholder="0P">
				<span>내 포인트: <c:out value="${point}"/></span>
			</div>
			<div id="bid_modal_button_container">
				<div id="add_bid">확인</div>
				<div class="close">취소</div>
			</div>
		</div>
	</div>

	<div class="modal_default" id="buy_modal">
		<div id="buy_modal_container">
			<div id="buy_modal_top">즉시 구매 하시겠습니까?</div>
			<div id="buy_modal_input_container">
				<p>즉시 구매가 <c:out value="${productInfo.price}"/>P</p>
				<span>내 포인트: <c:out value="${point}"/></span>
			</div>
			<div id="buy_modal_button_container">
				<div id="buy">확인</div>
				<div class="close">취소</div>
			</div>
		</div>
	</div>

	<div class="modal_default" id="option_modal">
		<div class="option_button" id="chat">1:1 채팅</div>
		<div class="option_button" id="report_button">신고하기</div>
	</div>

	<div class="modal_default" id="report_modal">
		<div id="report_modal_container">
			<div id="report_modal_top">신고사유</div>
			<textarea id="report_content" name="content" placeholder="신고 내용을 입력해주세요."></textarea>
			<div id="report_modal_button_container">
				<div id="report_close">취소</div>
				<div id="add_report">접수</div>
			</div>
		</div>
	</div>

	<div id="bottom">
		<div id="button">
			<div id="bid_button">입찰</div>
			<div id="buy_button">즉시 구매</div>
		</div>
		<jsp:include page="/navbar_home.jsp"/>
	</div>
</div>
	<script type="text/javascript">
	var startPrice = "${productInfo.getStartPrice()}";
	var bidMax = "${productInfo.getBidMax()}";
	var myPoint = "${point}";
	var price = "${productInfo.getPrice()}";
	var sellerNickName = "${productInfo.getNickName()}";
	var myNickName = "${nickName}";
	var productState = "${productInfo.getState()}";
	var productSeq = "${productInfo.getProductSeq()}";
	var sellerId = "${productInfo.getId()}";
	var myId = "${userId}"
	var endDateStr = $("#end_date").text().split('T');
	$(document).ready(function() {
		if(bidMax == 0){
			$("#price :first-child").text(startPrice.toLocaleString('ko-KR') + "P");
		}
		else{
			$("#price :first-child").text(bidMax.toLocaleString('ko-KR') + "P");
		}
		$("#price :nth-child(2)").text("즉시구매가 " + price.toLocaleString('ko-KR') + "P");
		$("#end_date").text("경매 마감: " + endDateStr[0] + " " + endDateStr[1]);
	});
	$("#chat").click(function(){
		if(sellerId == myId){
			alert("자신과는 채팅을 할 수 없습니다!");
			return;
		}
		location.href = "controller?cmd=chatUI&productSeq=" + productSeq +"&toId=" + sellerId;
	})
	
	$("#add_report").click(function(){
		var reportContent = $("#report_content").val();
 		if(reportContent == ""){
			alert("신고내용을 입력해주세요!");
			return;
		}
		alert("신고가 접수되었습니다!");
		location.href = "controller?cmd=reportAction&productSeq=" + productSeq + "&reportContent=" + reportContent;
	})
	
	$("#add_bid").click(function(){
		var bidPrice = Number($("input[name=bid_price]").val());
		if(bidPrice <= bidMax || bidPrice < startPrice){
			alert("입찰금액이 현재 최대 입찰금액 보다 적습니다!");
			return;
		}
		if(myPoint <= bidPrice){
			alert("포인트가 부족합니다!");
			return;
		}
		if(bidPrice >= price){
			alert("즉시구매를 이용해주세요!");
			return;
		}
		alert("입찰완료!");
		location.href = "controller?cmd=bidAction&productSeq=" + productSeq + "&bidPrice=" + bidPrice;
	})
	$("#buy").click(function(){
		if(myPoint < price){
			alert("포인트가 부족합니다!");
			return;
		}
		
		alert("구매완료!");
		location.href = "controller?cmd=bidAction&productSeq=" + productSeq + "&bidPrice=" + price;
	})
	$("#bid_button").click(function(){
		if(productState != 'S'){
			alert("판매가 종료된 물품입니다!");
			return;
		}
		if(sellerNickName == myNickName){
			alert("본인 물품에는 입찰 할 수 없습니다!");
			return;
		}
		$("#bid_modal")[0].style.display="flex";
		$("#bid_modal")[0].style.position="absolute";
	});
	$("#buy_button").click(function(){
		if(sellerNickName == myNickName){
			alert("본인 물품은 구매 할 수 없습니다!");
			return;
		}
		if(productState != 'S'){
			alert("판매가 종료된 물품입니다!");
			return;
		}
		$("#buy_modal")[0].style.display="flex";
		$("#buy_modal")[0].style.position="absolute";
	})
	$(".close").click(function(){
		$("#bid_modal")[0].style.display="none";
		$("#buy_modal")[0].style.display="none";
	});
	$("#option").click(function(){
		$("#option_modal")[0].style.display="flex";
		$("#option_modal")[0].style.position="absolute";
	});
	$("#container").click(function(){
		$("#option_modal")[0].style.display="none";
	});
	$("#report_button").click(function(){
		if(sellerId == myId){
			alert("본인의 게시글에는 신고 할 수 없습니다!");
			return;
		}
		$("#option_modal")[0].style.display="none";
		$("#report_modal")[0].style.display="flex";
		$("#report_modal")[0].style.position="absolute";
	});
	$("#report_close").click(function(){
		$("#report_modal")[0].style.display="none";
	});
</script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>