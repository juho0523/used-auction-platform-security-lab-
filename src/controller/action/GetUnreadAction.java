package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import controller.Action;
import controller.URLModel;
import service.ChatService;

public class GetUnreadAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		
		String userId = (String)request.getSession().getAttribute("userId");
		//System.out.println(userId);
		
		ChatService chatService = new ChatService();
		int count = chatService.getUnreadChat(userId);
		request.setAttribute("count", count);
		
		return new URLModel("asynchronous_unread.jsp",false);
	}

}
