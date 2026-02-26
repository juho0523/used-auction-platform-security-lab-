package security;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Logger; // Logger 추가
import java.util.logging.Level;

public class CsrfFilter implements Filter {
    /* ========================= 보안 로거 및 설정 추가 ========================= */
    private static final Logger securityLogger = Logger.getLogger("SECURITY_CSRF");
    private static final String CSRF_TOKEN = "CSRF_TOKEN";
    private static final SecureRandom secureRandom = new SecureRandom();
    
    private static final Map<String, AttemptInfo> attemptMap = new ConcurrentHashMap<>();
    private static final long WINDOW_MS = 60_000; 
    private static final int RISK_THRESHOLD = 50; 

    @Override
    public void init(FilterConfig filterConfig) {
        securityLogger.info("CSRF_FILTER_INIT status=success");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(true);
        String method = req.getMethod();
        String userId = (String) session.getAttribute("userId");
        
        // 비로그인 사용자도 추적하기 위해 세션 ID 활용
        String identifier = (userId != null) ? userId : "ANONYMOUS_" + session.getId();

        if (userId != null) { // 인증된 사용자 대상 CSRF 검사
            if ("GET".equalsIgnoreCase(method)) {
                ensureTokenExists(session);
            }

            if (isStateChangingMethod(method)) {
                String sessionToken = (String) session.getAttribute(CSRF_TOKEN);
                String requestToken = extractToken(req);
                String reason = validateToken(sessionToken, requestToken);

                if (reason != null) {
                    AttemptInfo info = updateRisk(identifier, req);
                    
                    /* ========================= 구조화된 보안 로깅 ========================= */
                    logCsrfWarning(req, session, identifier, reason, info);

                    if (info.riskScore >= RISK_THRESHOLD) {
                        securityLogger.severe("CSRF_SESSION_INVALIDATED user=" + identifier + " score=" + info.riskScore);
                        session.invalidate();
                    }
                    
                    res.sendError(HttpServletResponse.SC_FORBIDDEN, "CSRF validation failed");
                    return;
                }
            }
            req.setAttribute("csrfToken", session.getAttribute(CSRF_TOKEN));
        }

        chain.doFilter(request, response);
    }

    /* ========================= 로깅 메소드 수정 ========================= */
    private void logCsrfWarning(HttpServletRequest req, HttpSession session, String user, String reason, AttemptInfo info) {
        String logMsg = String.format(
            "CSRF_BLOCK " +
            "ip=%s " +
            "user=%s " +
            "sid=%s " +
            "method=%s " +
            "uri=%s " +
            "reason=%s " +
            "fail_count=%d " +
            "risk_score=%d " +
            "risk_level=%s " +
            "referer=%s",
            req.getRemoteAddr(),
            user,
            session.getId(),
            req.getMethod(),
            req.getRequestURI(),
            reason,
            info.failCount,
            info.riskScore,
            getRiskLevel(info.riskScore),
            safe(req.getHeader("Referer"))
        );
        
        // System.out 대신 Logger 사용 (Catalina 로그에 기록됨)
        securityLogger.warning(logMsg);
    }

    private AttemptInfo updateRisk(String identifier, HttpServletRequest req) {
        long now = System.currentTimeMillis();
        AttemptInfo info = attemptMap.getOrDefault(identifier, new AttemptInfo());

        if (info.firstAttemptTime != 0 && now - info.firstAttemptTime > WINDOW_MS) {
            info = new AttemptInfo();
        }

        if (info.failCount == 0) info.firstAttemptTime = now;
        
        info.failCount++;
        long prevTime = info.lastAttemptTime;
        info.lastAttemptTime = now;

        info.riskScore += 10; // 기본 패널티
        
        String referer = req.getHeader("Referer");
        if (referer == null || !referer.contains(req.getServerName())) {
            info.riskScore += 20; // 외부 유입 의심
        }

        if (prevTime != 0 && now - prevTime < 5000) {
            info.riskScore += 15; // 단시간 반복 공격
        }

        attemptMap.put(identifier, info);
        return info;
    }

    private boolean isStateChangingMethod(String method) {
        return "POST".equalsIgnoreCase(method) || "PUT".equalsIgnoreCase(method) || "DELETE".equalsIgnoreCase(method);
    }

    private String validateToken(String sessionToken, String requestToken) {
        if (sessionToken == null) return "SESSION_TOKEN_MISSING";
        if (requestToken == null) return "REQUEST_TOKEN_MISSING";
        if (!sessionToken.equals(requestToken)) return "TOKEN_MISMATCH";
        return null;
    }

    private String extractToken(HttpServletRequest req) {
        String token = req.getHeader("X-CSRF-Token");
        return (token != null) ? token : req.getParameter("csrfToken");
    }

    private void ensureTokenExists(HttpSession session) {
        if (session.getAttribute(CSRF_TOKEN) == null) {
            byte[] tokenBytes = new byte[32];
            secureRandom.nextBytes(tokenBytes);
            session.setAttribute(CSRF_TOKEN, Base64.getUrlEncoder().withoutPadding().encodeToString(tokenBytes));
        }
    }

    private String getRiskLevel(int score) {
        if (score >= 70) return "CRITICAL";
        if (score >= 50) return "HIGH";
        if (score >= 30) return "MEDIUM";
        return "LOW";
    }

    private String safe(String value) {
        return (value == null) ? "-" : value.replace("\"", "").replace(" ", "_");
    }

    @Override
    public void destroy() {}

    private static class AttemptInfo {
        long firstAttemptTime = 0, lastAttemptTime = 0;
        int failCount = 0, riskScore = 0;
    }
}