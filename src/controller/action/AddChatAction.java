package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import controller.Action;
import controller.URLModel;
import service.ChatService;

public class AddChatAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		
		int productSeq = Integer.parseInt(request.getParameter("productSeq"));
		String fromId = request.getParameter("fromId");
		String toId = request.getParameter("toId");
		String chatContent = request.getParameter("chatContent");
		
		ChatService chatService = new ChatService();
		chatService.addChat(productSeq, fromId, toId, chatContent);
		
		return new URLModel("chat.jsp",true);
	}

}
