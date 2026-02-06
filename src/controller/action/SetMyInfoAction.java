package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import config.SHA256;
import controller.Action;
import controller.URLModel;
import service.JoinService;
import service.SetMyInfoService;
import service.UserService;
import vo.UserVO;

public class SetMyInfoAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String page = "controller?cmd=setMyInfoUI";
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("userId");
		

		
		 
		
		
		
		String pw = request.getParameter("password");
		String nickname = request.getParameter("nickname");
		String phoneNumber = request.getParameter("phoneNumber");
		String email = request.getParameter("email");
		String address = request.getParameter("cityAddress")+" "+request.getParameter("districtAddress");
		
		System.out.println(pw);
		pw = SHA256.encrypt(pw);
		System.out.println(pw);
		
		
		
		
		if(new SetMyInfoService().setUser(id, pw, nickname, phoneNumber, email, address)){

			session.setAttribute("userId", id);
			session.setAttribute("nickname", nickname);
			session.setAttribute("address", request.getParameter("districtAddress"));
			page = "controller?cmd=mainUI";
		}		
		
		//false냐 true냐
		return new URLModel(page, true);
	}

}
