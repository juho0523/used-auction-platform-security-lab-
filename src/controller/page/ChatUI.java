package controller.page;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import controller.Action;
import controller.URLModel;
import service.ChatService;
import service.ProductService;
import service.UserService;

public class ChatUI implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int productSeq = Integer.parseInt(request.getParameter("productSeq"));
		String userId = (String)request.getSession().getAttribute("userId");
		String toId = (String)request.getParameter("toId");
		
		//System.out.println(productSeq);
		//System.out.println(userId);
		//System.out.println(toId);
		
		ChatService chatService = new ChatService();
		request.setAttribute("chat", chatService.getChat(productSeq, userId, toId));
		chatService.readChat(productSeq, userId, toId);
		
		ProductService productService = new ProductService();
		request.setAttribute("product", productService.getProduct(productSeq));
		
		UserService userService = new UserService();
		request.setAttribute("toNickName", userService.getUsers(toId).getNickName());
		
		return new URLModel("chat.jsp", false);
	}

}
