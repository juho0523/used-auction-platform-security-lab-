package controller.action;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import controller.Action;
import controller.URLModel;
import service.LoginService;
import vo.UserVO;

public class LoginAction implements Action {

    private static final Logger securityLogger =
            Logger.getLogger("SECURITY_AUTH");

    private LoginService loginService = new LoginService();

    @Override
    public URLModel execute(HttpServletRequest request)
            throws ServletException, IOException {

        String userId = request.getParameter("userId");
        String userPw = request.getParameter("userPw");
        String clientIp = request.getRemoteAddr();
        String endpoint = request.getRequestURI();

        HttpSession session = request.getSession();

        /* ===== 로그인 실패 카운트 ===== */
        Integer failCount =
                (Integer) session.getAttribute("LOGIN_FAIL_COUNT");
        if (failCount == null) {
            failCount = 0;
        }

        UserVO vo = loginService.login(userId, userPw);

        /* ===== 입력 특성 계산 (로그 전용) ===== */
        int inputLen = (userId != null) ? userId.length() : 0;
        String inputType = classifyInputType(userId);
        boolean suspicious = containsSqlMetaChar(userId);

        if (vo == null) {
            // 실패 횟수 증가
            failCount++;
            session.setAttribute("LOGIN_FAIL_COUNT", failCount);

            // 로그인 실패 보안 로그
            securityLogger.warning(
                "AUTH_FAIL " +
                "ip=" + clientIp +
                " endpoint=" + endpoint +
                " fail_count=" + failCount +
                " input_len=" + inputLen +
                " input_type=" + inputType +
                " suspicious_pattern=" + suspicious +
                " reason=INVALID_CREDENTIAL"
            );

            return new URLModel("controller?cmd=loginUI", true);
        }

        // ===== 로그인 성공 시 실패 카운트 초기화 =====
        session.removeAttribute("LOGIN_FAIL_COUNT");

        // 로그인 성공 보안 로그
        securityLogger.info(
            "AUTH_SUCCESS " +
            "ip=" + clientIp +
            " endpoint=" + endpoint +
            " userType=" + vo.getUserType()
        );

        String[] address = vo.getAddress().split(" ");

        if ("U".equals(vo.getUserType())) {
            session.setAttribute("userId", vo.getUserId());
            session.setAttribute("nickName", vo.getNickName());
            session.setAttribute("address", address[1]);
            return new URLModel("controller?cmd=mainUI", true);

        } else if ("M".equals(vo.getUserType())) {
            session.setAttribute("userId", vo.getUserId());
            session.setAttribute("nickName", vo.getNickName());
            session.setAttribute("address", address[1]);
            return new URLModel("controller?cmd=mainManagerUI", true);

        } else {
            return new URLModel("controller?cmd=loginUI", true);
        }
    }

    /* ===== 로그 분류용 유틸 메서드 ===== */

    private boolean containsSqlMetaChar(String input) {
        if (input == null) return false;
        return input.matches(".*(['\";]|--).*");
    }

    private String classifyInputType(String input) {
        if (input == null) return "UNKNOWN";
        if (input.matches("[a-zA-Z0-9]+")) return "ALPHANUM";
        if (input.matches("[a-zA-Z0-9\\W]+")) return "ALPHANUM_SPECIAL";
        return "OTHER";
    }
}
