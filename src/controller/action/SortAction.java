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
		String sort = request.getParameter("sort");

		ArrayList<ProductBoxDTO> dtoList = new ArrayList<>();
		if(sort.equals("지역별")){
			dtoList = new ProductListService().getList(region);
		}
		else if(sort.equals("카테고리별")){
			String category = request.getParameter("category");
			dtoList = new ProductListService().getListByCategory(region, category);
		}
		else if(sort.equals("선택별")){
			String hope = request.getParameter("hope");
			dtoList = new ProductListService().getListByHope(region, hope);
		}
		else if(sort.equals("검색")){
			String search = request.getParameter("search");
			dtoList = new ProductListService().getListBySearch(search, region);
		}
		
		new ProductService().setProductStateByEndDate(dtoList);
		request.setAttribute("list", dtoList);		
		
		return new URLModel("asynchronous_productList.jsp", false);
	}

}
