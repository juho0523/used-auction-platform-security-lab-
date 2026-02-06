package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import controller.Action;
import controller.URLModel;
import service.MyPointService;

public class MyPointAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String page = "controller?cmd=myPageUI";
		
		String id = (String)request.getSession().getAttribute("userId");
		String strPoint = request.getParameter("pointAct");
		
		int point = 0;
		try {
			point = Integer.parseInt(strPoint);
		} catch (NumberFormatException e) {
			// TODO: handle exception
		}
			
		System.out.println("point : " + point);
		System.out.println("strPoint : " + strPoint);
		
		if(new MyPointService().setPoint(id, point)){
			page = "pointActionCheck.jsp";
		}
		
		request.setAttribute("pointActCheck", strPoint);
		
		
		
		return new URLModel(page, false);
	}

}
