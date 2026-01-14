# AS-01: SQL Injection Attempt and Detection Gap Analysis

## 1. Overview

This document describes an attempted SQL Injection (SQLi) attack against a legacy Java web application implemented using JSP and Servlet architecture.

The attack was unsuccessful due to the application’s use of parameterized SQL queries.  
However, the analysis identified a significant operational issue: from a SOC perspective, existing log sources did not provide sufficient information to distinguish SQL Injection attempts from normal authentication failures.

The purpose of this scenario is to evaluate detection visibility, logging adequacy, and incident response readiness rather than exploitation success.

---

## 2. Environment

| Component | Description |
|---------|-------------|
| Application | Legacy Java Web Application (JSP / Servlet) |
| Application Server | Apache Tomcat 8.0.30 |
| Database | Oracle XE (Docker-based) |
| Architecture | Front Controller with Action-based routing |
| Log Sources | Tomcat Access Log, Tomcat Application Log (Catalina) |

---

## 3. Threat Model

### 3.1 Threat Actor

- External, unauthenticated user
- Direct access to public-facing endpoints

### 3.2 Target Asset

Authentication endpoint:


```log
POST /controller?cmd=loginAction
```
User-controlled input parameters (user ID and password) are processed by the backend authentication logic.

### 3.3 Considered Attack Scenarios

| Scenario | Description |
|---------|-------------|
| SQL Injection | Authentication bypass attempt |
| Brute Force | Repeated login attempts using multiple credentials |
| Credential Stuffing | Automated login attempts using leaked credentials |

Without additional context, these scenarios are indistinguishable based on basic access logs alone.

---

## 4. Attack Attempt

A manual SQL Injection payload was submitted through the login form to test authentication bypass behavior.

Payload used during testing:

```log
' OR '1'='1


### Result

| Item                    | Outcome      |
| ----------------------- | ------------ |
| Authentication bypass   | Failed       |
| SQL error exposure      | Not observed |
| Application instability | Not observed |

The backend authentication logic utilizes parameterized queries (PreparedStatement), which prevents classic SQL Injection exploitation.

---

## 5. Evidence Collected 

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

-HTTP method, endpoint, and response status are recorded
-Request parameters are not logged
-Authentication failure reasons are not recorded
-No SQL-related error or anomaly information is available

The collected logs provide basic operational data but lack the security context required for attack identification.

---

## 6. Detection Gap Analysis

Although an SQL Injection attempt was performed, none of the available log sources allowed reliable identification of the activity as SQL Injection.

### Identified Detection Gaps

- Web access logs do not capture user input or payload patterns
- Application logs do not record authentication failure reasons
- Database-side SQL errors are not logged or correlated
- No detection rules or alerting thresholds are defined

### Impact on SOC Operations

| Area                    | Impact                                                          |
| ----------------------- | --------------------------------------------------------------- |
| Detection Accuracy      | Malicious and benign authentication failures appear identical   |
| Incident Classification | SQL Injection cannot be distinguished from brute-force attempts |
| Response Efficiency     | Manual investigation required                                   |
| Risk Exposure           | Early-stage attacks may go unnoticed                            |


From a SOC perspective, the system is technically secure but lacks sufficient monitoring visibility.

---

## 7. Logging & Detection Design (Improvement Plan)

### 7.1 Application-Level Security Logging

Design structured security logs for authentication-related events, including:

- Timestamp
- Source IP address
- Target endpoint
- Authentication result (success / failure)
- Failure category (generic, non-sensitive)

Example (conceptual):
```log
AUTH_FAIL | ip=127.0.0.1 | endpoint=/controller | reason=INVALID_CREDENTIAL
```

Sensitive information such as passwords or raw input values must not be logged.

---

### 7.2 Database Log Correlation

- Enable Oracle XE SQL error logging
- Capture abnormal SQL execution behavior
- Correlate database anomalies with repeated authentication failures

The objective is to improve confidence in attack classification through multi-layer correlation.

---

### 7.3 SIEM Integration
-Centralize application, access, and database logs using a SIEM platform (ELK Stack or Wazuh)
-Implement rule-based detection for:
  -Repeated authentication failures from a single source
  -Suspicious input patterns
  -Temporal correlation between authentication failures and database errors
  
Detailed implementation is documented in **`03-logging-and-detection/`**.

---

## 8. Incident Response Consideration

With enhanced detection and alerting, the following response workflow becomes feasible:

1. Automatic alert generation
2. SOC analyst triage
3. Attack type classification (SQL Injection vs brute force)
4. IP reputation analysis
5. Temporary blocking or rate-limiting
6. Incident documentation and escalation

**Detection maturity directly enables effective incident response.**

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

This scenario demonstrates that a system can be resistant to SQL Injection while still being operationally blind from a monitoring standpoint.

Effective security requires not only preventive controls, but also adequate visibility to support detection and incident response activities.

