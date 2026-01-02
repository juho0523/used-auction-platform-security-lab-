package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import controller.Action;
import controller.URLModel;

public class LogoutAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		session.invalidate();

		
		String page = "login.jsp";

		
		return new URLModel(page, true);
	}

}
