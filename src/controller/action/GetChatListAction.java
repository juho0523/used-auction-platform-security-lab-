package controller.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import controller.Action;
import controller.URLModel;
import dto.ChatBoxDTO;
import service.ChatListService;

public class GetChatListAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {

		String userId = (String)request.getSession().getAttribute("userId");
		//System.out.println(userId);
		
		ArrayList<ChatBoxDTO> chatList = new ChatListService().getChatList(userId);
		request.setAttribute("chatList", chatList);
		
		return new URLModel("asynchronous_chatList.jsp",false);
	}

}
