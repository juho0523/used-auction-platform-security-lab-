package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import controller.Action;
import controller.URLModel;
import service.DuplicationService;

public class IdCheckAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String id = request.getParameter("id");

		
		String result = null;
		
		if(new DuplicationService().idCheck(id)){
			result = "다른 유저가 사용중인 아이디입니다.";
		} else {
			result = "사용할 수 있는 아이디입니다.";
		}
		request.setAttribute("idCheckFeedBackResult", result);
		
		
		return new URLModel("idCheck.jsp", false);
	}

}
