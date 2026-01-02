package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import controller.Action;
import controller.URLModel;
import service.ProductSellListService;

public class SellListAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		
		String userId = (String)request.getSession().getAttribute("userId");
		String type = request.getParameter("type");
		
		if(type.equals("selling")){
			request.setAttribute("sellList", new ProductSellListService().getSellingList(userId));
		} else if(type.equals("sellComplete")){
			request.setAttribute("sellList", new ProductSellListService().getSellCompleteList(userId));
		}
		
		request.setAttribute("type", type);
		
		return new URLModel("asynchronous_sellList.jsp", false);
	}

}
