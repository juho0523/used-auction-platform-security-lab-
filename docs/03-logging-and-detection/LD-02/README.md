# LD-02  
## Request Integrity Hardening & CSRF Behavioral Detection Architecture

---

# 1. Background

This project documents defensive hardening performed after identifying
request integrity weaknesses and stored script execution exposure
in assessment:

> AS-02 – Malicious Script Execution and Request Integrity Compromise Assessment

The original system had:

- No output encoding
- No CSRF validation
- No request authenticity guarantees
- No structured security telemetry

LD-02 restores architectural trust boundaries
and introduces behavior-aware detection logic.

---

# 2. Security Objectives

| Objective | Architectural Meaning |
|------------|-----------------------|
| Output Integrity | User content must never execute as active script |
| Request Authenticity | State-changing requests must prove user intent |
| Session Boundary Enforcement | Browser context must not be implicitly trusted |
| Behavioral Detection | Abuse attempts must be observable even if blocked |
| SIEM Integration | Detection must feed structured telemetry into Wazuh |

---

# 3. Hardened Architecture Overview

User Browser  
↓  
JSP Output Encoding  
↓  
**CSRF Filter (Request Boundary Enforcement)**  
↓  
Application Controllers  
↓  
Structured Security Logging  
↓  
Wazuh Agent → Manager  
↓  
Custom Decoders → Rules → Alert Escalation  

Security validation is enforced at the **Filter layer**,  
not inside business controllers, ensuring consistent coverage.

---

# 4. Output Encoding Enforcement

## 4.1 Vulnerable Pattern

```jsp
${chatContent}
```

User-generated content was rendered directly into HTML context,
allowing stored script execution.

---

## 4.2 Implemented Control

```jsp
<c:out value="${chatContent}" />
```

Security effect:

- HTML entities escaped
- `<script>` rendered inert
- Stored content treated strictly as data

---

## 4.3 Validation

### Test Payload

```html
<script>alert("test")</script>
```

### Result

- Script does not execute
- Escaped output rendered
- DOM contains no executable script element

Stored XSS vector neutralized.

---

# 5. CSRF Enforcement Architecture

## 5.1 Core Design

CSRF protection implemented via:

- Custom Servlet Filter
- Session-bound token model
- Behavioral risk scoring
- Structured security logging
- Automatic escalation threshold

---

## 5.2 Enforcement Scope

Validated HTTP Methods:

- POST
- PUT
- DELETE

GET requests:

- Used to initialize CSRF token
- Not permitted to mutate state

This preserves HTTP semantic correctness.

---

# 6. CSRF Token Model

| Property | Value |
|-----------|--------|
| Length | 256-bit random (32 bytes) |
| Generator | SecureRandom |
| Encoding | Base64 URL-safe (no padding) |
| Storage | HttpSession attribute |
| Transmission | Header `X-CSRF-Token` or parameter `csrfToken` |
| Regeneration | On new session |

Token is strictly session-bound.

---

# 7. CSRF Filter Implementation

## 7.1 Core Validation Logic

```java
private String validateToken(String sessionToken, String requestToken) {
    if (sessionToken == null) return "SESSION_TOKEN_MISSING";
    if (requestToken == null) return "REQUEST_TOKEN_MISSING";
    if (!sessionToken.equals(requestToken)) return "TOKEN_MISMATCH";
    return null;
}
```

---

## 7.2 Risk Scoring Model (Implemented)

Risk score increases per failed validation:

| Condition | Score |
|------------|--------|
| Base failure | +10 |
| External referer | +20 |
| Rapid retry (<5s) | +15 |

Escalation threshold:

```java
private static final int RISK_THRESHOLD = 50;
```

If `riskScore >= 50`:

- Session invalidated
- HTTP 403 returned
- High-severity log generated

---

## 7.3 Structured Security Logging

Example log:

```
CSRF_BLOCK 
ip=127.0.0.1 
user=zxc 
sid=8D4C4EF0D9D61116C7BC674617C7BAC8 
method=POST 
uri=/used-auction-platform/controller 
reason=REQUEST_TOKEN_MISSING 
csrf_fail_count=1 
csrf_risk_score=10 
csrf_risk_level=LOW 
referer=http://localhost:9090/
```

Security logging implemented via:

```java
securityLogger.warning(logMsg);
```

Logs are written into Catalina logs and ingested by Wazuh Agent.

---

# 8. Wazuh Integration

## 8.1 Custom Decoder

```xml
<decoder name="csrf-block">
    <prematch>CSRF_BLOCK</prematch>
</decoder>

<decoder name="csrf-block-fields">
    <parent>csrf-block</parent>
    <regex offset="after_parent">
        ip=([^ ]+) user=([^ ]+) session=([^ ]+) method=([^ ]+) uri="([^"]+)" reason=([^ ]+) csrf_fail_count=(\d+) csrf_risk_socre=(\d+) csrf_risk_level=([^ ]+) referer="([^"]*)"
    </regex>
    <order>
        user, sid, method, uri, reason, 
        csrf_fail_count, csrf_risk_score, csrf_risk_level, referer
    </order>
</decoder>
```

Decoder extracts structured fields
for rule-level severity escalation.

---

## 8.2 Rule Escalation Hierarchy

```xml
<group name="tomcat,csrf,web_attack,">

  <rule id="100600" level="7">
    <match>CSRF_BLOCK</match>
    <description>Tomcat CSRF blocked request</description>
    <group>csrf,web_attack</group>
    <mitre>
      <id>T1185</id>
    </mitre>
  </rule>

  <rule id="100602" level="14">
    <if_matched_sid>100600</if_matched_sid>
    <match>csrf_risk_level=HIGH</match>
    <description>HIGH Risk CSRF Attack - user=$(user)</description>
    <group>csrf,web_attack,high_risk</group>
    <mitre>
      <id>T1185</id>
    </mitre>
  </rule>

</group>
```

Hierarchical rule chaining reduces processing overhead
while enabling risk-based alert severity.

---

# 9. SameSite Cookie Consideration

SameSite cookie enforcement was evaluated during the hardening phase.

However, the deployed environment (Apache Tomcat 8.0.30) 
does not support native SameSite configuration via CookieProcessor.

As a result, SameSite enforcement was not implemented 
in the current deployment.

CSRF protection relies entirely on:
- Session-bound token validation
- Request boundary enforcement
- Behavioral risk escalation

Environment upgrade is required for browser-level SameSite support.

---

# 10. Security Impact

| Capability | Before | After |
|-------------|---------|--------|
| Stored Script Execution | Possible | Prevented |
| CSRF Protection | None | Token-Enforced |
| Behavioral Detection | None | Risk-Scored |
| Session Abuse Escalation | None | Threshold-Based |
| SIEM Visibility | None | Structured Telemetry |

---

# 11. Architectural Advancement

System evolution:

From:
- Implicit browser trust
- Infrastructure-only logging

To:
- Verified request authenticity
- Application-layer detection telemetry
- Risk-based enforcement

---

# 12. Known Limitations

- No CSP policy enforcement
- No WAF integration
- No Active Response automation
- Static risk scoring (non-adaptive)
- SameSite unsupported due to Tomcat version

---

# 13. Conclusion

LD-02 establishes:

- Output integrity guarantees
- Request authenticity validation
- Behavioral risk-based enforcement
- Structured SIEM telemetry pipeline

The system transitions from passive vulnerability mitigation
to active abuse detection architecture.
