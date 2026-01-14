# AS-01 — SQL Injection Attempt & Detection Gap Analysis

> **Category**: Web Application Security  
> **Focus**: SQL Injection Attempt, Detection Failure, SOC Visibility  
> **Target Role**: SOC Analyst / CERT (CSIRT)

---

## 1. Overview

This scenario documents an **attempted SQL Injection (SQLi)** attack against a legacy Java web application built using **JSP / Servlet architecture**.

Although the attack itself was **unsuccessful** due to the use of **parameterized SQL queries**, the analysis revealed a **critical detection gap** from a SOC perspective:

> 🔴 *The SOC could not reliably distinguish SQL Injection attempts from normal authentication failures using existing logs.*

This scenario focuses on **detection, logging design, and incident response readiness**, rather than exploitation success.

---

## 2. Environment

| Component | Details |
|---------|--------|
| Application | Legacy Java Web App (JSP / Servlet) |
| App Server | Apache Tomcat 8.0.30 |
| Database | Oracle XE (Docker-based) |
| Architecture | Front Controller + Action Pattern |
| Logging | Tomcat Access Log, Catalina Log |

---

## 3. Threat Model

### 3.1 Threat Actor
- External, unauthenticated attacker
- Internet-facing access

### 3.2 Target Asset
- **Authentication endpoint**
POST /controller?cmd=loginAction

- User-controlled input (ID / Password)

### 3.3 Possible Attack Scenarios

| Attack Type | Description |
|------------|------------|
| SQL Injection | Authentication bypass attempt |
| Brute Force | Repeated login attempts |
| Credential Stuffing | Automated credential reuse |

⚠️ Without enhanced logging, these scenarios appear **identical** from a SOC viewpoint.

---

## 4. Attack Attempt

A manual SQL Injection payload was submitted through the login form.

**Payload example:**
```log
' OR '1'='1
```

### Result

| Item | Outcome |
|----|----|
| Authentication bypass | ❌ Failed |
| SQL error exposure | ❌ None |
| Server crash | ❌ None |

📌 The application uses **PreparedStatement**, effectively preventing classic SQL Injection.

---

## 5. Evidence Collected (Raw Logs)

### 5.1 Tomcat Access Log

```log
127.0.0.1 - - [14/Jan/2026:02:09:50 +0900]
"POST /used-auction-platform/controller?cmd=loginAction HTTP/1.1" 302 -
```
## 5.2 Application Log (Catalina)

```log
INFO [localhost-startStop-2]
org.apache.catalina.core.ApplicationContext.log
SessionListener: contextDestroyed()
```
### Observations

- ✔ Request method and endpoint are recorded
- ✔ HTTP status code is visible
- ❌ Request parameters are not logged
- ❌ No distinction between normal login failure and malicious input
- ❌ No SQL-related error or anomaly indicators

📌 **Observation Summary**:  
The existing logs provide **operational visibility**, but lack **security context** required for attack detection.

---

## 6. Detection Gap Analysis

Despite an actual SQL Injection attempt being performed during testing:

> ❗ **No available log source could reliably identify the activity as SQL Injection.**

### Identified Detection Gaps

- Web access logs do not capture user input or payload patterns
- Application logs do not record authentication failure reasons
- Database-side SQL errors are not logged or correlated
- No detection rules or alerting thresholds are defined

### SOC Impact Assessment

| Impact Area | Description |
|------------|-------------|
| Detection Accuracy | SQLi attempts indistinguishable from benign failures |
| Response Speed | Manual analysis required |
| Incident Classification | High uncertainty (SQLi vs brute force) |
| Operational Risk | Potential missed early-stage attacks |

📉 **Conclusion**:  
From a SOC perspective, the system is **functionally secure but operationally blind**.

---

## 7. Logging & Detection Design (Improvement Plan)

### 7.1 Application-Level Security Logging

Design structured security logs for authentication-related events, including:

- Timestamp
- Source IP address
- Target endpoint
- Authentication result (success / failure)
- Failure category (generic, non-sensitive)

**Conceptual Example:**
AUTH_FAIL | ip=127.0.0.1 | endpoint=/controller | reason=INVALID_CREDENTIAL


⚠️ Sensitive information such as passwords or raw input values must **never** be logged.

---

### 7.2 Database Log Correlation

- Enable Oracle XE SQL error logging
- Capture abnormal SQL execution behavior
- Correlate database anomalies with repeated authentication failures

🎯 **Objective**:  
Improve confidence in attack classification by correlating frontend and backend signals.

---

### 7.3 SIEM Integration (Planned)

| Component | Design Decision |
|---------|-----------------|
| SIEM Platform | ELK Stack or Wazuh |
| Log Ingestion | Agent-based collection |
| Detection Method | Rule-based correlation |
| Alerting | Dashboard + notification |

#### Example Detection Logic

- Multiple authentication failures from a single IP within a short time window
- Login attempts associated with SQL meta-character patterns
- Authentication failures temporally aligned with database SQL errors

📁 Detailed implementation is documented in **`03-logging-and-detection/`**.

---

## 8. Incident Response Consideration (CERT Perspective)

With enhanced detection and alerting, the following response workflow becomes feasible:

1. Automatic alert generation
2. SOC analyst triage
3. Attack type classification (SQL Injection vs brute force)
4. IP reputation analysis
5. Temporary blocking or rate-limiting
6. Incident documentation and escalation

🛡️ **Detection maturity directly enables effective incident response.**

---

## 9. Lessons Learned

- Secure coding practices alone are insufficient for SOC operations
- Detection visibility is a foundational security control
- Logging must be designed with incident classification in mind
- SQL Injection defense should be evaluated from both:
  - Developer perspective
  - SOC / CERT perspective

---

## 10. Conclusion

> **A secure application can still be operationally blind.**

This scenario demonstrates how inadequate logging and correlation prevent SOC teams from identifying malicious behavior, even when attacks fail technically.

---

### ✔ Key Takeaway

**Effective security requires both prevention and detection.**
