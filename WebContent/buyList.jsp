<%@page import="dto.ProductBoxDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String userId = (String)session.getAttribute("userId"); %>
<% if(userId == null) response.sendRedirect("controller?cmd=loginUI"); %>
<% ArrayList<ProductBoxDTO> buyList = (ArrayList<ProductBoxDTO>)request.getAttribute("buyList"); %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/buyList.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
.modal-title {
	color: white;
}
.modal-header, .modal-footer {
	border: none;
}
.modal-header, .modal-body, .modal-footer {
	padding: 5px;
}
.modal-content {
	background-color: #FFB966;
	width: 270px;
	height: 155px;
}
.modal-footer>button {
	background-color: #FFD9AC;
	border-color: #FFD9AC;
	color: black;
	font-weight: 600;
	margin-right: 10px;
}
.btn:hover {
	background-color: #AAAAAA;
	border-color: #AAAAAA;
}
.btn:active {
	background-color: #AAAAAA !important;
	border-color: #AAAAAA !important;
}
#starContainer {
	display: flex;
	justify-content: center;
	align-items: center;
}
.star {
	width: 50px;
	height: 50px;
	background-size: cover;
	display: inline-block;
}
#item-title-group {
	width: 100%;
}
#top {
	margin-top: 10px;
}

#buyList {
	overflow-y: scroll;
	scrollbar-width: none;
}
</style>
</head>

<body>

	<div id="project_container">
		<div id="top">
			<h6 id="top-head">구매내역</h6>
			<div></div>
		</div>

		<div class="container" id="buyList">

			<ul class="list-group w-100">
				<hr class="my-1">
				
				<% if(buyList != null){ %>
				<% for(int i=0; i<buyList.size(); i++){ %>
				<li class="list-group-item border-0 p-0">
					<div class="d-flex product_card" data-productSeq="<%= buyList.get(i).getProductSeq() %>">
						<img src="images/product/product2/product2-img1.jpg" class="img-fluid">
						<div class="ms-1">
							<div class="card-text d-flex">
								<div id="item-title-group">
									<h6><%= buyList.get(i).getTitle() %></h6>
									<p><%= buyList.get(i).getCategory() %></p>
									<p><%= buyList.get(i).getAddress() %> | 종료일 <%= buyList.get(i).getEndDate() %></p>
									<span class="badge badge-e">판매가</span> 
									<span><%= buyList.get(i).getBidMax() %>P</span> 
									<span>입찰 <%= buyList.get(i).getBidCount() %>건</span>
									

								</div>
							</div>
						</div>
					</div>
					<% if(buyList.get(i).getState().equals("T")){ %>
					<div>
						<button id="buyComplete" class="btn btn-primary rounded-pill buyComplete"
							data-bs-toggle="modal" data-bs-target="#exampleModal" 
							data-productSeq="<%= buyList.get(i).getProductSeq() %>">구매확정</button>
			 		</div>
			 		<% } else if(buyList.get(i).getState().equals("E")){ %>
					<div>
						<button id="buyEnd" class="btn btn-primary rounded-pill buyEnd" disabled>구매확정완료</button>
					</div>							 		
			 		<% } %>
				</li>
				<hr class="my-1">
				<% } %>
				<% } %>
				
			</ul>
			
			<div class="modal fade" id="exampleModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered justify-content-center">
					<div class="modal-content">
						<div class="modal-header d-flex justify-content-center">
							<h5 class="modal-title" id="exampleModalLabel">평가</h5>
						</div>
						<div class="modal-body">
							<div id="starContainer">
								<div class="star" id="star1"></div>
								<div class="star" id="star2"></div>
								<div class="star" id="star3"></div>
								<div class="star" id="star4"></div>
								<div class="star" id="star5"></div>
							</div>
						</div>
						<div class="modal-footer justify-content-center">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">취소</button>
							<button id="save" type="button" class="btn btn-primary">확인</button>
						</div>
					</div>
				</div>
			</div>
			
		</div>
		<jsp:include page="/navbar_buy.jsp"></jsp:include>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
		// 별 이미지 요소 가져오기
		const stars = document.querySelectorAll('.star');
		let num = 0;
		let productSeq = 0;

		// 각 별에 마우스 이벤트 추가
		stars.forEach(function(star, index) {
			star.style.backgroundImage = 'url("./images/icon/star_empty.png")';

			star.addEventListener('click', function(event) {
				var clickedX = event.clientX - star.getBoundingClientRect().left;
				//alert(index);
				//alert(clickedX);
				highlightStars(index, clickedX);
			});
		});

		function highlightStars(index, clickedX) {
			num = index;
			var imageWidth = 50;

			for (var i = 0; i < index; i++) {
				stars[i].style.backgroundImage = 'url("./images/icon/star_full.png")';
			}
			
			if (clickedX < imageWidth/2){
				stars[index].style.backgroundImage = 'url("./images/icon/star_half.png")';
				num += 0.5;
			} else {
				stars[index].style.backgroundImage = 'url("./images/icon/star_full.png")';
				num += 1;
			}

			for (var i = index + 1; i < stars.length; i++) {
				stars[i].style.backgroundImage = 'url("./images/icon/star_empty.png")';
			}
		}

		document.querySelector("#save").addEventListener('click', save);
		function save() {
			//alert(productSeq);
			//alert(num + '점');
			//$('#exampleModal').modal('hide');
		    $.ajax({
		        type: "POST",
		        url: "controller?cmd=setRateAction",
		        data: { 
		        	productSeq: productSeq,
		        	rate: num
	        	},
		        success: function(response) {
		            alert("평가 저장에 성공했습니다.");
		            $('#exampleModal').modal('hide');
		            location.reload();
		        },
		        error: function(xhr, status, error) {
		            alert("평가 저장에 실패했습니다.");
		        }
		    });
		}
		
		$(document).ready(function() {
			cardClick();
		});
		
		cardClick = function(){
			$(".product_card").on('click', function() {
				location.href = "controller?cmd=productInfoUI&productSeq="+ this.dataset.productseq;
			})
		};
		
		$(".buyComplete").on('click', function(){
			productSeq = this.dataset.productseq;
		});
	</script>

</body>
</html>






