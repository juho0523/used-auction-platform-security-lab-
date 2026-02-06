<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="dto.ProductBoxDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${userId eq null}">
  <c:redirect url = "controller?cmd=loginUI"/>
</c:if>
<% ArrayList<ProductBoxDTO> buyList = (ArrayList<ProductBoxDTO>)request.getAttribute("buyList"); %>
<% String type = (String)request.getAttribute("type"); %>
<% DateTimeFormatter formmatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"); %>
<hr class="my-1">
<c:if test="${empty buyList}">
	<div class="card d-flex align-items-center border-0 mt-5 pt-5">
		<img src="./images/product/uploaded/logo.png" class="logo">
		<div class="card-body">
			<p class="card-text">구매 내역이 없습니다.</</p>
		</div>
	</div>
</c:if>
<% if(buyList != null){ %>
<% if(type.equals("buying")){ %>

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
				        <p><%= buyList.get(i).getAddress() %>
				          | 종료일
				          <%= buyList.get(i).getEndDate().format(formmatter) %></p>
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

<% } else if(type.equals("buyComplete")){%>

        <% for(int i=0; i<buyList.size(); i++){ %>
        <li class="list-group-item border-0 p-0">
          <div class="d-flex product_card" data-productSeq="<%= buyList.get(i).getProductSeq() %>">
            <img src="uploaded/<%= buyList.get(i).getImgURL() %>" 
            alt="상품이미지" onerror="this.onerror=null; this.src='images/product/uploaded/logo.png'"
            class="img-fluid">
            <div class="ms-1">
              <div class="card-text d-flex">
                <div id="item-title-group">
                  <h6 class="truncate"><%= buyList.get(i).getTitle() %></h6>
                  <p><%= buyList.get(i).getCategory() %></p>
                  <p><%= buyList.get(i).getAddress() %> | 종료일 <%= buyList.get(i).getEndDate().format(formmatter) %></p>
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

<% } %>