package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import controller.Action;
import controller.URLModel;
import dto.ProductBoxDTO;
import service.MyPointService;
import service.ProductService;
import service.SetRateService;

public class SetRateAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {

		int productSeq = Integer.parseInt(request.getParameter("productSeq"));
		double rate = Double.parseDouble(request.getParameter("rate"));
		System.out.println(productSeq);
		System.out.println(rate);
		
		SetRateService setRateService = new SetRateService();
		setRateService.setRate(productSeq, rate);
		ProductBoxDTO dto = new ProductService().getProduct(productSeq);
		new MyPointService().setPoint(dto.getId(), dto.getBidMax());
		return new URLModel("controller?cmd=buyListUI", true);
	}
}