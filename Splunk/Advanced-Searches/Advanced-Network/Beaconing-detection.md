# 📡 Beaconing Detection
## Linux • Windows • Cloud (Advanced Splunk Searches)

This document focuses on **detecting beaconing behavior**, a common indicator of **Command & Control (C2)** activity, where compromised systems communicate with attacker infrastructure at **regular or semi-regular intervals**.

Beaconing is typically observed after **initial compromise** and is critical for identifying **active intrusions**.

Designed for:
- SOC Tier 2 / Tier 3 Analysts
- Threat Hunters
- Incident Responders
- Splunk Mastery – Advanced Searches

---

## 🎯 Objectives
- Detect periodic outbound communication
- Identify low-and-slow C2 channels
- Correlate beaconing across endpoints and cloud
- Reduce false positives through behavior-based logic
- Support rapid containment of compromised assets

---

## 🧠 What is Beaconing?

Beaconing is characterized by:
- Repeated outbound connections
- Consistent destination IP/domain
- Regular time intervals
- Small, repetitive data transfers
- Use of uncommon ports or protocols

---

## 🧠 Beaconing Detection Strategy

| Signal | Description |
|------|------------|
| Periodicity | Fixed or semi-fixed time gaps |
| Frequency | High number of similar connections |
| Destination | Repeated IP / domain |
| Payload Size | Small and consistent |
| Duration | Sustained over time |

---

## 🟡 BASIC OUTBOUND CONNECTION BASELINE

### 🔍 Identify Frequent Destinations
```spl
index IN (linux_logs, windows_logs)
| stats count by host dest_ip dest_port
| where count > 50
```

Purpose:
- Establish outbound communication patterns
- Identify unusually frequent connections

---

## 🔴 PERIODIC BEACONING (CORE DETECTION)

### ⏱️ Time-Interval Consistency Detection
```spl
index IN (linux_logs, windows_logs)
| sort _time
| streamstats window=2 current=f last(_time) AS prev_time by host dest_ip
| eval interval=_time - prev_time
| stats avg(interval) stdev(interval) count by host dest_ip
| where count > 20 AND stdev(interval) < 5
```

Purpose:
- Detect **regular communication intervals**
- Low standard deviation indicates automation

---

## 🟠 LOW-AND-SLOW BEACONING

### 🐢 Sparse but Consistent Connections
```spl
index IN (linux_logs, windows_logs)
| bucket _time span=5m
| stats count by host dest_ip _time
| stats avg(count) AS avg_count by host dest_ip
| where avg_count > 1 AND avg_count < 5
```

Purpose:
- Detect stealthy C2 traffic
- Catch malware avoiding noisy behavior

---

## 🔵 SMALL PAYLOAD BEACONING

### 📦 Consistent Byte Size Transfers
```spl
index IN (linux_logs, windows_logs)
| stats avg(bytes_out) AS avg_out stdev(bytes_out) AS sd_out count by host dest_ip
| where count > 20 AND sd_out < 100
```

Purpose:
- Identify callback traffic with fixed payloads
- Common in malware heartbeat traffic

---

## 🟣 UNCOMMON PORT BEACONING

### 🚪 Suspicious Destination Ports
```spl
index IN (linux_logs, windows_logs)
| search dest_port NOT IN (80,443,53)
| stats count by host dest_ip dest_port
| where count > 20
```

Purpose:
- Identify C2 over non-standard ports
- Reduce noise from normal web traffic

---

## ☁️ CLOUD BEACONING DETECTION

### 📡 Excessive API Call Patterns
```spl
index=cloud_logs
| bucket _time span=5m
| stats count by user userAgent _time
| stats avg(count) AS avg_calls by user userAgent
| where avg_calls > 100
```

Purpose:
- Detect automated cloud API beaconing
- Identify compromised service accounts or tokens

---

## 🔗 CROSS-PLATFORM BEACONING CORRELATION

### 🔑 Same Destination Across Multiple Hosts
```spl
index IN (linux_logs, windows_logs)
| stats dc(host) AS hosts count by dest_ip
| where hosts > 3 AND count > 50
```

Purpose:
- Identify shared C2 infrastructure
- Detect campaign-level compromise

---

## ⏱️ BEACONING TIMELINE RECONSTRUCTION

```spl
index IN (linux_logs, windows_logs, cloud_logs)
| eval normalized_host=coalesce(host, ComputerName, resource)
| sort _time
| table _time normalized_host dest_ip dest_port bytes_out user userAgent
```

Purpose:
- Visualize beaconing activity over time
- Support containment and scoping

---

## 🛡️ SOC RESPONSE & INVESTIGATION NOTES
- Validate destination IP/domain reputation
- Check DNS logs for related queries
- Identify process generating traffic
- Isolate affected hosts immediately
- Rotate compromised credentials
- Block C2 indicators at perimeter

---

## 🧠 MITRE ATT&CK Mapping

| Technique | Description |
|---------|-------------|
| T1071 | Application Layer Protocol |
| T1095 | Non-Application Layer Protocol |
| T1043 | Commonly Used Port |
| T1105 | Ingress Tool Transfer |
| T1071.001 | Web-based C2 |

---

## 📌 Summary
This file provides **advanced beaconing detection logic** across **Linux, Windows, and Cloud environments**, enabling SOC teams to detect **active C2 communication**, even when attackers use **stealthy, low-and-slow techniques**.

