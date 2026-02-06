<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="dto.ProductBoxDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${userId eq null}">
	<c:redirect url="controller?cmd=loginUI" />
</c:if>
<% ArrayList<ProductBoxDTO> sellList = (ArrayList<ProductBoxDTO>)request.getAttribute("sellList"); %>
<% String type = (String)request.getAttribute("type"); %>
<% DateTimeFormatter formmatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"); %>
<hr class="my-1">

<c:if test="${empty sellList}">
	<div class="card d-flex align-items-center border-0 mt-5 pt-5">
		<img src="./images/product/uploaded/logo.png" class="logo">
		<div class="card-body">
			<p class="card-text">판매 내역이 없습니다.</</p>
		</div>
	</div>
</c:if>

<% if(sellList != null){ %>
<% if(type.equals("selling")){ %>

<% for(int i=0; i<sellList.size(); i++){ %>
<div class="d-flex product_card"
	data-productSeq="<%= sellList.get(i).getProductSeq() %>">
	<img src="uploaded/<%= sellList.get(i).getImgURL() %>" alt="상품이미지"
		onerror="this.onerror=null; this.src='images/product/uploaded/logo.png'"
		class="img-fluid">
	<div class="ms-1">
		<div class="card-text d-flex">
			<div id="item-title-group">
				<div class="d-flex product_title">
					<h6 class="truncate"><%= sellList.get(i).getTitle() %></h6>
					<% if(sellList.get(i).getState().equals("S")){ %>
					<span class="badge badge-s">판매중</span>
					<% } else if(sellList.get(i).getState().equals("T")) {  %>
					<span class="badge badge-t">거래중</span>
					<% } %>
				</div>
				<p><%= sellList.get(i).getCategory() %></p>
				<p><%= sellList.get(i).getAddress() %>
					| 종료일
					<%= sellList.get(i).getEndDate().format(formmatter) %></p>
				<span class="badge badge-s">입찰가</span>
				<% if(sellList.get(i).getBidMax() == 0){ %>
				<span><%= sellList.get(i).getStartPrice() %>P</span>
				<% } else {%>
				<span><%= sellList.get(i).getBidMax() %>P</span>
				<% } %>
				<span class="badge badge-s">즉구가</span> <span><%= sellList.get(i).getPrice() %>P</span>
				<span>입찰 <%= sellList.get(i).getBidCount() %>건
				</span>
			</div>
		</div>
	</div>
</div>
<hr class="my-1">
<% } %>

<% } else if(type.equals("sellComplete")){ %>

<% for(int i=0; i<sellList.size(); i++){ %>
<div class="d-flex product_card"
	data-productSeq="<%= sellList.get(i).getProductSeq() %>">
	<img src="uploaded/<%= sellList.get(i).getImgURL() %>"
		class="img-fluid">
	<div class="ms-1">
		<div class="card-text d-flex">
			<div id="item-title-group">
				<div class="d-flex product_title">
					<h6 class="truncate"><%= sellList.get(i).getTitle() %></h6>
					<% if(sellList.get(i).getBidCount() == 0){ %>
					<span class="badge badge-e">유찰</span>
					<% } else { %>
					<span class="badge badge-e">거래완료</span>
					<% } %>
				</div>
				<p><%= sellList.get(i).getCategory() %></p>
				<p><%= sellList.get(i).getAddress() %>
					| 종료일
					<%= sellList.get(i).getEndDate().format(formmatter) %></p>
				<span class="badge badge-e">판매가</span>
				<% if(sellList.get(i).getBidMax() == 0){ %>
				<span><%= sellList.get(i).getStartPrice() %>P</span>
				<% } else {%>
				<span><%= sellList.get(i).getBidMax() %>P</span>
				<% } %>
				<span>입찰 <%= sellList.get(i).getBidCount() %>건
				</span>
			</div>
		</div>
	</div>
</div>
<hr class="my-1">
<% } %>

<% } %>

<% } %>

