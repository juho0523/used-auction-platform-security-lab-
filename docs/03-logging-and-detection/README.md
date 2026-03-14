# 03 — Logging and Detection Engineering

## 1. Overview

This section introduces the detection engineering phase of the project.

The attack scenarios documented in `02-attack-scenarios/` demonstrated that
even when exploitation attempts fail due to secure coding practices,
the system may still lack sufficient visibility to detect malicious behavior.

The objective of this phase is to address those detection gaps by introducing:

- structured security logging
- application-aware telemetry
- SIEM-based correlation and alerting
- behavioral detection logic

Rather than relying solely on infrastructure logs (e.g., access logs),
this phase shifts part of the detection logic closer to the application layer,
where semantic context about security events is available.

All detection mechanisms are integrated with Wazuh SIEM
to enable centralized monitoring and alert generation.

---

## 2. Detection Engineering Objectives

The detection architecture introduced in this phase focuses on the following goals.

| Objective | Description |
|---|---|
| Security Telemetry | Generate structured logs containing security-relevant context |
| Detection Visibility | Ensure malicious behavior is observable even when attacks fail |
| Behavioral Classification | Identify abnormal authentication or request patterns |
| SIEM Integration | Enable rule-based correlation and alert escalation |
| SOC Readiness | Provide actionable signals for analyst triage |

The focus is on security observability and operational detection maturity.

---

## 3. Detection Architecture

The detection pipeline implemented in this phase follows a structured telemetry flow.
```
Application Security Event
↓
Structured Security Logging
↓
Tomcat Application Logs
↓
Wazuh Agent (Log Collection)
↓
Wazuh Manager
↓
Custom Decoders
↓
Detection Rules
↓
Security Alerts
```

This pipeline allows application-generated security events
to be parsed, correlated, and escalated by the SIEM platform.

---

## 4. Detection Scenario Catalogue

Two detection engineering implementations were developed
to address the weaknesses identified during the attack scenario phase.

---

### LD-01 — Application-Aware Logging & Authentication Abuse Detection

Directory:```LD-01-sqli```


Purpose:

This scenario implements application-level security logging
for authentication events to improve detection of login abuse and SQL Injection attempts.

Key capabilities introduced:

- Structured authentication security logs
- Behavioral classification of login failures
- SQL Injection pattern identification
- SIEM-based alert escalation via Wazuh

Detection signals generated:

- Repeated authentication failures
- Brute-force behavior patterns
- SQL Injection input anomalies
- Authentication success events

Detection logic combines application-layer classification
with SIEM rule correlation.

Documentation:```LD-01-sqli/README.md```

---

### LD-02 — Request Integrity Hardening & CSRF Behavioral Detection

Directory:```LD-02-Malicious-Script```


Purpose:

This scenario introduces request authenticity enforcement
and behavioral detection mechanisms to mitigate risks identified in:

> AS-02 – Malicious Script Execution and Request Integrity Compromise Assessment

Security improvements include:

- output encoding enforcement
- CSRF token validation
- request-boundary enforcement via Servlet Filter
- risk-based abuse scoring
- structured CSRF attack telemetry

Detection capabilities introduced:

- CSRF attempt logging
- behavioral abuse scoring
- session abuse detection
- SIEM alert escalation

Structured telemetry enables SOC teams
to observe blocked abuse attempts as security signals.

Documentation:```LD-02-Malicious-Script/README.md```

---

## 5. Key Detection Improvements

The logging and detection phase significantly improves
the observability of application-layer attacks.

| Capability | Before | After |
|---|---|---|
| Authentication abuse detection | Not observable | Behavioral detection |
| SQL Injection attempt visibility | None | Structured logging |
| CSRF attack visibility | None | Risk-scored detection |
| Script injection monitoring | None | Output encoding + telemetry |
| SOC alerting capability | None | Wazuh rule-based alerts |

Security events are now observable even when attacks fail.

---

## 6. Detection Strategy

The detection approach implemented in this project
follows several key design principles.

### Application-Aware Detection

Security events are logged at points where
the application has semantic awareness of the event outcome.

Examples:

- authentication success or failure
- CSRF validation failures
- request boundary violations

This prevents SIEM rules from relying on ambiguous access logs.

---

### Structured Security Telemetry

Logs are emitted using structured key-value format.

Example:```AUTH_FAIL ip=127.0.0.1 auth_level=HIGH reason=INVALID_CREDENTIAL```


Structured logs enable deterministic parsing
and reliable rule-based detection.

---

### Behavioral Detection

Detection logic focuses on behavioral patterns rather than exploit success.

Examples:

- repeated authentication failures
- abnormal request retry patterns
- suspicious input characteristics

This allows early-stage attack detection.

---

### SIEM-Centric Correlation

The SIEM platform (Wazuh) performs:

- event parsing
- rule evaluation
- alert escalation
- MITRE ATT&CK mapping

This separates event generation from detection logic.

---

## 7. MITRE ATT&CK Mapping

The detection mechanisms implemented in this phase
cover several adversarial techniques.

| Technique | Description | ATT&CK ID |
|---|---|---|
| Exploit Public-Facing Application | SQL Injection probing | T1190 |
| Brute Force | Credential guessing attacks | T1110 |
| Cross-Site Scripting | Malicious script injection | T1059.007 |
| Browser Session Hijacking / CSRF | Request authenticity abuse | T1185 |

Mapping alerts to ATT&CK techniques
enables structured threat analysis and hunting workflows.

---

## 8. Detection Limitations

The current implementation intentionally prioritizes
clarity and reproducibility over full production architecture.

Known limitations include:

- No reverse proxy or WAF log correlation
- No automated active response enforcement
- Limited enrichment (GeoIP, User-Agent analysis)
- Detection scope limited to application telemetry

These limitations are addressed in the next project phase.

---

## 9. Transition to Automated Response

While this phase introduces reliable detection signals,
alerts currently require manual SOC analysis.

The next phase expands the system to include:

- automated response actions
- IP blocking
- abuse rate limiting
- threat intelligence enrichment

These capabilities are implemented in:```04-automated-incident-containment/```

---

## 10. Conclusion

The logging and detection phase transforms the system
from a passive application into a security-aware system capable of producing actionable telemetry.

By combining application-layer instrumentation
with SIEM-based detection logic,
the system gains the ability to identify malicious behavior
even when attacks do not succeed.

This phase establishes the foundation
for automated security response and continuous monitoring.
