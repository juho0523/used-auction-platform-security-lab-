<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="dto.ProductBoxDTO"%>
<%@page import="vo.ChatVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
String userId = (String)session.getAttribute("userId");
if(userId == null) response.sendRedirect("controller?cmd=loginUI");

ArrayList<ChatVO> chat = (ArrayList<ChatVO>)request.getAttribute("chat");
ProductBoxDTO product = (ProductBoxDTO)request.getAttribute("product");
String toNickName = (String)request.getAttribute("toNickName");

if(userId.equals(request.getParameter("toId")))
    response.sendRedirect("controller?cmd=chatListUI");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>채팅</title>

<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/chat.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<style>
#sendBtn { border: 0px; }
#sendBtn > img { width: 30px; height: 30px; }
#top { margin-top: 10px; }
.chatDateYOU, .chatDateME { font-size: 10px; align-self: flex-end; }
.chatLineYOU { align-self: flex-start; }
.chatLineME { align-self: flex-end; }
.isRead { color: #FF922E; font-size: 12px; float: right; }
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
    <img src="images/icon/arrow.png" id="previous" onclick="history.back()">
    <h6 id="top-head"><c:out value="<%= toNickName %>" />님과의 채팅</h6>
    <div></div>
</div>

<div class="container">

<% if(product != null){ %>
<hr class="my-1">
<li class="list-group-item border-0 p-0">
<div class="d-flex product_card" data-productSeq="<%= product.getProductSeq() %>">
    <img src="uploaded/<%= product.getImgURL() %>" class="img-fluid">
    <div class="ms-1">
        <div class="card-text d-flex">
            <h6 class="truncate">
                <c:out value="<%= product.getTitle() %>" />
            </h6>

            <% if(product.getState().equals("S")){ %>
                <span class="badge badge-s">판매중</span>
            <% } else if(product.getState().equals("T")){ %>
                <span class="badge badge-s">거래중</span>
            <% } else if(product.getState().equals("E")){ %>
                <span class="badge badge-e">거래완료</span>
            <% } %>
        </div>

        <p class="product-info">
            <c:out value="<%= product.getCategory() %>" />
        </p>
        <p class="product-info">
            <c:out value="<%= product.getAddress() %>" />
        </p>

        <div class="text-group">
            <p class="product-info" id="end_date"><%= product.getEndDate() %></p>
            <p class="product-info" id="bid_count">입찰 <%= product.getBidCount() %>건</p>
        </div>
    </div>
</div>
</li>
<hr class="my-1">
<% } %>

<ul class="list-group w-100" id="chatList">

<% if(chat != null){ %>
<% DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm"); %>
<% DateTimeFormatter formatterDay = DateTimeFormatter.ofPattern("yyyy-MM-dd"); %>

<% for(int i=0; i<chat.size(); i++){ %>

    <% if(i==0){ %>
    <div style="text-align:center;">
        [<%= chat.get(i).getChatDate().format(formatterDay) %>]
    </div>
    <% } else if(!chat.get(i-1).getChatDate().format(formatterDay)
            .equals(chat.get(i).getChatDate().format(formatterDay))){ %>
    <div style="text-align:center;">
        [<%= chat.get(i).getChatDate().format(formatterDay) %>]
    </div>
    <% } %>

    <% if(userId.equals(chat.get(i).getFromId())){ %>
    <div class="d-flex chatLineME">
        <% if(chat.get(i).getChatState().equals("F")){ %>
        <div class="d-block" id="isReadchatDate">
            <div class="isRead">1</div>
            <div class="chatDateME"><%= chat.get(i).getChatDate().format(formatter) %></div>
        </div>
        <% } else { %>
        <div class="chatDateME"><%= chat.get(i).getChatDate().format(formatter) %></div>
        <% } %>

        <div class="chatbox me">
            <c:out value="<%= chat.get(i).getContent() %>" />
        </div>
    </div>

    <% } else if(userId.equals(chat.get(i).getToId())){ %>
    <div class="d-flex chatLineYOU">
        <div class="chatbox you">
            <c:out value="<%= chat.get(i).getContent() %>" />
        </div>
        <div class="chatDateYOU"><%= chat.get(i).getChatDate().format(formatter) %></div>
    </div>
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

$("#sendBtn").on("click", function(){
    var chatContent = $("#chatContent").val();
    if(chatContent === ''){
        alert("메세지를 입력해주세요.");
        return;
    }

    $.post("controller?cmd=addChatAction", {
        productSeq: productSeq,
        fromId: fromId,
        toId: toId,
        chatContent: chatContent
    }, function(){
        $("#chatContent").val("");
    });
});

function getChat(){
    $.post("controller?cmd=getChatAction", {
        productSeq: productSeq,
        fromId: fromId,
        toId: toId
    }, function(result){
        $("#chatList").html(result);
    });
}

setInterval(getChat, 3000);

$(document).ready(function(){
    getChat();
});
</script>

</body>
</html>
