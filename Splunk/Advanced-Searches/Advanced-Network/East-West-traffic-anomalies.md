# ↔️ East–West Traffic Anomalies Detection
## Linux • Windows • Cloud (Advanced Splunk Searches)

This document focuses on **detecting anomalous East–West traffic**, which refers to **lateral communication between internal systems** (host-to-host, workload-to-workload, service-to-service).

Abnormal East–West traffic is a strong indicator of:
- Lateral movement
- Worm propagation
- Internal reconnaissance
- Credential abuse
- Post-exploitation activity

Designed for:
- SOC Tier 2 / Tier 3 Analysts
- Threat Hunters
- Incident Responders
- Splunk Mastery – Advanced Searches

---

## 🎯 Objectives
- Establish baseline internal traffic behavior
- Detect abnormal lateral communication
- Identify unauthorized service access
- Correlate East–West traffic with endpoint and identity events
- Support rapid investigation of internal compromises

---

## 🧠 What is East–West Traffic?

East–West traffic includes:
- Server-to-server communication
- Workstation-to-server access
- Container-to-container traffic
- VM-to-VM traffic inside cloud VPCs/VNETs

This traffic is normally **high-volume but predictable**.
Anomalies indicate **compromise or misuse**.

---

## 🧠 Detection Strategy

| Signal | Description |
|------|------------|
| New Connections | First-time host-to-host communication |
| Volume Spike | Sudden increase in internal traffic |
| Port Misuse | Non-standard ports between internal hosts |
| Role Violation | Workstation accessing server-only services |
| Spread Pattern | One-to-many internal connections |

---

## 🟡 BASELINE INTERNAL COMMUNICATION

### 🔍 Common East–West Traffic Patterns
```spl
index IN (network_logs, windows_logs, linux_logs)
| search src_ip IN (10.0.0.0/8,172.16.0.0/12,192.168.0.0/16)
| stats count by src_ip dest_ip dest_port
```

Purpose:
- Understand normal internal connectivity
- Identify expected service relationships

---

## 🔴 NEW OR RARE INTERNAL CONNECTIONS

### 🆕 First-Seen East–West Traffic
```spl
index=network_logs
| stats earliest(_time) AS first_seen latest(_time) AS last_seen count by src_ip dest_ip dest_port
| where first_seen > relative_time(now(), "-7d")
```

Purpose:
- Detect newly established internal connections
- Identify unexpected lateral movement

---

## 🟠 INTERNAL PORT MISUSE

### 🚪 Unusual Ports Used Internally
```spl
index=network_logs
| search src_ip!=dest_ip
| search dest_port NOT IN (22,80,443,3389,445)
| stats count by src_ip dest_ip dest_port
| where count > 20
```

Purpose:
- Detect C2 or backdoor services
- Identify tunneled or unauthorized services

---

## 🔵 ONE-TO-MANY LATERAL MOVEMENT

### 🕸️ Internal Scanning / Worm Behavior
```spl
index=network_logs
| stats dc(dest_ip) AS targets count by src_ip
| where targets > 10
```

Purpose:
- Detect lateral scanning
- Identify rapid internal spread

---

## 🟣 ROLE VIOLATION DETECTION

### 🖥️ Workstation Accessing Server Services
```spl
index IN (network_logs, windows_logs)
| search src_role="workstation" AND dest_port IN (1433,3306,5432,6379)
| stats count by src_ip dest_ip dest_port
```

Purpose:
- Detect credential misuse
- Identify abnormal access paths

---

## ☁️ CLOUD EAST–WEST ANOMALIES

### ☁️ VPC / VNET Lateral Traffic
```spl
index=cloud_network_logs
| stats count by src_instance dest_instance dest_port
| where count > 100
```

Purpose:
- Detect compromised cloud workloads
- Identify abnormal service-to-service traffic

---

## 🔗 CORRELATION WITH ENDPOINT ACTIVITY

### 🔑 East–West Traffic + Authentication
```spl
index IN (network_logs, windows_logs, linux_logs)
| eval normalized_host=coalesce(host, ComputerName)
| table _time normalized_host src_ip dest_ip dest_port user
```

Purpose:
- Tie network movement to user actions
- Identify compromised identities

---

## ⏱️ EAST–WEST TRAFFIC TIMELINE

```spl
index IN (network_logs, windows_logs, linux_logs, cloud_network_logs)
| sort _time
| table _time src_ip dest_ip dest_port protocol host user
```

Purpose:
- Visualize lateral movement over time
- Support scoping and containment

---

## 🛡️ SOC RESPONSE & INVESTIGATION NOTES
- Validate whether communication is business-justified
- Identify process or service generating traffic
- Correlate with privilege escalation events
- Isolate compromised hosts if lateral movement confirmed
- Block unauthorized internal ports
- Review segmentation and firewall rules

---

## 🧠 MITRE ATT&CK Mapping

| Technique | Description |
|---------|-------------|
| T1021 | Remote Services |
| T1046 | Network Service Scanning |
| T1071 | Application Layer Protocol |
| T1550 | Use of Credentials |
| T1087 | Account Discovery |

---

## 📌 Summary
This file provides **advanced detection logic for East–West traffic anomalies**, enabling SOC teams to uncover **lateral movement, internal reconnaissance, and post-exploitation behavior** across **Linux, Windows, and Cloud environments**.

