package controller.page;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import controller.Action;
import controller.URLModel;
import service.ProductSellListService;

public class SellListUI implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		
		String userId = (String)request.getSession().getAttribute("userId");

		request.setAttribute("sellList", new ProductSellListService().getSellingList(userId));
		//request.setAttribute("sellList", new ProductSellListService().getSellCompleteList(userId));
		
		return new URLModel("sellList.jsp", false);
	}

}
