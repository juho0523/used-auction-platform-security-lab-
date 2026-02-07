<%@page import="dto.ChatBoxDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:if test="${userId eq null}">
	<c:redirect url="controller?cmd=loginUI"/>
</c:if>

<%
String userId = (String)session.getAttribute("userId");
ArrayList<ChatBoxDTO> chatList = (ArrayList<ChatBoxDTO>)request.getAttribute("chatList");
%>

<c:if test="${empty chatList}">
	<div class="card d-flex align-items-center border-0 mt-5 pt-5">
		<img src="./images/product/uploaded/logo.png" class="logo">
		<div class="card-body">
			<p class="card-text">채팅이 없습니다.</p>
		</div>
	</div>
</c:if>

<% if(chatList != null){ %>
	<% for(int i=0; i<chatList.size(); i++){ %>

	<%
	String toId = (chatList.get(i).getFromId().equals(userId))
			? chatList.get(i).getToId()
			: chatList.get(i).getFromId();

	String toNickName = (chatList.get(i).getFromId().equals(userId))
			? chatList.get(i).getToNickName()
			: chatList.get(i).getFromNickName();
	%>

	<hr class="my-1 mt-2 mb-2">
	<li class="list-group-item border-0 p-0 product_card"
		data-productSeq="<%= chatList.get(i).getProductSeq() %>"
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

							<p>
								<c:out value="<%= toNickName %>" />
							</p>

							<% if(chatList.get(i).getUnreadChatCount() != 0){ %>
								<div id="unreadCount">
									<%= chatList.get(i).getUnreadChatCount() %>
								</div>
							<% } %>
						</div>

						<p class="chatP">
							<c:out value="<%= chatList.get(i).getContent() %>" />
						</p>
					</div>
				</div>
			</div>
		</div>

	</li>
	<% } %>
<% } %>
