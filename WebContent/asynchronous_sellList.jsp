<%@page import="dto.ProductBoxDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% ArrayList<ProductBoxDTO> sellList = (ArrayList<ProductBoxDTO>)request.getAttribute("sellList"); %>
<% String type = (String)request.getAttribute("type"); %>

<% if(sellList != null){ %>

<% if(type.equals("selling")){ %>

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
				<p><%= sellList.get(i).getAddress() %>
					| 종료일
					<%= sellList.get(i).getEndDate() %></p>
				<span class="badge badge-s">입찰가</span> <span><%= sellList.get(i).getBidMax() %>P</span>
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
<div class="d-flex product_card" data-productSeq="<%= sellList.get(i).getProductSeq() %>">
	<img src="images/product/product2/product2-img1.jpg" class="img-fluid">
	<div class="ms-1">
		<div class="card-text d-flex">
			<div id="item-title-group">
				<div class="d-flex product_title">
					<h6 class="truncate"><%= sellList.get(i).getTitle() %></h6>
					<span class="badge badge-e">거래완료</span>				
				</div>
				<p><%= sellList.get(i).getCategory() %></p>
				<p><%= sellList.get(i).getAddress() %>
					| 종료일
					<%= sellList.get(i).getEndDate() %></p>
				<span class="badge badge-e">판매가</span> <span><%= sellList.get(i).getPrice() %>P</span>
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

