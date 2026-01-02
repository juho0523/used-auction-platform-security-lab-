<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/productInfo.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div id="project_container">
		<div id=top>
			<img src="./images/icon/arrow.png" onclick="history.back()">
			<h1>상품정보</h1>
			<img id="option" src="./images/icon/option.png">
		</div>
		<div id="container">

    <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
            <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="3" aria-label="Slide 4"></button>
            <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="4" aria-label="Slide 5"></button>
            <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="5" aria-label="Slide 6"></button>
            <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="6" aria-label="Slide 7"></button>
            <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="7" aria-label="Slide 8"></button>
            <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="8" aria-label="Slide 9"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="./images/product/product1/product1-img1.jpg" class="d-block w-100" alt="Image 1">
            </div>
            <div class="carousel-item">
                <img src="./images/product/product1/product1-img2.png" class="d-block w-100" alt="Image 2">
            </div>
            <div class="carousel-item">
                <img src="./images/product/product1/product1-img3.jpg" class="d-block w-100" alt="Image 3">
            </div>
            <div class="carousel-item">
                <img src="./images/product/product1/product1-img4.png" class="d-block w-100" alt="Image 4">
            </div>
            <div class="carousel-item">
                <img src="./images/product/product1/product1-img5.png" class="d-block w-100" alt="Image 5">
            </div>
            <div class="carousel-item">
                <img src="./images/product/product1/product1-img6.jpg" class="d-block w-100" alt="Image 6">
            </div>
            <div class="carousel-item">
                <img src="./images/product/product1/product1-img7.png" class="d-block w-100" alt="Image 7">
            </div>
            <div class="carousel-item">
                <img src="./images/product/product1/product1-img8.png" class="d-block w-100" alt="Image 8">
            </div>
            <div class="carousel-item">
                <img src="./images/product/product1/product1-img9.png" class="d-block w-100" alt="Image 9">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>

			<div id="nickname">
				<div id="nickname_img_container">
					<img src="./images/icon/person.png">
				</div>
				<div id="nickname_container">
					<p>${productInfo.getNickName()}</p>
				</div>
			</div>
			<hr>
			<div id="title_container">
				<span id="title">${productInfo.getTitle()}</span> <span id="category">${productInfo.getCategory()}</span>
			</div>
			<hr>
			<div id="price">
				<span>${productInfo.getBidMax()}P</span> <span>즉시 구매가 ${productInfo.getPrice()}P</span>
			</div>
			<div id="product_state">
				<span>입찰 ${productInfo.getBidCount()}건</span> <span>경매 마감: ${productInfo.getEndDate()}</span>
			</div>
			<hr>
			<div id="button">
				<div id="bid_button">입찰</div>
				<div id="buy_button">즉시 구매</div>
			</div>
			<hr>
			<div id="content">
				<span>${productInfo.getContent()}</span>
			</div>
		</div>
		<div class="modal_default" id="bid_modal">
			<div id="bid_modal_container">
				<div id="bid_modal_top">얼마를 입찰 하시겠습니까?</div>
				<div id="bid_modal_input_container">
					<input name="bid_price" placeholder="0P">
					<span>내 포인트: ${point}</span>
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
					<p>즉시 구매가 ${productInfo.getPrice()}P</p>
					<span>내 포인트: ${point}</span>
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
				<textarea id="report_content"></textarea>
				<div id="report_modal_button_container">
					<div id="report_close">취소</div>
					<div id="add_report">접수</div>
				</div>
			</div>
		</div>
		<jsp:include page="/navbar_home.jsp"></jsp:include>
	</div>
	<script type="text/javascript">
	var startPrice = ${productInfo.getStartPrice()};
	var bidMax = ${productInfo.getBidMax()};
	var myPoint = ${point};
	var price = ${productInfo.getPrice()};
	var sellerNickName = "${productInfo.getNickName()}";
	var myNickName = "${nickName}";
	var productState = "${productInfo.getState()}";
	var productSeq = ${productInfo.getProductSeq()};
	var sellerId = "${productInfo.getId()}";
	
	$(document).ready(function() {
		if(bidMax == 0){
			$("#price :first-child").text(startPrice.toLocaleString('ko-KR') + "P");
		}
		else{
			$("#price :first-child").text(bidMax.toLocaleString('ko-KR') + "P");
		}
		$("#price :nth-child(2)").text("즉시구매가 " + price.toLocaleString('ko-KR') + "P");
	});
	$("#chat").click(function(){
		console.log(sellerId);
		location.href = "controller?cmd=chatUI&productSeq=" + productSeq +"&toId=" + sellerId;
	})
	$("#add_report").click(function(){
		var reportContent = $("#report_content").val();
		alert("신고가 접수되었습니다!");
		location.href = "controller?cmd=reportAction&productSeq=" + productSeq + "&reportContent=" + reportContent;
	})
	
	$("#add_bid").click(function(){
		var bidPrice = Number($("input[name=bid_price]").val());
		if(bidPrice <= bidMax){
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