<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:forEach items='${list}' var='p'>
	<div class="card d-flex align-items-center border-0 p-2"
		data-productSeq="${p.getProductSeq()}">
		<div class="row align-content-center w-100">
			<div
				class="d-flex align-items-center justify-content-center h-100 ps-0 pe-0">
				<img src="images/product/product1/product1-img1.jpg"
					class="img-fluid" />
				<div class="ms-2 w-100">
					<div
						class="card-text d-flex align-items-start justify-content-between">
						<h6>${p.getTitle()}</h6>
						<div class="d-flex justify-content-end ms-1">
							<span class="badge badge-s">경매중</span>
						</div>
					</div>
					<div class="d-flex text-group pt-1">
						<p class="product-info">${p.getCategory()}</p>
						<p class="product-info ms-2 me-2">|</p>
						<p class="product-info">${p.getAddress()}</p>
					</div>
					<div class="text-group-point pt-1 pb-1">
						<p class="bpr m-0 text-danger" id="bidMax">
						<c:choose>
							<c:when test = "${p.getBidMax() == 0}">
								${p.getStartPrice()}
							</c:when>
							<c:otherwise>
								${p.getBidMax()}
							</c:otherwise>
						</c:choose>
						</p>
						<p class="pr m-0" id="nowprice">${p.getPrice()}</p>
					</div>
					<div class="d-flex justify-content-between text-group">
						<p class="product-info endDate">${p.getEndDate()}</p>
						<p class="product-info me-2">입찰 ${p.getBidCount()}건</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<hr class="m-0">
</c:forEach>