## Detection Evidence Criteria

This section defines the evidence required to demonstrate
that logging, detection, and alerting mechanisms
were implemented and validated by the author.

The purpose of the evidence is not visual appeal,
but verifiability and technical credibility.

---

## 1. Evidence Objectives

The evidence must demonstrate the following:

- The application generates security-relevant authentication logs
- These logs are collected by Wazuh
- Detection rules are triggered based on defined conditions
- Alerts are generated as a result of observed behavior

Each evidence item is mapped to a specific detection stage
to ensure traceability.

---

## 2. Evidence Categories

### 2.1 Application-Level Evidence

**Objective:**  
Demonstrate that the application itself emits structured security logs.

**Required Evidence:**

- Screenshot of modified authentication logging code
- Screenshot or raw output showing authentication failure logs
- Timestamp visible in log entries

**Acceptance Criteria:**

- Log entries clearly indicate authentication result
- No sensitive information (passwords, raw payloads) is present
- Log format is consistent and machine-parseable

---

### 2.2 Log Collection Evidence (Wazuh Agent)

**Objective:**  
Demonstrate that application logs are successfully ingested by Wazuh.

**Required Evidence:**

- Screenshot of Wazuh Agent configuration monitoring the log file
- Screenshot showing log events appearing in Wazuh Manager
- Matching timestamps between application logs and Wazuh ingestion

**Acceptance Criteria:**

- Authentication events are visible in Wazuh
- Source IP and event time are preserved
- No manual log injection or simulation is used

---

### 2.3 Detection Evidence (Rule Trigger)

**Objective:**  
Demonstrate that defined detection logic produces alerts.

**Required Evidence:**

- Screenshot of Wazuh alert triggered by authentication failures
- Alert details showing:
  - Rule ID
  - Trigger condition
  - Source IP
  - Event count or frequency

**Acceptance Criteria:**

- Alert is generated automatically
- Alert corresponds to real authentication events
- Alert is not manually forced or edited

---

### 2.4 Correlation Evidence

**Objective:**  
Demonstrate correlation between application behavior and detection output.

**Required Evidence:**

- Side-by-side evidence of:
  - Application authentication logs
  - Corresponding Wazuh alert
- Consistent timestamps and source IPs

**Acceptance Criteria:**

- Clear linkage between cause (authentication failures)
  and effect (alert generation)
- No ambiguity in event origin or sequence

---

## 3. Evidence Storage Structure

All evidence is stored under the following directory:
03-logging-and-detection/
- detection-evidence/
- application-logs/
- wazuh-agent/
- wazuh-alerts/
- correlation/

Each file name includes:

- Scenario ID (AS-01)
- Evidence type
- Date

Example: PICTURE AS-01-auth-fail-log-2026-01-14.png

---

## 4. Evidence Integrity Notes

- All screenshots are captured from the author’s local environment
- No stock images or sample logs are used
- Timestamps are preserved without modification
- Logs are generated through actual user interaction

This ensures the evidence represents real operational behavior
rather than hypothetical or simulated output.



