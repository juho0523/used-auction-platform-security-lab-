package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import controller.Action;
import controller.URLModel;
import service.DuplicationService;
import service.UserService;
import vo.UserVO;

public class SessionNickCheckAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("userId");
		
		UserVO vo = new UserService().getUsers(id);
		String nickname = vo.getNickName();
		
		
		String nick = request.getParameter("nick");
		
		
		String result = null;
		boolean check = false;
		
		
		check = new DuplicationService().nickCheck(nick);
		
		if(nick == nickname){
			check = false;
		}
		
		if(check){
			result = "다른 유저가 사용중인 닉네임입니다.";
		} else {
			result = "사용할 수 있는 닉네임입니다.";
		}
		request.setAttribute("nickCheckFeedBackResult", result);
		
		System.out.println("결과값 : " + result);
		
		return new URLModel("nickCheck.jsp", false);
	}

}
