<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${userId eq null}">
	<c:redirect url = "controller?cmd=loginUI"/>
</c:if>
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
<title>메인 : 글 등록</title>
</head>
<body>

<div id = "project_container">
	<div id = top>
		<img src="./images/icon/arrow.png">
		<h1>상품등록</h1>
	</div>
	<div id="container">
		<form id="addForm" action="controller?cmd=addProductAction"
      method="post"
      encType="multipart/form-data"
      onsubmit="return addSubmit()">

    <input type="hidden" name="csrfToken" value="${csrfToken}"><div id="img_list_container">
			<div class="img_container">
				<label for="input_file">
					<img id="camera" src="./images/icon/camera.png">
					<span id="img-count">0</span><span>/1</span>
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
						<a class="dropdown-item active" href="#">카테고리</a>
						<a class="dropdown-item" href="#">디지털 기기</a> 
						<a class="dropdown-item" href="#">가구/인테리어</a> 
						<a class="dropdown-item" href="#">유아동</a> 
						<a class="dropdown-item" href="#">의류</a> 
						<a class="dropdown-item" href="#">잡화</a> 
						<input name="category" id="category_value" type="hidden" value="카테고리" required>
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
						<a class="dropdown-item active" href="#">강남구</a>
						<a class="dropdown-item" href="#">강동구</a> 
						<a class="dropdown-item" href="#">강북구</a> 
						<a class="dropdown-item" href="#">강서구</a> 
						<a class="dropdown-item" href="#">관악구</a> 
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
	const csrfToken = '${csrfToken}';
	$("#addForm").on("submit", function(e){
    e.preventDefault();

    const formData = new FormData(this);

    fetch(this.action, {
        method: "POST",
        headers: {
            "X-CSRF-Token": csrfToken
        },
        body: formData
    }).then(res => {
        if(res.ok) {
            location.href = "controller?cmd=mainUI";
        } else {
            alert("403 발생");
        }
    });
});

	var userAddress = "${address}";
	$(document).ready(function(){
		$("#regionBtn").text("${address}");
		$("#region_value").val("${address}");
		$("#region div > a").removeClass("active");
		$("#region div > a").css("background-color", "transparend");
		$("#region div > a").each(function(){
			if(userAddress === $(this).text()){
				$(this).addClass("active");
				$(this).css("background-color", "#FF922E");
			}
		})
		$("#categoryBtn").text("카테고리");
		$("#category div > a").removeClass("active");
		$("#category div > a").css("background-color", "transparent");
		$("#category div > a").each(function(){
			if("카테고리" === $(this).text()){
				$(this).addClass("active");
				$(this).css("background-color", "#FF922E");
			}
		})
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
		$("#regionBtn").text($(this).text());
		$("#region_value").val($(this).text());
	})
			
	$("#category div > a").on("click", function() {
		$("#categoryBtn").text($(this).text());
		$("#category_value").val($(this).text());
	})
	
	$("#region div > a").on('mousedown', function(){
		$("#region div > a").removeClass("active");
		$("#region div > a").css("background-color", "transparent");
		$(this).addClass("active");
		$(this).css("background-color", "#FF922E");
	})
	$("#category div > a").on('mousedown', function(){
		$("#category div > a").removeClass("active");
		$("#category div > a").css("background-color", "transparent");
		$(this).addClass("active");
		$(this).css("background-color", "#FF922E");
	})
	
	$("#top img").on("click", function(){
		history.back();
	})
	
	$("input[name=start_price]").on("change", function(){
		var price = Number($("input[name=price]").val());
		var bid_price = Number($(this).val());
		if(bid_price >= price){
			alert("경매시작금액은 즉시구매금액 보다 적어야 합니다!");
			this.value = null;
		}
	})
	
	function addSubmit(){
		if($("#input_file").val() == ""){
			alert("상품 이미지를 등록해주세요!");
			return false;
		}
		if($("#category_value").val() == "카테고리"){
			alert("카테고리를 선택해주세요!");
			return false;
		}
		return true;
	}
</script>
</body>
</html>

