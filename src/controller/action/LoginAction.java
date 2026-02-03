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

    private static final int BRUTEFORCE_WINDOW_SECONDS = 120;

    private LoginService loginService = new LoginService();

    @Override
    public URLModel execute(HttpServletRequest request)
            throws ServletException, IOException {

        String userId = request.getParameter("userId");
        String userPw = request.getParameter("userPw");
        String clientIp = request.getRemoteAddr();
        String endpoint = request.getRequestURI();

        HttpSession session = request.getSession();

        /* ===== 로그인 실패 상태 로드 ===== */
        Integer failCount =
                (Integer) session.getAttribute("LOGIN_FAIL_COUNT");
        Long firstFailTs =
                (Long) session.getAttribute("LOGIN_FAIL_FIRST_TS");

        long now = System.currentTimeMillis();

        if (failCount == null || firstFailTs == null) {
            failCount = 0;
            firstFailTs = now;
        }

        /* ===== 로그인 시도 ===== */
        UserVO vo = loginService.login(userId, userPw);

        /* ===== 입력 특성 계산 (ID 기준) ===== */
        int inputLen = (userId != null) ? userId.length() : 0;
        String inputType = classifyInputType(userId);
        boolean suspicious = containsSqlMetaChar(userId);

        if (vo == null) {
            /* ===== 로그인 실패 ===== */

            failCount++;
            session.setAttribute("LOGIN_FAIL_COUNT", failCount);
            session.setAttribute("LOGIN_FAIL_FIRST_TS", firstFailTs);

            long windowSeconds = (now - firstFailTs) / 1000;

            securityLogger.warning(
                "AUTH_FAIL " +
                "ip=" + clientIp +
                " endpoint=" + endpoint +
                " fail_count=" + failCount +
                " window=" + windowSeconds + "s" +
                " input_len=" + inputLen +
                " input_type=" + inputType +
                " suspicious_pattern=" + suspicious +
                " reason=INVALID_CREDENTIAL"
            );

            return new URLModel("controller?cmd=loginUI", true);
        }

        /* ===== 로그인 성공 ===== */
        session.removeAttribute("LOGIN_FAIL_COUNT");
        session.removeAttribute("LOGIN_FAIL_FIRST_TS");

        securityLogger.info(
            "AUTH_SUCCESS " +
            "ip=" + clientIp +
            " endpoint=" + endpoint +
            " userType=" + vo.getUserType()
        );

        String[] address = vo.getAddress().split(" ");

        session.setAttribute("userId", vo.getUserId());
        session.setAttribute("nickName", vo.getNickName());
        session.setAttribute("address", address[1]);

        if ("U".equals(vo.getUserType())) {
            return new URLModel("controller?cmd=mainUI", true);
        } else if ("M".equals(vo.getUserType())) {
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
