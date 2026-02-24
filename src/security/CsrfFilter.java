package security;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;

public class CsrfFilter implements Filter {

    private static final String CSRF_TOKEN = "CSRF_TOKEN";
    private static final SecureRandom secureRandom = new SecureRandom();
    private static final DateTimeFormatter formatter =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Override
    public void init(FilterConfig filterConfig) {
        System.out.println("[SECURITY] CSRF Filter initialized");
    }

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(true);
        String method = req.getMethod();

        String userId = (String) session.getAttribute("userId");
        boolean authenticated = (userId != null);

        // 로그인 사용자만 보호
        if (authenticated) {

            // GET 요청 시 토큰 없으면 생성
            if ("GET".equalsIgnoreCase(method)) {
                ensureTokenExists(session);
            }

            // 상태 변경 요청 검증
            if (isStateChangingMethod(method)) {

                String sessionToken = (String) session.getAttribute(CSRF_TOKEN);
                String requestToken = extractToken(req);

                String reason = validateToken(sessionToken, requestToken);

                if (reason != null) {

                    // 보안 로그 기록
                    logCsrfEvent(req, session, userId, reason);

                    // 세션 무효화 (피해자 보호 목적)
                    session.invalidate();

                    res.sendError(HttpServletResponse.SC_FORBIDDEN,
                            "CSRF validation failed");
                    return;
                }
            }

            // JSP에서 사용 가능하게 request scope에 추가
            req.setAttribute("csrfToken",
                    session.getAttribute(CSRF_TOKEN));
        }

        chain.doFilter(request, response);
    }

    private void ensureTokenExists(HttpSession session) {
        if (session.getAttribute(CSRF_TOKEN) == null) {
            session.setAttribute(CSRF_TOKEN, generateToken());
        }
    }

    private boolean isStateChangingMethod(String method) {
        return "POST".equalsIgnoreCase(method)
                || "PUT".equalsIgnoreCase(method)
                || "DELETE".equalsIgnoreCase(method);
    }

    private String validateToken(String sessionToken,
                                 String requestToken) {

        if (sessionToken == null) {
            return "SESSION_TOKEN_MISSING";
        }
        if (requestToken == null) {
            return "REQUEST_TOKEN_MISSING";
        }
        if (!sessionToken.equals(requestToken)) {
            return "TOKEN_MISMATCH";
        }
        return null;
    }

    private String extractToken(HttpServletRequest req) {
        String token = req.getHeader("X-CSRF-Token");
        if (token == null) {
            token = req.getParameter("csrfToken");
        }
        return token;
    }

    private String generateToken() {
        byte[] token = new byte[32]; // 256-bit
        secureRandom.nextBytes(token);
        return Base64.getUrlEncoder()
                .withoutPadding()
                .encodeToString(token);
    }

    /**
     * 구조화된 보안 로그 (Wazuh 파싱 최적화)
     */
    private void logCsrfEvent(HttpServletRequest req,
                              HttpSession session,
                              String userId,
                              String reason) {

        String timestamp =
                LocalDateTime.now().format(formatter);

        String log = String.format(
                "SECURITY_EVENT=CSRF_BLOCK " +
                "time=\"%s\" " +
                "ip=%s " +
                "user=%s " +
                "auth=true " +
                "session=%s " +
                "method=%s " +
                "uri=\"%s\" " +
                "reason=%s " +
                "referer=\"%s\" " +
                "origin=\"%s\" " +
                "ua=\"%s\"",
                timestamp,
                req.getRemoteAddr(),
                userId,
                session.getId(),
                req.getMethod(),
                req.getRequestURI(),
                reason,
                safe(req.getHeader("Referer")),
                safe(req.getHeader("Origin")),
                safe(req.getHeader("User-Agent"))
        );

        System.out.println(log);
    }

    private String safe(String value) {
        if (value == null) return "-";
        return value.replace("\"", "");
    }

    @Override
    public void destroy() {
        System.out.println("[SECURITY] CSRF Filter destroyed");
    }
}