# 📊 Network Behavior Baselining
## Linux • Windows • Cloud (Advanced Splunk Searches)

This document focuses on **establishing and using network behavior baselines** to detect **anomalies, intrusions, and post-exploitation activity** across **Linux, Windows, and Cloud environments**.

Behavior baselining allows SOC teams to detect **unknown threats** by identifying **deviations from normal activity**, even when no signatures exist.

Designed for:
- SOC Tier 2 / Tier 3 Analysts
- Threat Hunters
- Detection Engineers
- Splunk Mastery – Advanced Searches

---

## 🎯 Objectives
- Build reliable network baselines
- Identify deviations from normal behavior
- Detect stealthy attacks and misuse
- Correlate anomalies with endpoint and identity activity
- Reduce false positives through contextual analysis

---

## 🧠 What is Network Behavior Baselining?

Network baselining involves learning:
- Who communicates with whom
- Over which ports and protocols
- At what frequency and volume
- During which times of day
- From which locations

Once a baseline exists, **anything outside it becomes suspicious**.

---

## 🧠 Baselining Dimensions

| Dimension | Examples |
|--------|----------|
| Source | Host, IP, user |
| Destination | IP, domain, service |
| Protocol | TCP, UDP, TLS |
| Port | Common vs uncommon |
| Volume | Bytes, sessions |
| Time | Hour, day, weekday |

---

## 🟡 BUILDING A BASELINE (FOUNDATION)

### 🔍 Common Network Behavior
```spl
index=network_logs
| stats count sum(bytes) by src_ip dest_ip dest_port protocol
```

Purpose:
- Capture normal communication patterns
- Identify standard services and peers

---

## 🔴 TIME-BASED BASELINING

### ⏱️ Normal Activity by Hour
```spl
index=network_logs
| eval hour=strftime(_time,"%H")
| stats avg(bytes) AS avg_bytes count AS sessions by src_ip hour
```

Purpose:
- Identify expected working-hour traffic
- Detect off-hours anomalies

---

## 🟠 PORT & PROTOCOL BASELINES

### 🚪 Expected Port Usage
```spl
index=network_logs
| stats count by src_ip dest_port protocol
```

Purpose:
- Define normal port usage per host
- Detect unexpected services

---

## 🔵 VOLUME-BASED BASELINING

### 📊 Normal Data Transfer Volumes
```spl
index=network_logs
| stats avg(bytes) AS avg_bytes max(bytes) AS max_bytes by src_ip dest_ip
```

Purpose:
- Detect abnormal spikes or drops
- Identify exfiltration or DoS behavior

---

## 🟣 FREQUENCY-BASED BASELINING

### 🔁 Normal Connection Rates
```spl
index=network_logs
| bucket _time span=5m
| stats count AS connections by src_ip _time
| stats avg(connections) AS avg_conn by src_ip
```

Purpose:
- Identify beaconing and scanning
- Detect automation and malware activity

---

## 🔥 DEVIATION DETECTION (CORE USE CASE)

### 🚨 Traffic Spikes vs Baseline
```spl
index=network_logs
| stats avg(bytes) AS baseline_bytes by src_ip
| join src_ip [
    search index=network_logs
    | stats sum(bytes) AS current_bytes by src_ip
]
| eval deviation=current_bytes/baseline_bytes
| where deviation > 5
```

Purpose:
- Detect abnormal data movement
- Identify suspicious bursts of activity

---

## ☁️ CLOUD NETWORK BASELINING

### ☁️ Normal Cloud Egress Patterns
```spl
index=cloud_network_logs
| stats avg(bytes_out) AS avg_egress by src_instance
```

Purpose:
- Identify typical cloud traffic
- Detect compromised workloads

---

## 🔗 CORRELATION WITH ENDPOINT & IDENTITY

### 🔑 Network + Authentication Context
```spl
index IN (network_logs, windows_logs, linux_logs)
| table _time src_ip dest_ip dest_port user host
```

Purpose:
- Tie anomalies to users and processes
- Reduce false positives

---

## ⏱️ BASELINE COMPARISON TIMELINE

```spl
index=network_logs
| sort _time
| table _time src_ip dest_ip dest_port protocol bytes
```

Purpose:
- Visualize deviations over time
- Support investigation and scoping

---

## 🛡️ SOC RESPONSE & INVESTIGATION NOTES
- Validate whether deviation is business-justified
- Correlate with endpoint execution events
- Look for persistence or repeat patterns
- Tune baselines per asset role
- Continuously update baselines
- Use baselining alongside signature-based detections

---

## 🧠 MITRE ATT&CK Mapping

| Technique | Description |
|---------|-------------|
| T1046 | Network Service Discovery |
| T1071 | Application Layer Protocol |
| T1095 | Non-Application Layer Protocol |
| T1041 | Exfiltration Over C2 Channel |
| T1021 | Remote Services |

---

## 📌 Summary
This file provides **advanced network behavior baselining techniques** that enable SOC teams to detect **unknown, stealthy, and post-exploitation threats** by identifying **deviations from normal network behavior** across **Linux, Windows, and Cloud environments**.

