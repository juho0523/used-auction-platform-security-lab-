<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous" 
/>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/addProduct.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id = "project_container">
	<div id = top>
		<img src="./images/icon/arrow.png">
		<h1>상품등록</h1>
	</div>
	<div id="container">
		<form action="controller?cmd=addProductAction" method="post" encType="multipart/form-data">
		<div id="img_list_container">
			<div class="img_container">
				<label for="input_file">
					<img id="camera" src="./images/icon/camera.png">
					<span id="img-count">0</span><span>/5</span>
				</label>
				<input type="file" id="input_file" name="file" accept="image/*" multiple>
			</div>
		</div>
		<hr>
		<table>
			<tr>
				<td align="right"><label class="res-label">제목</label></td>
				<td><input placeholder="제목 입력" name="title" required></td>
			</tr>
			<tr>
				<td align="right"><label class="res-label">카테고리</label></td>
				<td>
					<div class="dropdown" id="category">
					<button class="btn btn-sm dropdown-toggle" type="button"
						id="categoryBtn" data-bs-toggle="dropdown" aria-expanded="false">카테고리</button>
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
						<a class="dropdown-item active bg-warning rounded-3" href="#">카테고리</a>
						<a class="dropdown-item" href="#">디지털 기기</a> 
						<a class="dropdown-item" href="#">가구/인테리어</a> 
						<a class="dropdown-item" href="#">유아동</a> 
						<a class="dropdown-item" href="#">의류</a> 
						<a class="dropdown-item" href="#">잡화</a> 
						<input name="category" id="category_value" type="hidden" required>
					</div>
				</div>
				</td>
			</tr>
			<tr>
				<td align="right"><label class="res-label">주소</label></td>
				<td>
					<div class="dropdown" id="region">
					<button class="btn btn-sm dropdown-toggle" type="button"
						id="regionBtn" data-bs-toggle="dropdown" aria-expanded="false">강남구</button>
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton" id="region">
						<a class="dropdown-item active bg-warning rounded-3" href="#">강남구</a>
						<a class="dropdown-item" href="#">강동구</a> 
						<a class="dropdown-item" href="#">강북구</a> 
						<a class="dropdown-item" href="#">강서구</a> 
						<a class="dropdown-item" href="#">관악구</a> 
						<a class="dropdown-item" href="#">광진구</a> 
						<a class="dropdown-item" href="#">구로구</a> 
						<a class="dropdown-item" href="#">금천구</a> 
						<input name="region" id="region_value" type="hidden" required>
					</div>
				</div>
				</td>
			</tr>
			<tr>
				<td align="right"><label class="res-label">경매 기간</label></td>
				<td>
					<label id="sell_date_label" for="sell_date">
						<div class="date">
							<input id="3" type="radio" name="sell_date" value="3" checked>3일
						</div>
						<div class="date">
							<input id="5" type="radio" name="sell_date" value="5">5일
						</div>
						<div class="date">
							<input id="7" type="radio" name="sell_date" value="7">7일
						</div>
					</label>
				</td>
			</tr>
			<tr>
				<td align="right"><label class="res-label">즉시구매가</label></td>
				<td><input placeholder="즉시구매가 입력" name="price" required></td>
			</tr>
			<tr>
				<td align="right"><label class="res-label">경매시작금액</label></td>
				<td><input placeholder="경매시작금액 입력" name="start_price" required></td>
			</tr>
			<tr>
				<td valign="top" align="right"><label class="res-label">내용</label></td>
				<td><textarea name="content" placeholder="내용 입력" required></textarea></td>
			</tr>
		</table>
		<input type="submit" value="등록">
	</form>
	</div>
	<jsp:include page="/navbar_home.jsp"></jsp:include>
</div>
<script>
	$(document).ready(function(){
		$("#regionBtn").text("${address}");
		$("#region_value").val("${address}");
	})
	$("input[type=file]").on("change", function(){
		let container = document.getElementById("img_list_container");
		for(var i=0; i<this.files.length; i++){
			let newImage = document.createElement("img");
			newImage.src = URL.createObjectURL(this.files[i]);
			newImage.style.width = "50px";
			newImage.style.height = "50px";
			container.appendChild(newImage);
			$("#img-count").text(document.getElementById("img_list_container").getElementsByTagName("img").length - 1);
		}
	})
	$("#region div > a").on("click", function() {
		console.log($(this).text());
		$("#regionBtn").text($(this).text());
		$("#region_value").val($(this).text());
		$("#region div > a").removeClass("active bg-warning rounded-3");
		$(this).addClass("active bg-warning rounded-3");
	})
			
	$("#category div > a").on("click", function() {
		console.log($(this).text());
		$("#categoryBtn").text($(this).text());
		$("#category_value").val($(this).text());
		$("#category div > a").removeClass("active bg-warning rounded-3");
		$(this).addClass("active bg-warning rounded-3");
	})
	
	$("#region div > a").on('mousedown', function(){
		$("#region div > a").removeClass("active bg-warning rounded-3");
		$(this).addClass("active bg-warning rounded-3");
	})
	$("#category div > a").on('mousedown', function(){
		$("#category div > a").removeClass("active bg-warning rounded-3");
		$(this).addClass("active bg-warning rounded-3");
	})
	
	$("#top img").on("click", function(){
		history.back();
	})
	
	$("#category_value")
		$("input[name=bid_price]").on("change", function(){
		var price = Number($("input[name=price]").val());
		var bid_price = Number($(this).val());
		if(bid_price >= price){
			alert("경매시작금액은 즉시구매금액 보다 적어야 합니다!");
			this.value = null;
		}
	}) 
</script>
</body>
</html>
