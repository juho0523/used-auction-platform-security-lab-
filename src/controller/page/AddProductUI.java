package controller.page;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import controller.Action;
import controller.URLModel;

public class AddProductUI implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		return new URLModel("addProduct.jsp");
	}

}
