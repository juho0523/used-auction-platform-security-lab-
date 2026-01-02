<%@page import="dto.ProductBoxDTO"%>
<%@page import="vo.ChatVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String userId = (String)session.getAttribute("userId"); %>
<% if(userId == null) response.sendRedirect("controller?cmd=loginUI"); %>
<% ArrayList<ChatVO> chat = (ArrayList<ChatVO>)request.getAttribute("chat"); %>
<% ProductBoxDTO product = (ProductBoxDTO)request.getAttribute("product"); %>
<% String toNickName = (String)request.getAttribute("toNickName"); %>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="css/common.css">
  <link rel="stylesheet" href="css/chat.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    
<style type="text/css">
#sendBtn {
  border: 0px;
}

#sendBtn > img {
  width: 30px;
  height: 30px;
}
#top {
  margin-top: 10px;
}
</style>
</head>

<body>
  <div id="project_container">

    <div id="top">
      <img src="images/icon/arrow.png" id="previous" onclick="history.back()">
      <h6 id="top-head"><%= toNickName %>님과의 채팅</h6>
      <div></div>
    </div>
    <br>
    <div class="container">
	
	<% if(product != null){ %>
    <li class="list-group-item border-0 p-0">
      <div class="d-flex">
        <img src="images/product/product1/product1-img1.jpg" class="img-fluid">
        <div class="ms-1">
          <div class="card-text d-flex">
            <h6><%= product.getTitle() %></h6>
            <% if(product.getState().equals("S")){ %>
            <span class="badge badge-s">판매중</span>
            <% } else if(product.getState().equals("T")){ %>
            <span class="badge badge-s">거래중</span>
            <% } else if(product.getState().equals("E")){ %>
            <span class="badge badge-e">거래완료</span>
            <% } %>
          </div>
          <p class="product-info"><%= product.getCategory() %></p>
          <p class="product-info"><%= product.getAddress() %></p>
          <div class="text-group">
            <p class="product-info"><%= product.getEndDate() %></p>
            <p class="product-info">입찰 <%= product.getBidCount() %>건</p>
          </div>
        </div>
      </div>
    </li>
    <% } %>
    <hr class="my-1">

    <ul class="list-group w-100" id="chatList">
    
      <% if(chat != null){ %>
      <% for(int i=0; i<chat.size(); i++){ %>
		<% if(userId.equals(chat.get(i).getFromId())){ %>
      	<div class="chatbox me"><%= chat.get(i).getContent() %></div>
      	<% } else if(userId.equals(chat.get(i).getToId())){%>
      	<div class="chatbox you"><%= chat.get(i).getContent() %></div>
      	<% } %>
      <% } %>
      <% } %>
      
    </ul>

    </div>

    <div class="chat-input">
      <input id="chatContent" placeholder="채팅하기">
      <button id="sendBtn">
      	<img src="images/icon/send.png">
      </button>
    </div>

  </div>

<script>

var productSeq = "${param.productSeq}";
var fromId = "${sessionScope.userId}";
var toId = "${param.toId}";

var sendBtn = document.querySelector('#sendBtn');
sendBtn.addEventListener('click', function() {
	var chatContent = document.querySelector('#chatContent').value;
	//alert(chatContent);
    $.ajax({
        type: "POST",
        url: "controller?cmd=addChatAction",
        data: { 
        	productSeq: productSeq,
        	fromId: fromId,
        	toId: toId,
        	chatContent: chatContent 
       	},
        success: function(response) {
            alert("채팅 메시지가 전송에 성공했습니다.");
            document.querySelector('#chatContent').value = "";
            //location.reload();
        },
        error: function(xhr, status, error) {
            alert("채팅 메시지 전송에 실패했습니다.");
            document.querySelector('#chatContent').value = "";
        }
    });
});

window.onload = function() {
	  var chatList = document.getElementById('chatList');
	  chatList.scrollTop = chatList.scrollHeight;
}

var previous = document.querySelector('#previous');
previous.addEventListener('click', function() {
	location.href = "controller?cmd=chatListUI";
})



function getChat(){
	$.ajax({
		type: "POST",
		url: "controller?cmd=getChatAction",
		data: {
        	productSeq: productSeq,
        	fromId: fromId,
        	toId: toId
		},
		success: function(result){
			$("#chatList").html(result);
		    var chatList = document.getElementById('chatList');
		    chatList.scrollTop = chatList.scrollHeight;
		}
	});		
}

function getInfiniteChat(){
	setInterval(function(){
		getChat();
	},3000);		
}

$(document).ready(function(){
	getChat();
	getInfiniteChat();
});

</script>

</body>
</html>




