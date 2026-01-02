package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import controller.Action;
import controller.URLModel;
import service.JoinService;
import service.SetMyInfoService;
import vo.UserVO;

public class SetMyInfoAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String page = "setMyInfo.jsp";
		
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("userId");
		
		
		String pw = request.getParameter("password");
		String nickname = request.getParameter("nickname");
		String phoneNumber = request.getParameter("phoneNumber");
		String email = request.getParameter("email");
		String address = request.getParameter("cityAddress")+" "+request.getParameter("districtAddress");
		
		
		

		
		if(new SetMyInfoService().setUser(id, pw, nickname, phoneNumber, email, address)){
			page = "login.jsp";
		}		
		
		
		return new URLModel(page, true);
	}

}
