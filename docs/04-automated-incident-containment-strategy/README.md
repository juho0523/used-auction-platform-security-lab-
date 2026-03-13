# 04 — Automated Incident Containment Strategy  
## Wazuh-Based Brute-Force Detection and Automated Firewall Response

---

# 1. Overview

This document describes the implementation of **automated incident containment** built on top of the detection capabilities introduced in the previous phase (`03-logging-and-detection`).

The objective of this phase is to transform security monitoring into **active defensive response** by automatically blocking attacking hosts when malicious authentication behavior is detected.

Using **Wazuh SIEM**, structured **application security logging**, and a **Windows-based automated firewall response mechanism**, the system detects brute-force login attempts against the Tomcat authentication endpoint and automatically blocks the attacking source IP.

This implementation demonstrates a lightweight **Security Orchestration and Automated Response (SOAR)-like capability** without requiring dedicated SOAR infrastructure.

The architecture links:

- Application-aware authentication telemetry
- SIEM detection rules
- Host-level firewall enforcement

This enables **near real-time containment of brute-force attacks**.

---

# 2. Security Objective

The automated containment system addresses the following security goals:

| Objective | Description |
|---|---|
| Attack Detection | Identify brute-force authentication abuse |
| Automated Containment | Automatically block attacking IP addresses |
| Response Speed | Reduce detection-to-containment time |
| SOC Efficiency | Reduce repetitive manual containment actions |
| Defense-in-Depth | Combine application, SIEM, and host controls |

---

# 3. Environment

| Component | Description |
|---|---|
| Host OS | Windows 10 |
| Container Platform | Docker |
| SIEM | Wazuh 4.9.2 |
| Application Server | Apache Tomcat 8.0.30 |
| Monitoring | Wazuh Agent (Windows) |
| Log Processing | Wazuh Manager |
| Response Automation | PowerShell |
| Firewall | Windows Defender Firewall |

---

# 4. Detection Architecture

The containment system builds upon the **application-aware logging and detection pipeline** implemented in the previous phase.

```
User Request
│
▼
Apache Tomcat
│
Application Security Logs
│
▼
Wazuh Agent
│
▼
Wazuh Manager
│
Custom Decoders
│
Detection Rules
│
Alert Generation
│
alerts.json
```


Detection signals generated at the SIEM layer are consumed by an **external automated response mechanism**.

---

# 5. Detection Rules

Brute-force detection is performed by **Rule ID 100102**.

Detection logic is based on **application-side behavioral classification** (`auth_level=HIGH`), indicating that multiple authentication failures occurred within a short time window.

### Brute-Force Detection Rule

```xml
<rule id="100102" level="10">
  <if_matched_sid>100100</if_matched_sid>
  <match>auth_level=HIGH</match>
  <description>Tomcat brute-force login detected (>=5 failures in 30s)</description>
  <mitre>
    <id>T1110.001</id>
  </mitre>
  <group>authentication_failed,bruteforce,credential_access</group>
</rule>
```
When triggered, Wazuh generates a structured alert in:
```
/var/ossec/logs/alerts/alerts.json
```
This alert becomes the trigger signal for automated containment.

---

# 6. Wazuh Decoder Configuration

Structured application logs are parsed using custom decoders.

### Authentication Failure Decoder

```xml
<decoder name="tomcat-login-fail">
  <prematch>AUTH_FAIL</prematch>
  <regex>ip=(\S+) endpoint=(\S+) auth_fail_total=(\d+) auth_level=(\S+) auth_window_sec=(\d+) input_len=(\d+) input_type=(\S+) suspicious_pattern=(\S+) reason=(\S+)</regex>
  <order>srcip,endpoint,auth_fail_total,auth_level,auth_window_sec,input_len,input_type,suspicious_pattern,reason</order>
</decoder>
```

### Authentication Success Decoder

```xml
<decoder name="tomcat-login-success">
  <prematch>AUTH_SUCCESS</prematch>
  <regex>ip=(\S+) endpoint=(\S+) userType=(\S+)</regex>
  <order>srcip,endpoint,userType</order>
</decoder>
```
These decoders allow Wazuh to extract structured fields used for rule evaluation.

---

# 7. Automated Response Architecture

Unlike native Wazuh Active Response, this implementation uses an **external PowerShell monitoring script** to observe SIEM alerts and enforce containment.

Architecture overview:
```
Attacker
│
▼
Multiple Login Attempts
│
▼
Tomcat Security Logs
│
▼
Wazuh Agent → Manager
│
▼
Rule 100102 Triggered
│
▼
alerts.json
│
▼
PowerShell Monitoring Script
│
▼
Firewall Block Execution
│
▼
Windows Firewall Rule Created
```

 
This architecture provides a transparent and easily extensible automated response pipeline.

---

# 8. Automated IP Blocking Implementation

## 8.1 Alert Monitoring Script

File location:```C:\wazuh\scripts\auto-block.ps1```


PowerShell implementation:

