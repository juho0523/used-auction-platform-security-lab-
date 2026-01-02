package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import controller.Action;
import controller.URLModel;
import service.JoinService;

public class JoinAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		
		String page = "join.jsp";
		String id = request.getParameter("userId");
		String pw = request.getParameter("userPw");
		String name = request.getParameter("name");
		String nickname = request.getParameter("nickname");
		String phoneNumber = request.getParameter("phoneNumber");
		String email = request.getParameter("email");
		String address = request.getParameter("cityAddress")+" "+request.getParameter("districtAddress");
		
		

		
		if(new JoinService().addUser(id, pw, name, nickname, phoneNumber, email, address)){
			page = "login.jsp";
		}
		
		return new URLModel(page, true);
	}

}
