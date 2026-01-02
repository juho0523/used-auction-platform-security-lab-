package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import controller.Action;
import controller.URLModel;
import service.DuplicationService;

public class NickCheckAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String id = request.getParameter("nick");

		
		String result = null;
		
		if(new DuplicationService().nickCheck(id)){
			result = "다른 유저가 사용중인 닉네임입니다.";
		} else {
			result = "사용할 수 있는 닉네임입니다.";
		}
		request.setAttribute("nickCheckFeedBackResult", result);
		
		System.out.println("결과값 : " + result);
		
		return new URLModel("nickCheck.jsp", false);
	}

}