```powershell
$containerName = "single-node-wazuh.manager-1"
$blockedIPsFile = "C:\wazuh\scripts\blocked-ips.txt"
$ruleIDToBlock = "100102"

if (-Not (Test-Path $blockedIPsFile)) {
    New-Item -Path $blockedIPsFile -ItemType File -Force
}

function Block-IP($ip) {

    if (-Not ([System.IO.File]::ReadAllText($blockedIPsFile) -match $ip)) {

        & "C:\Program Files (x86)\ossec-agent\active-response\bin\firewall-block.cmd" $ip

        Add-Content -Path $blockedIPsFile -Value $ip
    }
}

docker exec $containerName tail -F /var/ossec/logs/alerts/alerts.json | ForEach-Object {

    try {

        $alert = $_ | ConvertFrom-Json

        if ($alert.rule.id -eq $ruleIDToBlock) {

            $ip = $alert.data.srcip
            Block-IP $ip
        }

    } catch {

    }
}
```
This script performs:
1. Real-time monitoring of alerts.json
2. Filtering by rule ID
3. Extraction of attacker IP
4. Execution of firewall block command
5. Persistence of blocked IP addresses

---

## 8.2 Blocked IP Tracking

File location:```C:\wazuh\scripts\blocked-ips.txt```

Example content:
```
172.30.1.59
172.30.1.62
```


This file stores previously blocked IP addresses to prevent duplicate firewall rules from being created by the automated response script.

---

# 9. Firewall Enforcement

## 9.1 Firewall Block Command

File location:```C:\Program Files (x86)\ossec-agent\active-response\bin\firewall-block.cmd```


Command script:

```cmd
@echo off
set ip=%1
powershell -ExecutionPolicy Bypass -File "C:\Program Files (x86)\ossec-agent\active-response\bin\firewall-block.ps1" %ip%
```
This script acts as a wrapper that passes the detected attacker IP address to the PowerShell firewall script.

---

## 9.2 PowerShell Firewall Script

File location:```C:\Program Files (x86)\ossec-agent\active-response\bin\firewall-block.ps1```

PowerShell implementation:
```PowerShell
param($ip)

$ruleName = "Wazuh_Block_$ip"

New-NetFirewallRule `
 -DisplayName $ruleName `
 -Direction Inbound `
 -RemoteAddress $ip `
 -Action Block `
 -Protocol TCP
```
This script dynamically creates a Windows Firewall rule that blocks inbound traffic from the detected attacker IP.

---

# 10. Attack Simulation & Testing

To validate the automated containment pipeline, a brute-force authentication attack was simulated against the login endpoint.

Target endpoint: ```POST /controller?cmd=loginAction```


Attack characteristics:

- Multiple failed login attempts
- Five or more authentication failures within 30 seconds
- Application logs classify the event as `auth_level=HIGH`

Expected result:

1. Wazuh rule `100102` is triggered  
2. Alert is written to `alerts.json`  
3. The monitoring script detects the alert  
4. The attacker IP address is extracted  
5. A firewall rule is created automatically  

Example firewall rule created by the system: Wazuh_Block_172.30.1.59


---

# 11. Security Impact

| Capability | Before | After |
|---|---|---|
| Brute-force detection | Yes | Yes |
| Automated containment | No | Yes |
| Detection-to-response time | Manual | Near real-time |
| SOC workload | High | Reduced |
| Incident response maturity | Monitoring only | Active containment |

The system converts **security detection signals into automated defensive actions**, improving response speed and operational efficiency.

---

# 12. MITRE ATT&CK Mapping

| Tactic | Technique | ID |
|---|---|---|
| Credential Access | Brute Force | T1110 |
| Initial Access | Exploit Public-Facing Application | T1190 |

The automated containment mechanism mitigates credential-access attacks before successful account compromise.

---

# 13. Limitations

| Limitation | Description |
|---|---|
| Static firewall rules | Firewall rules do not expire automatically |
| Host-level containment | Blocking occurs only on the Windows host |
| No threat intelligence | IP reputation is not evaluated |
| No distributed response | Reverse proxy or WAF integration not implemented |

These limitations reflect the simplified laboratory deployment used for this project.

---

# 14. Future Improvements

Planned enhancements include:

### Native Wazuh Active Response

Replace the external monitoring script with Wazuh's built-in active response mechanism.

### Temporary IP Blocking

Introduce automatic expiration for firewall rules.

### Threat Intelligence Integration

Enrich alerts using external threat intelligence sources such as:

- AbuseIPDB  
- Community threat feeds  

### Distributed Containment

Extend the response mechanism to additional infrastructure layers:

- Reverse proxies  
- Web Application Firewalls (WAF)  
- Load balancers  

### Behavior-Based Response

Introduce additional detection and response logic based on:

- anomaly detection  
- geo-location analysis  
- reputation scoring  

---

# 15. Conclusion

This phase introduces **automated incident containment** into the security monitoring architecture.

By integrating:

- application-aware security logging  
- SIEM rule correlation  
- automated firewall enforcement  

the system evolves from passive monitoring to **active defensive response**.

This implementation demonstrates how lightweight automation can significantly enhance incident response capabilities while remaining compatible with legacy application environments.
