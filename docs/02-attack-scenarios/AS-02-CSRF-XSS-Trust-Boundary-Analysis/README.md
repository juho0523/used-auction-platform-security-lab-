### AS-02: Malicious Script Execution and Request Integrity Breakdown Analysis

---

### 1. Executive Summary

This document analyzes the security implications of arbitrary script execution within a legacy JSP/Servlet-based web application.

The objective of this scenario is not to demonstrate offensive capability, but to evaluate how malicious client-side script execution impacts request integrity, session trust, and defensive visibility.

The key defensive question addressed:

> What security guarantees remain valid if untrusted JavaScript can execute inside the trusted origin?

This analysis shows that once arbitrary script execution becomes possible, multiple higher-level controls—including request authenticity assumptions—can be undermined.

---

### 2. Defensive Perspective

This scenario was conducted from a blue-team / defensive architecture standpoint.

The purpose was to:

- Identify structural weaknesses
- Evaluate browser trust assumptions
- Analyze logging visibility
- Assess detection capability
- Determine defensive control gaps

No exploitation beyond controlled testing was performed.

---

### 3. Application Context

| Component | Description |
|------------|------------|
| Framework | JSP / Servlet |
| Architecture | Front Controller (cmd-based routing) |
| Session Handling | Cookie-based (JSESSIONID) |
| State-Changing Endpoint | `/controller?cmd=addChatAction` |
| CSRF Token | Not implemented |
| CSP | Not implemented |

The application assumes that authenticated requests originating from the browser represent legitimate user intent.

---

### 4. Malicious Script Execution Scenario

Assume a page renders user-controlled content without proper output encoding.

Example of injected script:

```html
<script>
$.post("/controller?cmd=addChatAction", {
    productSeq: 81,
    fromId: "authenticatedUser",
    toId: "targetUser",
    chatContent: "Automated message"
});
</script>
```

If such content is rendered in the application:

1. The script executes within the trusted origin.
2. The browser automatically attaches the active session cookie.
3. The request is processed as an authenticated user action.

No authentication bypass occurs.
No session hijacking occurs.

However, request integrity assumptions no longer hold.

---

### 5. Security Impact Analysis

This is not merely an XSS issue.

It represents a broader breakdown of security guarantees:

#### 5.1 Request Authenticity

The server assumes:

- Authenticated session = user intent

Malicious script execution invalidates that assumption.

Authenticated does not equal intentional.

---

#### 5.2 CSRF Control Weakness

Traditional CSRF protection relies on:

- Origin validation
- Token validation
- Cookie trust

If malicious script executes inside the origin:

- Origin headers remain valid
- Session cookies remain valid
- Tokens accessible via DOM may be retrievable

Thus, script execution can bypass intent validation mechanisms.

This does not mean CSRF is “automatically performed,”  
but rather that request integrity controls become unreliable.

---

#### 5.3 Privilege Abuse Risk

If administrative users view injected content:

- Elevated actions may be triggered
- State-changing endpoints may be invoked
- Business logic misuse becomes possible

Impact scope depends on user privilege level.

---

### 6. Logging and Detection Visibility

Observed Tomcat Access Log:

```log
127.0.0.1 - - [14/Feb/2026:11:03:42 +0900] "POST /used-auction-platform/controller?cmd=addChatAction HTTP/1.1" 200 512
```

Detection limitations:

- No payload inspection
- No script execution visibility
- No intent verification logging
- No CSP violation reporting
- No structured security event logging

From a SOC perspective:

The request appears identical to legitimate user activity.

This represents a monitoring blind spot.

---

### 7. Root Cause Analysis

The underlying issue is not a single vulnerability.

It is a combination of:

- Insufficient output encoding
- Lack of Content Security Policy
- No CSRF token enforcement
- Over-trust in browser session behavior
- Lack of security-focused telemetry

The architectural trust boundary between client and server is overly permissive.

---

### 8. Defensive Controls Required

To restore trust guarantees:

#### 8.1 Script Execution Prevention

- Context-aware output encoding
- Strict Content Security Policy (CSP)
- Input validation
- HttpOnly cookies

---

#### 8.2 Request Integrity Reinforcement

- Synchronizer token pattern
- SameSite=Strict cookies
- Origin and Referer validation
- Server-side intent validation logging

---

#### 8.3 Monitoring Improvements

- Structured security event logs
- CSP violation reporting endpoint
- SIEM-based correlation rules
- Behavioral anomaly detection for state-changing endpoints

---

### 9. Key Defensive Insight

Malicious script execution is not just a client-side vulnerability.

It is a collapse of the browser trust model.

Once arbitrary JavaScript executes within a trusted origin:

- Session-based trust becomes insufficient
- Request authenticity assumptions weaken
- Detection visibility decreases
- Multiple downstream controls degrade

Therefore:

Preventing arbitrary script execution is foundational to maintaining request integrity.

---

### 10. Conclusion

This analysis demonstrates that:

- Security controls are layered and interdependent.
- Script execution vulnerabilities undermine higher-level defenses.
- Authentication alone does not guarantee legitimate intent.
- Without enhanced logging and telemetry, such abuse remains invisible to SOC monitoring.

Effective defense requires:

- Preventive controls
- Trust boundary reinforcement
- Request integrity validation
- Security-focused observability
- Incident response readiness

This scenario was conducted to evaluate defensive posture, not to demonstrate offensive capability.
