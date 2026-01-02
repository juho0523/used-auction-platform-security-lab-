package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import controller.Action;
import controller.URLModel;
import service.JoinService;
import service.SetPWService;

public class SetPWAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String page = "setPW.jsp";
		HttpSession session = request.getSession();
		
		
		String id = (String) session.getAttribute("id");
		String pw = request.getParameter("password");
		
		session.invalidate();
		
		
		if(new SetPWService().setPw(id, pw)){
			page = "login.jsp";
		}
		
		
		return new URLModel(page, true);
	}

}
