package controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import controller.Action;
import controller.URLModel;
import service.LoginService;
import vo.UserVO;

public class LoginAction implements Action {

	private LoginService loginService = new LoginService();

	@Override
	public URLModel execute(HttpServletRequest request) throws ServletException, IOException {

		String userId = request.getParameter("userId");
		String userPw = request.getParameter("userPw");
		String clientIp = request.getRemoteAddr();
		String endpoint = request.getRequestURI();

		HttpSession session = request.getSession();

		UserVO vo = loginService.login(userId, userPw);

		if (vo == null) {
			// 로그인 실패 보안 로그
			securityLogger.warning(
					"AUTH_FAIL ip=" + clientIp +
							" endpoint=" + endpoint +
							" reason=INVALID_CREDENTIAL");
			return new URLModel("controller?cmd=loginUI", true);
		}

		// 로그인 성공 보안 로그
		securityLogger.info(
				"AUTH_SUCCESS ip=" + clientIp +
						" endpoint=" + endpoint +
						" userType=" + vo.getUserType());

		String[] address = vo.getAddress().split(" ");

		if (vo.getUserType().equals("U")) {
			session.setAttribute("userId", vo.getUserId());
			session.setAttribute("nickName", vo.getNickName());
			session.setAttribute("address", address[1]);
			return new URLModel("controller?cmd=mainUI", true);

		} else if (vo.getUserType().equals("M")) {
			session.setAttribute("userId", vo.getUserId());
			session.setAttribute("nickName", vo.getNickName());
			session.setAttribute("address", address[1]);
			return new URLModel("controller?cmd=mainManagerUI", true);

		} else {
			return new URLModel("controller?cmd=loginUI", true);
		}
	}
}