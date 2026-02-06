package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import config.SHA256;
import controller.Action;
import controller.URLModel;
import service.JoinService;

public class JoinAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String page = "controller?cmd=joinUI";
		String id = request.getParameter("userId");
		String pw = request.getParameter("userPw");
		String name = request.getParameter("name");
		String nickname = request.getParameter("nickname");
		String phoneNumber = request.getParameter("phoneNumber");
		String email = request.getParameter("email");
		String address = request.getParameter("cityAddress")+" "+request.getParameter("districtAddress");
		
		//System.out.println(pw);
		pw = SHA256.encrypt(pw);
		//System.out.println(pw);
		
		if(new JoinService().addUser(id, pw, name, nickname, phoneNumber, email, address)){
			page = "controller?cmd=loginUI";
		}
		
		return new URLModel(page, true);
	}

}
