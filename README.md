# Web Application Security Detection Engineering Project

## Overview

This project demonstrates a practical security engineering workflow for a legacy Java web application environment.

The objective of the project is to simulate realistic web application attacks, analyze detection gaps, and implement detection mechanisms capable of generating actionable security telemetry for Security Operations Center (SOC) monitoring.

The project progresses through the following stages:

1. Environment setup
2. Attack scenario execution
3. Detection engineering and SIEM integration
4. Incident response strategy design
5. Security lessons learned

Rather than focusing solely on exploitation success, this project emphasizes security observability, detection engineering, and operational response capability.

All testing activities were conducted in a controlled local laboratory environment using a self-hosted application.

---

# Security Architecture

The project implements an application-aware detection pipeline integrated with SIEM.
```
User Request
↓
Web Application (JSP / Servlet)
↓
Application Security Logging
↓
Tomcat Log Files
↓
Wazuh Agent
↓
Wazuh Manager
↓
Decoders → Detection Rules
↓
Security Alerts
```

This architecture allows the application to emit structured security telemetry that can be parsed and correlated by the SIEM platform.

---

# Project Structure
```
.
├ WebContent
├ src
├ docs
│
│ ├ 01-environment-setup
│ │
│ ├ 02-attack-scenarios
│ │ ├ AS-01-SQL-Injection-Detection
│ │ └ AS-02-Malicious-Script-Execution-Impact-Analysis
│ │
│ ├ 03-logging-and-detection
│ │ ├ LD-01-sqli
│ │ └ LD-02-Malicious-Script
│ │
│ ├ 04-automated-incident-containment-strategy
│ │
│ └ 05-lessons-learned
│
├ .gitignore
├ .classpath
├ .project
└ README.md
```

The repository contains both the web application source code and the security analysis documentation used to evaluate and improve the system.

---

# Environment

| Component | Description |
|---|---|
| Language | Java |
| Framework | JSP / Servlet |
| Application Server | Apache Tomcat 8.0.30 |
| Database | Oracle XE (Docker) |
| SIEM | Wazuh |
| Logging | Application-level structured security logs |

The environment simulates characteristics commonly found in legacy enterprise web systems.

---

# Attack Scenarios

Attack simulations were performed against the web application to evaluate security visibility and detection readiness.

### AS-01 — SQL Injection Attempt and Detection Gap Analysis

Focus:

- SQL Injection attempt against authentication endpoint
- evaluation of logging visibility
- analysis of detection capability

Key finding:

Although parameterized queries prevented exploitation, existing logs did not provide sufficient information to distinguish SQL Injection attempts from normal login failures.

---

### AS-02 — Malicious Script Execution and Request Integrity Assessment

Focus:

- stored script execution caused by missing output encoding
- browser trust boundary analysis
- request authenticity implications

Key finding:

Client-side script execution within the trusted origin can compromise request integrity and undermine assumptions about authenticated user actions.

---

# Detection Engineering

The project introduces structured security logging and SIEM-based detection mechanisms to address the visibility gaps identified during the attack scenarios.

### LD-01 — Application-Aware Authentication Abuse Detection

Key capabilities:

- structured authentication security logs
- detection of brute-force login attempts
- SQL Injection pattern recognition
- Wazuh rule-based alert escalation

Example security log:```AUTH_FAIL ip=127.0.0.1 auth_level=HIGH suspicious_pattern=true```

---

### LD-02 — Request Integrity Hardening & CSRF Detection

Security improvements implemented:

- output encoding enforcement
- CSRF token validation
- request boundary enforcement using Servlet Filter
- behavioral risk scoring
- structured security telemetry

These controls transform the system from passive input validation to **behavior-aware request protection**.

---

# MITRE ATT&CK Mapping

Observed attack behaviors and detection mechanisms align with the following MITRE ATT&CK techniques.

| Technique | Description | ATT&CK ID |
|---|---|---|
| Exploit Public-Facing Application | SQL Injection probing | T1190 |
| Brute Force | Credential guessing | T1110 |
| Cross-Site Scripting | Script execution | T1059.007 |
| Browser Session Abuse | CSRF | T1185 |

This mapping enables security events to be categorized within a structured threat framework.

---

# Incident Response Strategy

The project also explores automated containment strategies to support SOC response workflows.

Examples include:

- IP-based attack source identification
- automated blocking policies
- behavioral threshold-based response triggers
- alert prioritization for analyst triage

These strategies are documented in:```docs/04-automated-incident-containment-strategy```

---

# Security Lessons Learned

This section summarizes the architectural and operational insights obtained during the security testing and detection engineering process.

The analysis focuses on several key areas:

- limitations of infrastructure-only logging
- advantages of application-aware detection
- security telemetry design principles
- detection engineering trade-offs

These lessons highlight how security visibility can be significantly improved by integrating application-level telemetry with SIEM-based monitoring.

Documentation is available in:```docs/05-lessons-learned```

---

# Key Security Capabilities Demonstrated

This project demonstrates several practical security engineering capabilities:

- web application attack simulation
- detection gap analysis
- structured security logging design
- SIEM integration (Wazuh)
- behavioral detection engineering
- CSRF protection architecture
- request integrity enforcement
- MITRE ATT&CK threat mapping

---

# Security Disclaimer

All testing activities in this repository were conducted within a controlled local laboratory environment.

The attacks described in this project were performed exclusively against a self-hosted test application owned by the project author.

No external systems or third-party infrastructure were targeted.

The content of this repository is intended solely for educational and defensive security research purposes.
