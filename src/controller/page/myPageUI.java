package controller.page;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import controller.Action;
import controller.URLModel;
import service.MyPageService;
import vo.UserVO;

public class myPageUI implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("userId");
		

		
		UserVO vo = null;
		String nickname = null;
		double rate = 0;
		int point = 0;
		String strRate = null;
		String strPoint = null;
		
		vo = new MyPageService().getUser(id);
		
		nickname = vo.getNickName();
		rate = vo.getRate();
		point = vo.getPoint();
		
		try {
			strRate = Double.toString(rate);
			strPoint = Integer.toString(point);
		} catch (NumberFormatException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		
		request.setAttribute("nickname", nickname);
		request.setAttribute("rate", strRate);
		request.setAttribute("point", strPoint);
		
		return new URLModel("myPage.jsp", false);
	}

}
