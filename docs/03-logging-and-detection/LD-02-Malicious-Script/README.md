# LD-02-Malicious-Script
## Request Integrity Hardening & CSRF Behavioral Detection Architecture

---

# 1. Background

> This project was implemented and validated within a controlled local laboratory environment, designed to simulate production-grade threat conditions and architectural decision-making.

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

# 2. Threat Model

## 2.1 Assumed Adversary Capabilities

The adversary is assumed to:

- Craft arbitrary HTTP requests
- Host malicious external HTML pages
- Induce authenticated user interaction
- Replay or automate request attempts
- Manipulate client-side input

Server-side compromise is not assumed.

## 2.2 Trust Boundaries

Identified trust boundaries:

- Client Browser ↔ Web Application
- Application Layer ↔ Session Store
- Application Logs ↔ SIEM Pipeline

Security controls are enforced at the first trust boundary (Servlet Filter layer).

## 2.3 Primary Attack Scenarios

1. Cross-Site Request Forgery (CSRF)
2. Stored Script Injection (XSS)
3. Automated CSRF retry abuse
4. Session riding attempts

---

# 3. Security Objectives

| Objective | Architectural Meaning |
|------------|-----------------------|
| Output Integrity | User content must never execute as active script |
| Request Authenticity | State-changing requests must prove user intent |
| Session Boundary Enforcement | Browser context must not be implicitly trusted |
| Behavioral Detection | Abuse attempts must be observable even if blocked |
| SIEM Integration | Detection must feed structured telemetry into Wazuh |

---

# 4. Hardened Architecture Overview

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

# 5. Output Encoding Enforcement

## 5.1 Vulnerable Pattern

```jsp
${chatContent}
```

User-generated content was rendered directly into HTML context,
allowing stored script execution.

---

## 5.2 Implemented Control

```jsp
<c:out value="${chatContent}" />
```

Security effect:

- HTML entities escaped
- `<script>` rendered inert
- Stored content treated strictly as data

---

## 5.3 Validation

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

# 6. CSRF Enforcement Architecture

## 6.1 Core Design

CSRF protection implemented via:

- Custom Servlet Filter
- Session-bound token model
- Behavioral risk scoring
- Structured security logging
- Automatic escalation threshold

---

## 6.2 Enforcement Scope

Validated HTTP Methods:

- POST
- PUT
- DELETE

GET requests:

- Used to initialize CSRF token
- Not permitted to mutate state

This preserves HTTP semantic correctness.

---

# 7. CSRF Token Model

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

# 8. CSRF Filter Implementation

## 8.1 Core Validation Logic

```java
private String validateToken(String sessionToken, String requestToken) {
    if (sessionToken == null) return "SESSION_TOKEN_MISSING";
    if (requestToken == null) return "REQUEST_TOKEN_MISSING";
    if (!sessionToken.equals(requestToken)) return "TOKEN_MISMATCH";
    return null;
}
```

---

## 8.2 Risk Scoring Model (Implemented)

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

## 8.3 Structured Security Logging

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

# 9. Wazuh Integration

## 9.1 Custom Decoder

```xml
<decoder name="csrf-block">
    <prematch>CSRF_BLOCK</prematch>
</decoder>

<decoder name="csrf-block-fields">
    <parent>csrf-block</parent>
    <regex offset="after_parent">
        ip=([^ ]+) user=([^ ]+) sid=([^ ]+) method=([^ ]+) uri="([^"]+)" reason=([^ ]+) csrf_fail_count=(\d+) csrf_risk_score=(\d+) csrf_risk_level=([^ ]+) referer="([^"]*)"
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

## 9.2 Rule Escalation Hierarchy

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

# 10. SameSite Cookie Consideration

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

# 11. Security Impact

| Capability | Before | After |
|-------------|---------|--------|
| Stored Script Execution | Possible | Prevented |
| CSRF Protection | None | Token-Enforced |
| Behavioral Detection | None | Risk-Scored |
| Session Abuse Escalation | None | Threshold-Based |
| SIEM Visibility | None | Structured Telemetry |

---

# 12. Architectural Advancement

System evolution:

From:
- Implicit browser trust
- Infrastructure-only logging

To:
- Verified request authenticity
- Application-layer detection telemetry
- Risk-based enforcement

---

# 13. Deployment Context, Limitations & Security Roadmap

## 13.1 Deployment Context

This project was implemented and executed within a controlled local laboratory environment using Apache Tomcat 8.0.30.

The purpose of this deployment model was to simulate production-grade security architecture decisions without relying on external infrastructure components such as reverse proxies, WAFs, or managed cloud security services.

Although deployed locally, all security controls were designed under real-world threat assumptions, including:

- Untrusted client input
- Session hijacking attempts
- Cross-site request forgery
- Stored script execution vectors
- Abuse pattern accumulation

Architectural decisions reflect production-oriented boundary enforcement principles rather than development-only safeguards.

---

## 13.2 Current Limitations

The current implementation intentionally excludes several advanced browser-level and infrastructure-level controls due to environment constraints.

Identified limitations:

- No Content Security Policy (CSP) enforcement
- No SameSite cookie attribute support (Tomcat 8.0.30 limitation)
- No Web Application Firewall (WAF) integration
- No automated Active Response execution
- Static (non-adaptive) risk scoring model
- No anomaly-based behavioral baseline per user/IP

These limitations do not invalidate the integrity model but define the boundary of the current phase.

---

## 13.3 Phase 2 Security Hardening Roadmap

The architecture is intentionally designed to evolve toward stricter client-side and infrastructure-integrated enforcement.

Planned improvements:

### 1. Content Security Policy (CSP) Enforcement

- Initial deployment in `Content-Security-Policy-Report-Only` mode
- Collection of violation telemetry
- Transition to enforced mode with:

  default-src 'self';
  script-src 'self';
  object-src 'none';
  base-uri 'self';
  frame-ancestors 'none';

- Future extension to nonce-based strict CSP for inline script control

CSP will function as a browser-level execution control layer, providing defense-in-depth against residual or future XSS vectors.

---

### 2. SameSite Cookie Enforcement

Upon environment upgrade:

- Migration to Tomcat version supporting SameSite configuration
- Enforce SameSite=Lax or Strict depending on endpoint classification
- Evaluate reverse proxy header rewriting if required

---

### 3. Adaptive Risk Scoring Model

Enhancements:

- Sliding time window analysis
- Per-session anomaly baseline
- IP reputation weighting
- Progressive penalty escalation
- Risk decay mechanism

This transforms the current static model into a behavior-aware anomaly detection mechanism.

---

### 4. Active Response Automation

Planned integration:

- Wazuh Active Response scripting
- Temporary IP blocking for high-risk threshold breach
- Session quarantine mode
- Alert enrichment for SOC workflows

---

## 13.4 Architectural Intent

The system is intentionally structured to:

- Enforce validation at trust boundaries
- Separate detection from enforcement
- Produce structured telemetry for SIEM ingestion
- Support progressive security maturation

The current phase establishes integrity and observability foundations.

Future phases extend enforcement depth and automation without redesigning the core trust model.

---

# 14. Conclusion

LD-02 establishes:

- Output integrity guarantees
- Request authenticity validation
- Behavioral risk-based enforcement
- Structured SIEM telemetry pipeline

The system transitions from passive vulnerability mitigation
to active abuse detection architecture.
