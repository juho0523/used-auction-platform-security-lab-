<%@page import="dto.ProductBoxDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String userId = (String)session.getAttribute("userId"); %>
<% if(userId == null) response.sendRedirect("controller?cmd=loginUI"); %>
<% ArrayList<ProductBoxDTO> sellList = (ArrayList<ProductBoxDTO>)request.getAttribute("sellList"); %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/sellList.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<style>
#top {
	justify-content: center;
	margin-top: 10px;
}
.button > #selling,
.button > #sellComplete {
  background-color: #FFB966;
  border-color: #FFB966;
}
.truncate {
    width: 140px;
    white-space: nowrap; 
    overflow: hidden;
    text-overflow: ellipsis;
    margin: 0px;
}
#scroll {
	overflow-y: scroll;
	scrollbar-width: none;
}

.button {
	float: right !important;
	margin-left: auto;
	margin-right: 10px;
}
</style>
<body>

	<div id="project_container">
		<div id="top">
			<h6 id="top-head">판매내역</h6>
			<div></div>
		</div>

		<div class="button">
			<button id="selling" class="btn btn-primary rounded-pill">판매중</button>
			<button id="sellComplete" class="btn btn-primary rounded-pill">거래완료</button>
		</div>

		<div class="container" id="scroll">

			<ul class="list-group w-100">
				<hr class="my-1">
				<li class="list-group-item border-0 p-0">
					<% if(sellList != null){ %>
					<% for(int i=0; i<sellList.size(); i++){ %>
					<div class="d-flex product_card" data-productSeq="<%= sellList.get(i).getProductSeq() %>">
						<img src="images/product/product1/product1-img1.jpg" class="img-fluid">
						<div class="ms-1">
							<div class="card-text d-flex">
								<div id="item-title-group">
									<div class="d-flex product_title">
										<h6 class="truncate"><%= sellList.get(i).getTitle() %></h6>
										<% if(sellList.get(i).getState().equals("S")){ %>
										<span class="badge badge-s">판매중</span>
										<% } else if(sellList.get(i).getState().equals("T")) {  %>
										<span class="badge bg-info">거래중</span>
										<% } %>
									</div>
									<p><%= sellList.get(i).getCategory() %></p>
									<p><%= sellList.get(i).getAddress() %> | 종료일 <%= sellList.get(i).getEndDate() %></p>
									<span class="badge badge-s">입찰가</span> 
									<span><%= sellList.get(i).getBidMax() %>P</span> 
									<span class="badge badge-s">즉구가</span> 
									<span><%= sellList.get(i).getPrice() %>P</span> 
									<span>입찰 <%= sellList.get(i).getBidCount() %>건</span>
								</div>
							</div>
						</div>
					</div>						
					<hr class="my-1">
					<% } %>
					<% } %>
				</li>
			</ul>
		</div>
		<jsp:include page="/navbar_sell.jsp"></jsp:include>
	</div>

    <script>
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
                    url: "controller?cmd=sellListAction",
                    type: "POST",
                    data: {
                        type: "selling"
                    },
                    success: function(response) {
                        $("#scroll").html(response);
                        cardClick();
                    }
                });
            });

            sellComplete.addEventListener('click', function(){
                sellComplete.style.backgroundColor = '#E07F39';
                sellComplete.style.borderColor = '#E07F39';

                selling.style.backgroundColor = '#FFB966';
                selling.style.borderColor = '#FFB966';        

                $.ajax({
                    url: "controller?cmd=sellListAction",
                    type: "POST",
                    data: {
                        type: "sellComplete"
                    },
                    success: function(response) {
                        $("#scroll").html(response);
                        cardClick();
                    }
                });
            });
            
    		$(document).ready(function() {
    			cardClick();
    		});
    		
    		cardClick = function(){
    			$(".product_card").on('click', function() {
    				location.href = "controller?cmd=productInfoUI&productSeq="+ this.dataset.productseq;
    			})
    		}
        });
        
    </script>
</body>
</html>

