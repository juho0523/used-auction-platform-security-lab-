package controller.page;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import controller.Action;
import controller.URLModel;
import service.UserService;
import vo.UserVO;

public class SetMyInfoUI implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("userId");
		String nickname = null;
		String phoneNumber = null;
		String email = null;
		String address = null;
		
		
		UserVO vo = new UserService().getUsers(id);
		nickname = vo.getNickName();
		phoneNumber = vo.getPhoneNumber();
		email = vo.getEmail();
		address = vo.getAddress();
		System.out.println("주소 : "+address);
		
		String[] addressArray = address.split(" ");
		String address_city = addressArray[0];
		String address_district = addressArray[1];
		System.out.println(address_city);
		System.out.println(address_district);
		
		
		request.setAttribute("nickname", nickname);
		request.setAttribute("phoneNumber", phoneNumber);
		request.setAttribute("email", email);
		request.setAttribute("cityAddress", address_city);
		request.setAttribute("districtAddress", address_district);
		
		
		return new URLModel("setMyInfo.jsp", false);
	}

}
