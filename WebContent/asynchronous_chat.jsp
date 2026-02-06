<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="vo.ChatVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${userId eq null}">
	<c:redirect url = "controller?cmd=loginUI"/>
</c:if>
<% String userId = (String)session.getAttribute("userId"); %>
<% ArrayList<ChatVO> chat = (ArrayList<ChatVO>)request.getAttribute("chat"); %>

      <% if(chat != null){ %>
      <% DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm"); %>
      <% DateTimeFormatter formatterDay = DateTimeFormatter.ofPattern("yyyy-MM-dd"); %>
      <% for(int i=0; i<chat.size(); i++){ %>
      
        <% if(i==0){ %>
        <div style="text-align: center;">[<%= chat.get(i).getChatDate().format(formatterDay) %>]</div>
      	<% } else {%>
	      	<% if(!chat.get(i-1).getChatDate().format(formatterDay).equals(chat.get(i).getChatDate().format(formatterDay))){ %>
	        <div style="text-align: center;">[<%= chat.get(i).getChatDate().format(formatterDay) %>]</div>
	        <% } %>
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
      	<div class="chatbox me"><%= chat.get(i).getContent() %></div>
		</div>
      	<% } else if(userId.equals(chat.get(i).getToId())){%>
      	<div class="d-flex chatLineYOU">
      	<div class="chatbox you"><%= chat.get(i).getContent() %></div>
      	<div class="chatDateYOU"><%= chat.get(i).getChatDate().format(formatter) %></div>
      	</div>
      	<% } %>
      <% } %>
      <% } %>
      <input type="hidden" id="chatSize" value="<%= chat != null ? chat.size() : 0 %>">