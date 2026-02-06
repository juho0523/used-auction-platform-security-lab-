package controller.action;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import config.SHA256;
import controller.Action;
import controller.URLModel;
import service.LoginService;
import vo.UserVO;

public class LoginAction implements Action {

    /* =========================
       보안 로거 설정
       ========================= */
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

        HttpSession session = request.getSession();
        String messageContent = "";

        String userId = request.getParameter("userId");
        String userPw = request.getParameter("userPw");

        String clientIp = request.getRemoteAddr();
        String endpoint = request.getRequestURI();

        /* =========================
           입력값 검증
           ========================= */
        if (userId == null || userId.trim().isEmpty()) {
            messageContent = "아이디를 입력해주세요.";
            session.setAttribute("messageContent", messageContent);
            return new URLModel("controller?cmd=loginUI", true);
        }

        if (userPw == null || userPw.trim().isEmpty()) {
            messageContent = "비밀번호를 입력해주세요.";
            session.setAttribute("messageContent", messageContent);
            return new URLModel("controller?cmd=loginUI", true);
        }

        /* =========================
           비밀번호 암호화
           ========================= */
        userPw = SHA256.encrypt(userPw);

        /* =========================
           로그인 시도
           ========================= */
        UserVO vo = loginService.login(userId, userPw);

        if (vo == null) {
            handleLoginFail(clientIp, endpoint, userId);

            messageContent = "아이디 또는 비밀번호가 일치하지 않습니다.";
            session.setAttribute("messageContent", messageContent);
            return new URLModel("controller?cmd=loginUI", true);
        }

        /* =========================
           로그인 성공
           ========================= */
        clearFailCount(clientIp);

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
            session.setAttribute("address", address.length > 1 ? address[1] : "");
            session.setAttribute("messageContent", "로그인 성공");
            return new URLModel("controller?cmd=mainUI", true);

        } else if ("D".equals(vo.getUserType())) {
            session.setAttribute("messageContent", "로그인 실패");
            return new URLModel("controller?cmd=loginUI", true);
        }

        return new URLModel("controller?cmd=loginUI", true);
    }

    /* =========================
       로그인 실패 로그 처리
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

        long elapsedSec =
                tracker.count > 1 ? (now - tracker.firstFailTime) / 1000 : 0;

        String authLevel =
                tracker.count >= THRESHOLD ? "HIGH" : "LOW";

        int inputLen = userId != null ? userId.length() : 0;
        String inputType = classifyInputType(userId);
        boolean suspicious = containsSqlMetaChar(userId);

        securityLogger.warning(
            "AUTH_FAIL " +
            "ip=" + ip +
            " endpoint=" + endpoint +
            " auth_fail_total=" + tracker.count +
            " auth_level=" + authLevel +
            " auth_window_sec=" + elapsedSec +
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
       입력 분석 유틸
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
       실패 추적 클래스
       ========================= */
    private static class FailTracker {
        int count = 0;
        long firstFailTime = 0L;
    }
}
