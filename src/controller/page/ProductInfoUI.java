package controller.page;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import controller.Action;
import controller.URLModel;
import dto.ProductBoxDTO;
import service.ProductService;
import service.UserService;
import vo.ProductVO;

public class ProductInfoUI implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int productSeq = Integer.parseInt(request.getParameter("productSeq"));
		
		ProductBoxDTO dto = new ProductService().getProduct(productSeq);
		dto.setImgURL(new ProductService().getProductImage(productSeq));
		
		int point = new UserService().getUser((String)session.getAttribute("userId"));
		request.setAttribute("productInfo", dto);
		request.setAttribute("point", point);
		return new URLModel("productInfo.jsp");
	}
}