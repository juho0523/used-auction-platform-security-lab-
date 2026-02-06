package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import controller.Action;
import controller.URLModel;
import service.FindPWService;

public class FindPWAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String messageContent = "";
		
		String id = request.getParameter("userId");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		if(id == "" || name == "" || email == ""){
			messageContent = "정보를 입력해주세요.";
			session.setAttribute("messageContent", messageContent);
			return new URLModel("controller?cmd=findPWUI", true);
		}
		
		if(new FindPWService().findPW(id, name, email)){
			messageContent = "새 비밀번호를 입력해주세요.";
			session.setAttribute("messageContent", messageContent);
			session.setAttribute("id", id);
			return new URLModel("controller?cmd=setPWUI", true);
		}
		
		messageContent = "정보가 일치하지 않습니다.";
		session.setAttribute("messageContent", messageContent);
		return new URLModel("controller?cmd=findPWUI", true);
	}

}
