<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/notiUI.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>

<body>

	<div id="project_container">

		<div class="row d-flex sticky-top pt-2" id="top1">
			<div class="d-flex align-items-center justify-content-between p-2 ">
				<div class="m-0" id="pre">
					<img src="images/icon/arrow.png" id="previous" class="ms-2">
				</div>
				<div>
					<h6 class="m-0 pe-4" id="top-head">알림</h6>
				</div>
			</div>
		</div>
		<div
			class="row d-flex align-content-start justify-content-center overflow-y-auto w-100 h-100 p-2"
			id="scroll">

			<c:forEach items='${list}' var='p'>
				<div class="card d-flex align-items-center border-0 ps-2 pe-2"
					data-productseq="${p.getProductSeq()}">
					<div class="row align-content-center w-100">
						<div
							class="d-flex align-items-center justify-content-center h-100 ps-0 pe-0">
							<img src="images/product/product1/product1-img1.jpg"
								class="img-fluid">
							<div class="ms-2 w-100">
								<div class="card-text d-flex align-items-start">
									<div
										class="d-flex align-items-center justify-content-start me-1">

										<c:choose>
											<c:when test="${p.getProductUserId().equals(userId)}">
												<span class="badge badge-s">판매품</span>
											</c:when>
											<c:otherwise>
												<span class="badge bg-info">구매품</span>
											</c:otherwise>
										</c:choose>
									</div>
									<div id="item-title-group">
										<h6>${p.getTitle()}</h6>
										<p class="p-0 pt-1">${p.getCategory()}</p>
									</div>
								</div>
								<div class="m-0">
									<span class="noti-content">[${p.getNickname()}]님이
									</span> <span class="pr">${p.getPrice()}</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<hr class="m-2">
			</c:forEach>
		</div>

		<jsp:include page="/navbar_home.jsp"></jsp:include>
	</div>
	<script>
		$(document).ready(function() {
			$(".pr").each(function(){
				$(this).text(Number($(this).text()).toLocaleString('ko-KR') + "P에 입찰하셨습니다.");
			})
			cardClick();
			
			$("#previous").on('click', function(){
				location.href = document.referrer;
			})
			
		})
		cardClick = function(){
			$(".card").on('click', function() {
				location.href = "controller?cmd=productInfoUI&productSeq="+ this.dataset.productseq;
			})
		}
	</script>
</body>

</html>