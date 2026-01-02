package controller.page;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import controller.Action;
import controller.URLModel;
import dto.ProductBoxDTO;
import service.NotiService;
import service.ProductListService;
import service.ProductService;

public class MainUI implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		String id = (String)request.getSession().getAttribute("userId");
		String address = (String)request.getSession().getAttribute("address");
		
		ArrayList<ProductBoxDTO> dtoList = new ProductListService().getList(address);
		new ProductService().setProductStateByEndDate(dtoList);
		request.setAttribute("notiState", new NotiService().getNotiState(id));
		request.setAttribute("list", dtoList);
		
		return new URLModel("mainUI.jsp");
	}

}
