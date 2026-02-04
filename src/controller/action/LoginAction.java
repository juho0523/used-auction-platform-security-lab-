package controller.action;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
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

    private static final int WINDOW_SEC = 30;
    private static final int THRESHOLD = 5;

    private static final Map<String, FailTracker> failMap =
            new ConcurrentHashMap<>();

    private LoginService loginService = new LoginService();

    @Override
    public URLModel execute(HttpServletRequest request)
            throws ServletException, IOException {

        String userId = request.getParameter("userId");
        String userPw = request.getParameter("userPw");
        String clientIp = request.getRemoteAddr();
        String endpoint = request.getRequestURI();

        HttpSession session = request.getSession();

        UserVO vo = loginService.login(userId, userPw);

        if (vo == null) {
            handleLoginFail(clientIp, endpoint, userId);
            return new URLModel("controller?cmd=loginUI", true);
        }

        // ===== 로그인 성공 =====
        clearFailCount(clientIp);

        securityLogger.info(
            "AUTH_SUCCESS " +
            "ip=" + clientIp +
            " endpoint=" + endpoint +
            " userType=" + vo.getUserType()
        );

        session.setAttribute("userId", vo.getUserId());
        session.setAttribute("nickName", vo.getNickName());
        session.setAttribute("address", vo.getAddress().split(" ")[1]);

        if ("M".equals(vo.getUserType())) {
            return new URLModel("controller?cmd=mainManagerUI", true);
        }
        return new URLModel("controller?cmd=mainUI", true);
    }

    /* =========================
       로그인 실패 처리 로직
       ========================= */
    private void handleLoginFail(String ip, String endpoint, String userId) {
        long now = System.currentTimeMillis();

        FailTracker tracker = failMap.getOrDefault(ip, new FailTracker());

        if (tracker.firstFailTime == 0 ||
            (now - tracker.firstFailTime) > WINDOW_SEC * 1000) {

            tracker.count = 1;
            tracker.firstFailTime = now;
        } else {
            tracker.count++;
        }

        failMap.put(ip, tracker);

        String authLevel = tracker.count >= THRESHOLD ? "HIGH" : "LOW";

        int inputLen = userId != null ? userId.length() : 0;
        String inputType = classifyInputType(userId);
        boolean suspicious = containsSqlMetaChar(userId);

        securityLogger.warning(
            "AUTH_FAIL " +
            "ip=" + ip +
            " endpoint=" + endpoint +
            " auth_fail_total=" + tracker.count +
            " auth_level=" + authLevel +
            " auth_window_sec=" + tracker.firstFailTime +
            " input_len=" + inputLen +
            " input_type=" + inputType +
            " suspicious_pattern=" + suspicious +
            " reason=INVALID_CREDENTIAL"
        );
    }

    private void clearFailCount(String ip) {
        failMap.remove(ip);
    }

    /* =========================
       로그 분류용 유틸
       ========================= */
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

    /* =========================
       내부 실패 추적 클래스
       ========================= */
    private static class FailTracker {
        int count = 0;
        long firstFailTime = 0L;
    }
}
