package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import controller.Action;
import controller.URLModel;
import service.DeleteMyInfoService;
import vo.UserVO;

public class DeleteMyInfoAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String page = "myPage.jsp";
		
		HttpSession session = request.getSession(true);
		String id = (String) session.getAttribute("userId");

		
	
		
		if(new DeleteMyInfoService().setUserType(id)){
			page = "login.jsp";
		}
		
		return new URLModel(page, true);
	}

}
