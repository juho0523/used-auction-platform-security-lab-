package controller.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import controller.Action;
import controller.URLModel;
import dto.ProductBoxDTO;
import service.ProductListService;
import service.ProductService;

public class SortAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		String region = request.getParameter("region");
		
		ArrayList<ProductBoxDTO> dtoList = new ProductListService().getList(region);
		new ProductService().setProductStateByEndDate(dtoList);
		request.setAttribute("list", dtoList);
		
		
		return new URLModel("asynchronous_productList.jsp", false);
	}

}
