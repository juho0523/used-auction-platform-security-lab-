package controller.page;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import controller.Action;
import controller.URLModel;
import service.NotiService;
import service.ProductListService;

public class NotiUI implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {

		String id = (String)request.getSession().getAttribute("userId");
		boolean res = new NotiService().setNotiState(id);	
		request.setAttribute("list", new NotiService().getNotiList(id));	
		return new URLModel("notiUI.jsp");
	}

}
