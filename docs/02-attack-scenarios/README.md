# 02 — Attack Scenarios

## 1. Overview

This section documents controlled security testing scenarios conducted against the legacy Java web application environment introduced in `01-environment-setup`.

The purpose of these scenarios is not to demonstrate successful exploitation, but to evaluate the security posture, monitoring visibility, and incident detection readiness of the application under realistic attack conditions.

Each scenario examines how the system behaves when exposed to malicious input and whether existing logging and monitoring mechanisms provide sufficient visibility for Security Operations Center (SOC) analysis.

The findings from these scenarios directly inform the improvements implemented in ```03-logging-and-detection/```.

---

## 2. Security Assessment Objectives

The attack scenarios were designed to evaluate the following areas:

| Objective | Description |
|---|---|
| Input Handling | Determine whether malicious input can reach sensitive execution paths |
| Secure Coding Validation | Verify effectiveness of defensive coding practices |
| Detection Visibility | Assess whether attacks can be identified through available logs |
| Monitoring Adequacy | Evaluate whether existing logs provide sufficient forensic context |
| SOC Readiness | Determine whether attacks can be distinguished from normal user behavior |

The focus of this phase is security observability, not only exploitability.

---

## 3. Attack Scenario Catalogue

The following scenarios were executed in a controlled laboratory environment.

### AS-01 — SQL Injection Attempt and Detection Gap Analysis

Directory:```AS-01-SQL-Injection-Detection/```


Description:

Evaluation of SQL Injection attack attempts against the authentication endpoint.

Key observations:

- Parameterized queries prevented exploitation.
- Authentication bypass was not possible.
- Existing logs lacked sufficient detail to identify SQL Injection attempts.

Primary focus:

- Detection gap analysis
- Logging adequacy assessment
- SOC visibility limitations

Documentation:```AS-01-SQL-Injection-Detection/README.md```

---

### AS-02 — Malicious Script Execution and Request Integrity Compromise Assessment

Directory:```AS-02-Malicious-Script-Execution-Impact-Analysis/```


Description:

Assessment of client-side malicious script execution resulting from missing output encoding in JSP rendering.

Key observations:

- User-controlled content can execute JavaScript within the trusted origin.
- Script execution enables authenticated request automation.
- Browser-origin trust assumptions are weakened.

Primary focus:

- Request integrity analysis
- browser trust boundary evaluation
- monitoring and detection limitations

Documentation:```AS-02-Malicious-Script-Execution-Impact-Analysis/README.md```


---

## 4. Environment Context

All scenarios were executed within a controlled local environment.

| Component | Description |
|---|---|
| Application | Legacy JSP / Servlet web application |
| Application Server | Apache Tomcat 8.0.30 |
| Database | Oracle XE (Docker) |
| Architecture | Front Controller (Action-based routing) |
| Logging | Tomcat access logs and application logs |
| Security Telemetry | Minimal |

The environment intentionally reflects characteristics commonly found in legacy enterprise web systems.

---

## 5. Key Observations

The attack scenario analysis revealed several systemic issues.

| Area | Observation |
|---|---|
| Secure Coding | Some defensive controls exist (e.g., parameterized queries) |
| Monitoring | Logs lack sufficient security context |
| Detection | Attack classification is not possible using existing telemetry |
| Observability | Security-relevant events are not centrally aggregated |

Even when exploitation is prevented, the absence of structured security logging significantly reduces detection capability.

---

## 6. MITRE ATT&CK Mapping

The evaluated scenarios correspond to the following adversarial techniques.

| Scenario | Technique | ATT&CK ID |
|---|---|---|
| SQL Injection Attempt | Exploit Public-Facing Application | T1190 |
| Malicious Script Execution | Cross-Site Scripting | T1059.007 |

These techniques commonly appear during early phases of web application intrusion attempts.

---

## 7. Detection and Monitoring Implications

A key finding from these scenarios is that preventive controls alone are insufficient for effective security operations.

Even when attacks fail:

- Malicious activity may still indicate reconnaissance or probing behavior.
- Early-stage attacks provide valuable threat intelligence signals.
- Lack of visibility prevents timely detection.

Improving detection capability requires:

- application-level security logging
- centralized log aggregation
- rule-based monitoring
- behavioral correlation

---

## 8. Transition to Detection Engineering

Based on the detection gaps identified during the attack scenarios, the next phase of this project introduces:

- structured security logging
- centralized log collection
- SIEM-based detection rules
- attack pattern monitoring

These improvements are implemented in:```03-logging-and-detection/```

---

## 9. Conclusion

The attack scenarios demonstrate that security resilience involves more than preventing exploitation.

Even when secure coding practices successfully block attacks, insufficient monitoring visibility can leave organizations operationally blind to malicious activity.

The findings from this phase highlight the need for stronger security telemetry, centralized monitoring, and detection engineering, which are addressed in the subsequent project phase.
