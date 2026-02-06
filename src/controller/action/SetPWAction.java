package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import config.SHA256;
import controller.Action;
import controller.URLModel;
import service.JoinService;
import service.SetPWService;

public class SetPWAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//String page = "controller?cmd=setPWUI";
		HttpSession session = request.getSession();
		String messageContent = "";
		
		String id = request.getParameter("id");
		String pw = request.getParameter("password");
		String checkPw = request.getParameter("checkPassword");
		
		if(pw == "" || checkPw == ""){
			messageContent = "정보를 입력해주세요.";
			session.setAttribute("messageContent", messageContent);
			return new URLModel("controller?cmd=setPWUI", true);
		}
		
		if(!pw.equals(checkPw)){
			messageContent = "비밀번호가 일치하지 않습니다.";
			session.setAttribute("messageContent", messageContent);
			return new URLModel("controller?cmd=setPWUI", true);
		} else {
			//System.out.println(pw);
			pw = SHA256.encrypt(pw);
			//System.out.println(pw);
			
			if(new SetPWService().setPw(id, pw)){
				messageContent = "비밀번호 변경 완료";
				session.setAttribute("messageContent", messageContent);
				return new URLModel("controller?cmd=loginUI", true);				
			} else {
				messageContent = "비밀번호 변경 실패";
				session.setAttribute("messageContent", messageContent);
				return new URLModel("controller?cmd=setPWUI", true);				
			}
		}

	
	}
}
