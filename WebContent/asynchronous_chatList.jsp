<%@page import="dto.ChatBoxDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String userId = (String)session.getAttribute("userId"); %>
<% ArrayList<ChatBoxDTO> chatList = (ArrayList<ChatBoxDTO>)request.getAttribute("chatList"); %>
<% if(chatList != null){ %>
	<% for(int i=0; i<chatList.size(); i++){ %>
	<% String toId = (chatList.get(i).getFromId().equals(userId)) ? chatList.get(i).getToId() : chatList.get(i).getFromId(); %>
	<% String toNickName = (chatList.get(i).getFromId().equals(userId)) ? chatList.get(i).getToNickName() : chatList.get(i).getFromNickName(); %>
	<li class="list-group-item border-0 p-0 product_card" data-productSeq="<%= chatList.get(i).getProductSeq() %>"
	data-toId="<%= toId %>">
			<div class="d-flex">
				<img src="images/product/product1/product1-img1.jpg" class="img-fluid">
				<div class="ms-1">
					<div class="card-text d-flex">
						<div id="item-title-group">
							<div class="d-flex">
								<% if(userId.equals(chatList.get(i).getProductUserId())){ %>
								<span class="badge badge-s">판매품</span>
								<% } else { %>
								<span class="badge bg-info">구매품</span>
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
	<hr class="my-1">
	<% } %>
<% } %>