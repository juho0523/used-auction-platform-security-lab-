package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import controller.Action;
import controller.URLModel;
import dao.UserDAO;
import service.FindIDService;
import vo.UserVO;

public class FindIDAction implements Action {

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//String page = "showID.jsp";
		HttpSession session = request.getSession();
		String messageContent = "";
		
		String name = request.getParameter("name");
		String phoneNumber = request.getParameter("phoneNumber");
		String email = request.getParameter("email");
		
		if(name == "" || phoneNumber == "" || email == ""){
			messageContent = "정보를 입력해주세요.";
			session.setAttribute("messageContent", messageContent);
			return new URLModel("controller?cmd=findIDUI", true);
		}
		
		String id = new FindIDService().findId(name, email, phoneNumber);
		//System.out.println("아이디  : "+id);
		
		if(id == null){
			messageContent = "존재하지 않는 회원정보입니다.";
			session.setAttribute("messageContent", messageContent);
			return new URLModel("controller?cmd=findIDUI", true);
		} else {
			messageContent = "아이디는 ["+id+"] 입니다.";
			session.setAttribute("messageContent", messageContent);
			return new URLModel("controller?cmd=loginUI", true);
		}
		
		//request.setAttribute("id", id);
		//return  new URLModel("controller?cmd=loginUI", true);
	}

}
