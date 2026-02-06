<%@page import="dto.ChatBoxDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String userId = (String)session.getAttribute("userId"); %>
<% if(userId == null) response.sendRedirect("controller?cmd=loginUI"); %>
<% ArrayList<ChatBoxDTO> chatList = (ArrayList<ChatBoxDTO>)request.getAttribute("chatList"); %>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>호박마켓 : 채팅리스트</title>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/chatList.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<style>
.chatP {
	width: 240px;
	height: 18px;
	white-space: wrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

a {
	text-decoration: none;
	color: #000000;
	margin-right: 5px;
}
#top {
	padding-top: 10px;
	padding-left: 5px;
}
#unreadCount {
	color: white;
	background-color: red;
	font-size: 14px;
	padding: 0px 4px;	
	text-align: center;
	vertical-align: middle;
	border-radius: 4px;
}
#scroll {
	overflow-y: scroll;
	scrollbar-width: none;
	height: 468px;
}
</style>

<body>

	<div id="project_container">

		<div id="top">
			<div></div>
			<h6 id="top-head">채팅</h6>
			<div></div>
		</div>

		<div class="container">
			<ul class="list-group w-100" id="scroll">
				<c:if test="${empty chatList}">
					<div class="card d-flex align-items-center border-0 mt-5 pt-5">
		 				<img src="./images/product/uploaded/logo.png" class="logo">
		  				<div class="card-body">
		    				<p class="card-text">채팅이 없습니다.</</p>
		  				</div>
					</div>
				</c:if>
			
				<% if(chatList != null){ %>			
					<% for(int i=0; i<chatList.size(); i++){ %>
					<% String toId = (chatList.get(i).getFromId().equals(userId)) ? chatList.get(i).getToId() : chatList.get(i).getFromId(); %>
					<% String toNickName = (chatList.get(i).getFromId().equals(userId)) ? chatList.get(i).getToNickName() : chatList.get(i).getFromNickName(); %>
					<hr class="my-1 mt-2 mb-2">
					<li class="list-group-item border-0 p-0 product_card" data-productSeq="<%= chatList.get(i).getProductSeq() %>"
					data-toId="<%= toId %>">
							<div class="d-flex">
							<div>
								<img src="uploaded/<%= chatList.get(i).getImgURL() %>" class="thumbnail">
							</div>
								<div class="ms-1">
									<div class="card-text d-flex">
										<div id="item-title-group">
											<div class="d-flex">
												<% if(userId.equals(chatList.get(i).getProductUserId())){ %>
												<span class="badge badge-s">판매품</span>
												<% } else { %>
												<span class="badge badge-t">구매품</span>
												<% } %>
												<p><%= toNickName %></p>
												<% if(chatList.get(i).getUnreadChatCount() != 0){ %>
												<div id="unreadCount"><%= chatList.get(i).getUnreadChatCount() %></div>
												<% } %>
											</div>
											<p class="chatP"><%= chatList.get(i).getContent() %></p>
										</div>
									</div>
								</div>
							</div>
					</li>

					<% } %>
				<% } %>
			</ul>
		</div>
		<jsp:include page="/navbar_chat.jsp"></jsp:include>
	</div>
<script>

	document.addEventListener('DOMContentLoaded', function() {
		$(document).ready(function() {
			cardClick();
		});
		
		cardClick = function(){
			$(".product_card").on('click', function() {
				location.href = "controller?cmd=chatUI&productSeq="+ this.dataset.productseq + "&toId="+ this.dataset.toid;
			})
		};
	});

</script>

<script>	
	function getChatList(){
		$.ajax({
			type: "POST",
			url: "controller?cmd=getChatListAction",
			data: {
				userId: "<%= userId %>"
			},
			success: function(result){
				$("#scroll").html(result);
				cardClick();
			}
		});		
	}
	
	function getInfiniteChatList(){
		setInterval(function(){
			getChatList();
		},3000);		
	}
	
	$(document).ready(function(){
		getChatList();
		getInfiniteChatList();
	});
</script>

</body>
</html>




