# 02 — Attack Scenarios

## Overview

This document defines realistic attack scenarios against a restored legacy Java-based web application.

Rather than approaching security from a development or vulnerability-scanning perspective, this phase focuses on **attacker behavior, attack paths, and operational impact**, aligned with SOC and CERT responsibilities.

The scenarios described here serve as the foundation for later detection, logging, and incident response analysis.

---

## Objectives

The objectives of this phase are to:

- Identify realistic attack vectors applicable to legacy JSP/Servlet-based systems
- Understand how attackers interact with application-layer weaknesses
- Define observable attacker behavior suitable for SOC monitoring
- Establish a structured basis for incident response scenarios

---

## Scope and Assumptions

### Scope

- **Target System**: Legacy Java Web Application
- **Web Technology**: JSP / Servlet
- **Application Server**: Apache Tomcat 8.0.30
- **Database**: Oracle Database XE (Docker-based)
- **Attack Layer**: Application and configuration level

### Assumptions

- Attackers do not have access to source code
- No prior system or container compromise exists
- Attacks originate from unauthenticated or low-privileged users
- The system reflects a realistic legacy enterprise environment

---

## Threat Model

### Attacker Profiles

| Attacker Type | Description |
|--------------|-------------|
| External Attacker | Unauthenticated user probing exposed endpoints |
| Authenticated User | Legitimate user abusing logic or authorization flaws |
| Automated Actor | Bots performing scanning, brute-force, or enumeration |

### Target Assets

- User authentication credentials
- Session identifiers
- Auction and transaction data
- User-generated content
- Database availability and integrity

---

## Attack Surface Overview

The following architectural characteristics define the primary attack surface:

- Parameter-based command routing
- Inconsistent authorization enforcement
- Direct JDBC usage without abstraction layers
- JSP-based dynamic content rendering
- Legacy configuration and dependency management

These characteristics are commonly observed in still-operational legacy Java web systems.

---

## Attack Scenarios

### Scenario 1 — Broken Access Control via Command Parameter Manipulation

**Description**

Application behavior is controlled through request parameters (e.g., `cmd`).  
Inconsistent authorization checks may allow attackers to directly invoke restricted functions.

**Attack Flow**

1. Attacker crafts or intercepts HTTP requests
2. Command parameters are modified
3. Valid but undocumented commands are discovered
4. Restricted functionality is accessed

**Potential Impact**

- Unauthorized access
- Privilege escalation
- Business logic abuse

---

### Scenario 2 — SQL Injection in Authentication and Data Queries

**Description**

User input is directly incorporated into SQL queries via JDBC without sufficient validation or parameterization.

**Attack Flow**

1. Injection payloads are submitted through login or input fields
2. Application responses indicate abnormal behavior
3. Authentication bypass or data extraction occurs

**Potential Impact**

- Credential disclosure
- Sensitive data leakage
- Database integrity compromise

---

### Scenario 3 — Session Hijacking or Session Fixation

**Description**

Weak session management may allow attackers to reuse, predict, or fix session identifiers.

**Attack Flow**

1. Attacker obtains a valid session identifier
2. Session is reused from another context
3. Actions are executed as a legitimate user

**Potential Impact**

- Account takeover
- Unauthorized transactions
- Audit trail corruption

---

### Scenario 4 — Stored Cross-Site Scripting (XSS)

**Description**

User-generated content is stored and rendered without proper output encoding.

**Attack Flow**

1. Malicious script is injected into stored content
2. Victims access the affected page
3. Script executes in the victim’s browser

**Potential Impact**

- Session theft
- Credential harvesting
- Lateral user compromise

---

### Scenario 5 — Business Logic Abuse in Auction Workflow

**Description**

Even in the absence of technical vulnerabilities, flawed business logic can be exploited.

**Attack Flow**

1. Bids are submitted outside allowed time windows
2. Abnormal bid values or repeated submissions occur
3. Auction outcomes are manipulated

**Potential Impact**

- Financial loss
- Trust degradation
- Compliance and reputational damage

---

### Scenario 6 — Database Exposure via Container Misconfiguration

**Description**

Improper Docker port exposure or weak credentials may allow direct database access.

**Attack Flow**

1. Attacker scans exposed service ports
2. Weak or default credentials are attempted
3. Database access is obtained without application interaction

**Potential Impact**

- Complete data compromise
- Service disruption

---

## SOC / CERT Perspective

From a SOC or CERT standpoint, these scenarios emphasize:

- Detection over prevention
- Log-based anomaly identification
- Attack progression analysis
- Incident response readiness for legacy systems

---

## Next Steps

The attack scenarios defined in this document will be used to:

- Identify required log sources
- Design detection hypotheses
- Map behavior to MITRE ATT&CK techniques
- Develop incident response playbooks

These topics will be addressed in subsequent phases of this portfolio.

---

## Disclaimer

This document is intended solely for defensive security research and portfolio demonstration purposes.  
All activities are conducted in a controlled local environment.
