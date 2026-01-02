package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import controller.Action;
import controller.URLModel;
import service.NotiService;
import service.ProductService;

public class BidAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		int productSeq = Integer.parseInt(request.getParameter("productSeq"));
		int bidPrice = Integer.parseInt(request.getParameter("bidPrice"));
		String userId = (String) session.getAttribute("userId");
		
		boolean result = new ProductService().addBid(productSeq, userId, bidPrice);
		if(new NotiService().addNoti(productSeq)){}
		
		String page = "productInfoUI&productSeq=" + productSeq;
		
		return new URLModel("controller?cmd=" + page, true);
	}
}