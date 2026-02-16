### AS-02: Malicious Script Execution and Request Integrity Assessment

---

### 1. Executive Summary

This assessment evaluates the security impact of malicious script execution within a legacy JSP/Servlet-based web application.

The objective is to analyze how arbitrary client-side script execution affects:

- Request authenticity assumptions
- Session trust boundaries
- CSRF exposure
- Privilege misuse risk
- Monitoring visibility

Testing confirmed that user-controlled content can be rendered in a way that allows script execution within the trusted application origin.

This finding has implications beyond client-side behavior and impacts overall request integrity guarantees.

Remediation will be implemented in LD-02.

---

### 2. Assessment Scope

| Item | Description |
|------|------------|
| Application | JSP / Servlet-based web application |
| Rendering Layer | JSP dynamic content output |
| Data Source | Database-stored user-generated content |
| Session Model | Cookie-based session (JSESSIONID) |
| CSRF Controls | Not implemented |
| CSP | Not implemented |

---

### 3. Validation Activity

A controlled test was conducted to determine whether user-supplied content could result in client-side script execution.

Test payload inserted into user content:

```html
<script>alert("test")</script>
```

The content was stored in the database and rendered through a JSP page responsible for displaying chat messages.

---

### 4. Observed Behavior

Upon page load:

- The script executed in the browser.
- No output encoding was applied.
- The content was interpreted as executable JavaScript.

This confirms that malicious script execution is currently possible within the trusted origin.

Testing was limited strictly to execution validation.
No data extraction or privilege abuse was performed.

---

### 5. Root Cause Analysis

The affected JSP page renders database content directly:

```jsp
${chatContent}
```

Because no output encoding mechanism is applied:

- HTML is interpreted as markup
- JavaScript executes
- The browser treats stored content as trusted code

The absence of presentation-layer encoding allows execution within the application origin.

---

### 6. Security Impact Assessment

Malicious script execution has broader architectural implications.

#### 6.1 Request Integrity Degradation

The application assumes:

> Authenticated session = intentional user request

However, if script execution occurs within the origin:

- Authenticated POST requests can be programmatically triggered
- State-changing endpoints can be invoked
- Business logic flows can be manipulated

Authentication does not guarantee user intent.

---

#### 6.2 CSRF Exposure Amplification

CSRF relies on browser session behavior.

If malicious script executes within the trusted origin:

- The browser automatically attaches session cookies
- Requests appear legitimate
- Origin validation remains valid

Therefore, malicious script execution increases exposure to CSRF-style request forgery.

This does not imply automatic compromise,
but it significantly weakens request authenticity controls.

---

#### 6.3 Privilege Misuse Risk

If higher-privileged users view injected content:

- Elevated endpoints may be invoked
- Administrative functions may be triggered
- Workflow integrity may degrade

Impact severity depends on privilege level.

---

#### 6.4 Detection Visibility Gap

Example access log entry:

```log
127.0.0.1 - - [14/Feb/2026:11:03:42 +0900] "POST /used-auction-platform/controller?cmd=addChatAction HTTP/1.1" 200 512
```

Limitations:

- No indication of script-triggered activity
- No payload inspection
- No intent validation logging
- No anomaly detection

From a SOC perspective, malicious script-triggered requests are indistinguishable from legitimate traffic.

---

### 7. Architectural Observation

Current security posture reflects:

- Over-reliance on client-side trust
- Lack of output encoding enforcement
- Absence of browser-level controls (CSP)
- No structured security telemetry

The trust boundary between rendered content and executable context is insufficiently enforced.

---

### 8. Risk Evaluation

| Risk Category | Likelihood | Impact | Risk Level |
|--------------|-----------|--------|------------|
| Malicious Script Execution | Medium | High | High |
| Request Integrity Breakdown | Medium | High | High |
| CSRF Exposure Increase | Medium | Medium–High | Medium–High |
| Monitoring Blind Spot | High | Medium | High |

Risk prioritization indicates remediation is required.

---

### 9. Planned Hardening (AS-03)

The following controls are planned:

- Context-aware output encoding
- Content Security Policy (CSP)
- CSRF protection mechanisms
- SameSite cookie configuration
- Structured security logging

Implementation and validation results will be documented in AS-03.

---

### 10. Conclusion

This assessment confirms that malicious script execution is currently possible within the application.

The impact extends beyond client-side behavior and affects:

- Request authenticity
- CSRF exposure
- Privilege integrity
- Monitoring visibility

Preventing malicious script execution is foundational to maintaining trustworthy authenticated interactions.

Hardening efforts will follow in the next phase.

---
