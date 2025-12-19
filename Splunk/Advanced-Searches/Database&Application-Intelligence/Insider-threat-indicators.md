# 🕵️ Insider Threat Indicators
## Identity • Endpoint • Network • Application • Cloud (Advanced Splunk Detection Engineering)

This document focuses on **detecting insider threat indicators**, where **legitimate users abuse authorized access**—intentionally or unintentionally—to compromise **data confidentiality, integrity, or availability**.

Insider threats are challenging because:
- Activity is authenticated
- Actions often look legitimate
- Behavior blends into normal workflows
- Traditional signature-based detections fail

Designed for:
- SOC Tier 2 / Tier 3 Analysts
- Threat Hunters
- Detection Engineers
- Insider Risk Teams
- Splunk Mastery – Advanced Searches

---

## 🎯 Objectives
- Identify early insider threat indicators
- Detect misuse of legitimate access
- Correlate behavior across multiple domains
- Reduce false positives using context
- Support proactive insider risk investigations

---

## 🧠 What Is an Insider Threat?

An insider threat may involve:
- Malicious insiders (intentional abuse)
- Negligent insiders (accidental exposure)
- Compromised insiders (stolen credentials)

> Insider threats are defined by **intent + access + behavior**, not malware.

---

## 🧠 Common Insider Threat Indicators

| Category | Indicators |
|--------|-----------|
| Access | Unusual data access patterns |
| Time | Off-hours or atypical working times |
| Volume | Sudden increase in activity |
| Scope | Access outside normal role |
| Behavior | Rare or first-time actions |
| Correlation | Multiple weak signals together |

---

## 🟡 BASELINE USER BEHAVIOR

### 🔍 Normal User Activity Profile
```spl
index IN (windows_logs, linux_logs, app_logs)
| stats avg(count) AS avg_actions by user
```

Purpose:
- Establish normal behavior
- Required for insider detection

---

## 🔴 OFF-HOURS ACTIVITY

### 🌙 Suspicious After-Hours Access
```spl
index IN (windows_logs, linux_logs, app_logs)
| eval hour=strftime(_time,"%H")
| search hour < 6 OR hour > 22
| stats count by user host
```

Purpose:
- Detect unusual access timing
- Identify stealthy behavior

---

## 🟠 EXCESSIVE DATA ACCESS

### 📦 Abnormal Data Volume by User
```spl
index IN (db_logs, app_logs)
| stats sum(rows_returned) AS total_rows by user
| eventstats avg(total_rows) AS avg_rows stdev(total_rows) AS sd_rows
| where total_rows > avg_rows + (3*sd_rows)
```

Purpose:
- Detect bulk data harvesting
- Identify exfiltration via legitimate access

---

## 🔵 RARE OR FIRST-TIME ACTIONS

### 🧬 Uncommon User Actions
```spl
index=*
| stats count by user action
| where count < 3
```

Purpose:
- Detect new or unusual behavior
- Catch early-stage insider activity

---

## 🟣 ROLE & SCOPE VIOLATIONS

### 🔐 Actions Outside Job Role
```spl
index IN (app_logs, cloud_logs)
| stats count by user role action
| where role="user" AND action IN ("admin","config_change","permission_update")
```

Purpose:
- Detect abuse of privileges
- Identify broken access controls

---

## 🔥 DATA EXFILTRATION INDICATORS

### 🌐 Data Access Followed by Network Egress
```spl
index IN (db_logs, network_logs)
| table _time user host rows_returned dest_ip bytes_out
```

Purpose:
- Correlate data access with outbound transfer
- Confirm exfiltration path

---

## 🧠 CLOUD INSIDER THREAT INDICATORS

### ☁️ Abnormal Cloud Resource Access
```spl
index=cloud_logs
| stats count by user eventName
| where eventName IN ("GetObject","ListBuckets","DownloadBlob","ExportData")
```

Purpose:
- Detect cloud data misuse
- Identify risky behavior by valid users

---

## 🔗 MULTI-SIGNAL INSIDER CORRELATION

### 🔑 Weak Signals Combined
```spl
index IN (windows_logs, linux_logs, app_logs, db_logs, network_logs)
| table _time user host action rows_returned bytes_out
```

Purpose:
- Increase confidence by correlating signals
- Reduce noise from single events

---

## ⏱️ INSIDER ACTIVITY TIMELINE

```spl
index=*
| sort _time
| table _time user host action resource
```

Purpose:
- Reconstruct insider behavior
- Support investigations and HR coordination

---

## 🛡️ SOC RESPONSE & INVESTIGATION NOTES
- Validate business justification before escalation
- Coordinate with HR and Legal teams
- Avoid alerting on single indicators
- Look for repeated or escalating behavior
- Apply least-privilege access controls
- Monitor users during role changes or notice periods

---

## 🧠 MITRE ATT&CK Mapping

| Technique | Description |
|---------|-------------|
| T1078 | Valid Accounts |
| T1530 | Data from Cloud Storage |
| T1041 | Exfiltration |
| T1059 | Command Execution |
| T1021 | Remote Services |

---

## 📌 Summary
This file provides **advanced insider threat detection indicators** that enable SOC teams to identify **malicious, negligent, or compromised insiders** by correlating **identity, endpoint, application, database, network, and cloud behavior**, using **context-driven, behavior-based detections**.

