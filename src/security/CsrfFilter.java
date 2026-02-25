package security;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class CsrfFilter implements Filter {

    private static final String CSRF_TOKEN = "CSRF_TOKEN";
    private static final SecureRandom secureRandom = new SecureRandom();
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    // 사용자별 공격 추적 (서버 단 계산)
    private static final Map<String, AttemptInfo> attemptMap = new ConcurrentHashMap<>();
    private static final long WINDOW_MS = 60_000; // 60초 윈도우
    private static final int RISK_THRESHOLD = 50; // 세션 무효화 기준 점수

    @Override
    public void init(FilterConfig filterConfig) {
        System.out.println("[SECURITY] CSRF Filter initialized");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(true);

        String method = req.getMethod();
        String userId = (String) session.getAttribute("userId");
        boolean authenticated = (userId != null);

        if (authenticated) {
            if ("GET".equalsIgnoreCase(method)) {
                ensureTokenExists(session);
            }

            if (isStateChangingMethod(method)) {
                String sessionToken = (String) session.getAttribute(CSRF_TOKEN);
                String requestToken = extractToken(req);
                String reason = validateToken(sessionToken, requestToken);

                if (reason != null) {
                    AttemptInfo info = updateRisk(userId, req);
                    logCsrfEvent(req, session, userId, reason, info);

                    if (info.riskScore >= RISK_THRESHOLD) {
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

    private AttemptInfo updateRisk(String userId, HttpServletRequest req) {
        long now = System.currentTimeMillis();
        AttemptInfo info = attemptMap.getOrDefault(userId, new AttemptInfo());

        // 윈도우 초과 시 초기화
        if (info.firstAttemptTime != 0 && now - info.firstAttemptTime > WINDOW_MS) {
            info = new AttemptInfo();
        }

        if (info.failCount == 0) {
            info.firstAttemptTime = now;
        }

        info.failCount++;
        long previousAttemptTime = info.lastAttemptTime;
        info.lastAttemptTime = now;

        // 기본 점수
        info.riskScore += 10;

        // 외부 referer 가중치
        String referer = req.getHeader("Referer");
        if (referer != null && !referer.contains(req.getServerName())) {
            info.riskScore += 20;
        }

        // 5초 이내 재시도 가중치
        if (previousAttemptTime != 0 && now - previousAttemptTime < 5000) {
            info.riskScore += 15;
        }

        // 반복 가중치
        if (info.failCount >= 3) {
            info.riskScore += 30;
        }

        attemptMap.put(userId, info);
        return info;
    }

    private boolean isStateChangingMethod(String method) {
        return "POST".equalsIgnoreCase(method) || 
               "PUT".equalsIgnoreCase(method) || 
               "DELETE".equalsIgnoreCase(method);
    }

    private String validateToken(String sessionToken, String requestToken) {
        if (sessionToken == null) return "SESSION_TOKEN_MISSING";
        if (requestToken == null) return "REQUEST_TOKEN_MISSING";
        if (!sessionToken.equals(requestToken)) return "TOKEN_MISMATCH";
        return null;
    }

    private String extractToken(HttpServletRequest req) {
        String token = req.getHeader("X-CSRF-Token");
        if (token == null) {
            token = req.getParameter("csrfToken");
        }
        return token;
    }

    private void ensureTokenExists(HttpSession session) {
        if (session.getAttribute(CSRF_TOKEN) == null) {
            session.setAttribute(CSRF_TOKEN, generateToken());
        }
    }

    private String generateToken() {
        byte[] token = new byte[32]; // 256-bit
        secureRandom.nextBytes(token);
        return Base64.getUrlEncoder()
                .withoutPadding()
                .encodeToString(token);
    }

    private void logCsrfEvent(HttpServletRequest req, HttpSession session, String userId, String reason, AttemptInfo info) {
        String timestamp = LocalDateTime.now().format(formatter);
        String log = String.format(
            "SECURITY_EVENT=CSRF_BLOCK " +
            "time=\"%s\" " +
            "ip=%s " +
            "user=%s " +
            "session=%s " +
            "method=%s " +
            "uri=\"%s\" " +
            "reason=%s " +
            "csrfFailCount=%d " +
            "csrfRiskScore=%d " +
            "csrfRiskLevel=%s " +
            "referer=\"%s\" " +
            "ua=\"%s\"",
            timestamp, req.getRemoteAddr(), userId, session.getId(),
            req.getMethod(), req.getRequestURI(), reason,
            info.failCount, info.riskScore, getRiskLevel(info.riskScore),
            safe(req.getHeader("Referer")), safe(req.getHeader("User-Agent"))
        );
        System.out.println(log);
    }

    private String getRiskLevel(int score) {
        if (score >= 70) return "CRITICAL";
        if (score >= 50) return "HIGH";
        if (score >= 30) return "MEDIUM";
        return "LOW";
    }

    private String safe(String value) {
        if (value == null) return "-";
        return value.replace("\"", "");
    }

    @Override
    public void destroy() {
        System.out.println("[SECURITY] CSRF Filter destroyed");
    }

    private static class AttemptInfo {
        long firstAttemptTime = 0;
        long lastAttemptTime = 0;
        int failCount = 0;
        int riskScore = 0;
    }
}