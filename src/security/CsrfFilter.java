package security;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;

public class CsrfFilter implements Filter {

    private static final String CSRF_TOKEN = "CSRF_TOKEN";
    private static final SecureRandom secureRandom = new SecureRandom();

    // 256-bit 토큰 생성
    private String generateToken() {
        byte[] token = new byte[32];
        secureRandom.nextBytes(token);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(token);
    }

    @Override
    public void init(FilterConfig filterConfig) {
        System.out.println("[CSRF] Filter initialized");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(true);

        String method = req.getMethod();

// 로그인 사용자만 보호
if (session.getAttribute("userId") != null) {

    // GET이면 먼저 토큰 생성
    if ("GET".equalsIgnoreCase(method)) {
        if (session.getAttribute(CSRF_TOKEN) == null) {
            session.setAttribute(CSRF_TOKEN, generateToken());
        }
    }

    // 상태 변경 요청 검증
    if (isStateChangingMethod(method)) {

        String sessionToken = (String) session.getAttribute(CSRF_TOKEN);
        String requestToken = extractToken(req);

        if (sessionToken == null ||
            requestToken == null ||
            !sessionToken.equals(requestToken)) {

            logAttackAttempt(req);
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "CSRF validation failed");
            return;
        }
    }

    req.setAttribute("csrfToken", session.getAttribute(CSRF_TOKEN));
}

        // GET 요청 시 토큰 없으면 생성
        if ("GET".equalsIgnoreCase(method)) {
            if (session.getAttribute(CSRF_TOKEN) == null) {
                session.setAttribute(CSRF_TOKEN, generateToken());
            }
        }

        // JSP에서 사용 가능하게 request scope에 추가
        req.setAttribute("csrfToken", session.getAttribute(CSRF_TOKEN));

        chain.doFilter(request, response);
    }

    private boolean isStateChangingMethod(String method) {
        return "POST".equalsIgnoreCase(method)
                || "PUT".equalsIgnoreCase(method)
                || "DELETE".equalsIgnoreCase(method);
    }

    private String extractToken(HttpServletRequest req) {
        // AJAX 우선
        String token = req.getHeader("X-CSRF-Token");
        if (token == null) {
            token = req.getParameter("csrfToken");
        }
        return token;
    }

    private void logAttackAttempt(HttpServletRequest req) {
        System.out.println("[CSRF DETECTED]");
        System.out.println("IP: " + req.getRemoteAddr());
        System.out.println("URI: " + req.getRequestURI());
        System.out.println("Method: " + req.getMethod());
    }

    @Override
    public void destroy() {
        System.out.println("[CSRF] Filter destroyed");
    }
}