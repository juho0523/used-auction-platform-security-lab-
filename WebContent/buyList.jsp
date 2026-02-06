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
<title>호박마켓 : 구매내역</title>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/buyList.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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

.button {
  float: right !important;
  margin-left: auto;
  margin-right: 10px;
}
.truncate {
    width: 160px;
    white-space: nowrap; 
    overflow: hidden;
    text-overflow: ellipsis;
    margin: 0px;
}
</style>
</head>

<body>

	<div id="project_container">
		<div id="top">
			<h6 id="top-head">구매내역</h6>
			<div></div>
		</div>

    <div class="button">
      <button id="selling" class="btn btn-primary rounded-pill">구매중</button>
      <button id="sellComplete" class="btn btn-primary rounded-pill">구매종료</button>
    </div>

		<div class="container" id="buyList">
			<hr class="my-1">
			
        <c:if test="${empty buyList}">
        <div class="card d-flex align-items-center border-0 mt-5 pt-5">
          <img src="./images/product/uploaded/logo.png" class="logo">
          <div class="card-body">
              <p class="card-text">구매 내역이 없습니다.</</p>
          </div>
        </div>
        </c:if>			
			
			<ul class="list-group w-100">
				
				<% if(buyList != null){ %>
        <% for(int i=0; i<buyList.size(); i++){ %>
        <div class="d-flex product_card" data-productSeq="<%= buyList.get(i).getProductSeq() %>">
          <img src="uploaded/<%= buyList.get(i).getImgURL() %>" 
            alt="상품이미지" onerror="this.onerror=null; this.src='images/product/uploaded/logo.png'"
            class="img-fluid">
          <div class="ms-1">
            <div class="card-text d-flex">
              <div id="item-title-group">
                <div class="d-flex product_title">
                  <h6 class="truncate"><%= buyList.get(i).getTitle() %></h6>
                  <% if(buyList.get(i).getState().equals("S")){ %>
                  <span class="badge badge-s">판매중</span>
                  <% } else if(buyList.get(i).getState().equals("T")) {  %>
                  <span class="badge bg-info">거래중</span>
                  <% } %>
                </div>
                <p><%= buyList.get(i).getCategory() %></p>
                <p class="end_date"><%= buyList.get(i).getAddress() %>
                  | 종료일
                  <%= buyList.get(i).getEndDate() %></p>
                <span class="badge badge-s">입찰가</span> 
                <% if(buyList.get(i).getBidMax() == 0){ %>
                <span><%= buyList.get(i).getStartPrice() %>P</span> 
                <% } else {%>
                <span><%= buyList.get(i).getBidMax() %>P</span> 
                <% } %>
                <span class="badge badge-s">즉구가</span> 
                <span><%= buyList.get(i).getPrice() %>P</span>
                <span>입찰 <%= buyList.get(i).getBidCount() %>건
                </span>
              </div>
            </div>
          </div>
        </div>
        <hr class="my-1">
        <% } %>
				<% } %>
				
			</ul>
			

			
		</div>
		<jsp:include page="/navbar_buy.jsp"></jsp:include>
	</div>
	
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
			$(".end_date").each(function(){
				var str = $(this).text().split('T');
				$(this).text(str[0] + " " + str[1]);
			})
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

    document.addEventListener('DOMContentLoaded', function() {
        var selling = document.querySelector('#selling');
        var sellComplete = document.querySelector('#sellComplete');

        selling.style.backgroundColor = '#E07F39';
        selling.style.borderColor = '#E07F39';

        selling.addEventListener('click', function(){
            selling.style.backgroundColor = '#E07F39';
            selling.style.borderColor = '#E07F39';

            sellComplete.style.backgroundColor = '#FFB966';
            sellComplete.style.borderColor = '#FFB966';

            $.ajax({
                url: "controller?cmd=buyListAction",
                type: "POST",
                data: {
                    type: "buying"
                },
                success: function(response) {
                    $("#buyList").html(response);
                    cardClick();
                    buyCompleteClick();
                }
            });
        });

        sellComplete.addEventListener('click', function(){
            sellComplete.style.backgroundColor = '#E07F39';
            sellComplete.style.borderColor = '#E07F39';

            selling.style.backgroundColor = '#FFB966';
            selling.style.borderColor = '#FFB966';        

            $.ajax({
                url: "controller?cmd=buyListAction",
                type: "POST",
                data: {
                    type: "buyComplete"
                },
                success: function(response) {
                    $("#buyList").html(response);
                    cardClick();
                    buyCompleteClick();
                }
            });
        });
        
    $(document).ready(function() {
      cardClick();
      buyCompleteClick();
    });
    
    cardClick = function(){
      $(".product_card").on('click', function() {
        location.href = "controller?cmd=productInfoUI&productSeq="+ this.dataset.productseq;
      });
    };

    buyCompleteClick = function(){
        $(".buyComplete").on('click', function(){
            productSeq = this.dataset.productseq;
        });       
    };
    
    });

  </script>

</body>
</html>






