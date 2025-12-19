# 📅 Seasonal Behavior Modeling
## Linux • Windows • Cloud (Advanced Splunk Detection Engineering)

This document focuses on **seasonal behavior modeling**, a detection engineering technique used to identify **anomalies relative to normal time-based patterns** such as **hour-of-day, day-of-week, and business cycles**.

Seasonal modeling is critical because many activities are:
- Normal at certain times
- Suspicious outside those periods

Designed for:
- SOC Tier 2 / Tier 3 Analysts
- Threat Hunters
- Detection Engineers
- Splunk Mastery – Advanced Searches

---

## 🎯 Objectives
- Model normal time-based behavior
- Detect anomalies relative to seasonality
- Reduce false positives caused by business cycles
- Identify stealthy attacks hiding in “normal” volume
- Improve precision of anomaly-based detections

---

## 🧠 What Is Seasonal Behavior?

Seasonal behavior refers to **repeating patterns over time**, such as:
- Business hours vs off-hours
- Weekdays vs weekends
- Month-end / quarter-end spikes
- Backup windows
- Scheduled batch jobs
- Cloud auto-scaling cycles

> A spike is not suspicious if it happens every Monday at 09:00.

---

## 🧠 Common Seasonal Dimensions

| Dimension | Examples |
|--------|----------|
| Hourly | Office hours vs night |
| Daily | Weekdays vs weekends |
| Weekly | Patch windows |
| Monthly | Billing, backups |
| Role-Based | Admin vs user schedules |

---

## 🟡 BUILDING SEASONAL BASELINES

### 🔍 Hour-of-Day Baseline
```spl
index=network_logs
| eval hour=strftime(_time,"%H")
| stats avg(bytes) AS avg_bytes by src_ip hour
```

Purpose:
- Model normal traffic per hour
- Detect off-hour anomalies

---

## 🔴 OFF-HOURS ANOMALY DETECTION

### 🌙 Activity Outside Normal Hours
```spl
index IN (windows_logs, linux_logs)
| eval hour=strftime(_time,"%H")
| stats count AS actions by user hour
| eventstats avg(actions) AS avg_actions by user
| where hour < 6 OR hour > 22
```

Purpose:
- Detect suspicious late-night activity
- Identify compromised accounts

---

## 🟠 DAY-OF-WEEK MODELING

### 📆 Weekday vs Weekend Behavior
```spl
index=network_logs
| eval day=strftime(_time,"%A")
| stats avg(bytes) AS avg_bytes by src_ip day
```

Purpose:
- Identify abnormal weekend traffic
- Detect misuse during low-visibility periods

---

## 🔵 SEASONAL SPIKE DETECTION

### 📈 Spike Outside Normal Seasonal Window
```spl
index=network_logs
| eval hour=strftime(_time,"%H")
| stats avg(bytes) AS avg_bytes stdev(bytes) AS sd_bytes by src_ip hour
| eval z_score=(bytes-avg_bytes)/sd_bytes
| where z_score > 3
```

Purpose:
- Detect abnormal spikes relative to time-of-day baseline
- Identify hidden exfiltration

---

## 🟣 USER SEASONAL BEHAVIOR

### 👤 User Activity Pattern Modeling
```spl
index IN (windows_logs, linux_logs)
| eval hour=strftime(_time,"%H")
| stats avg(count) AS avg_actions by user hour
```

Purpose:
- Model normal user schedules
- Detect impersonation or misuse

---

## ☁️ CLOUD SEASONAL MODELING

### ☁️ Cloud API Usage by Time
```spl
index=cloud_logs
| eval hour=strftime(_time,"%H")
| stats avg(count) AS avg_api_calls by user hour
```

Purpose:
- Identify abnormal cloud automation
- Detect compromised service accounts

---

## 🔥 SEASONAL DEVIATION DETECTION

### 🚨 Activity Deviating From Seasonal Norm
```spl
index=network_logs
| eval hour=strftime(_time,"%H")
| stats avg(bytes) AS baseline_bytes by src_ip hour
| join src_ip hour [
    search index=network_logs
    | eval hour=strftime(_time,"%H")
    | stats sum(bytes) AS current_bytes by src_ip hour
]
| eval deviation=current_bytes/baseline_bytes
| where deviation > 3
```

Purpose:
- Detect anomalies relative to expected season
- Avoid false positives during known peaks

---

## 🔗 SEASONAL + THRESHOLD-LESS CORRELATION

### 🔑 Weak Signals During Unusual Time Windows
```spl
index IN (network_logs, windows_logs, linux_logs)
| eval hour=strftime(_time,"%H")
| search hour < 6 OR hour > 22
| table _time user host src_ip dest_ip action
```

Purpose:
- Combine time + behavior
- Increase detection confidence

---

## ⏱️ SEASONAL TIMELINE VIEW

```spl
index=*
| eval hour=strftime(_time,"%H")
| sort _time
| table _time hour user host action metric
```

Purpose:
- Visualize behavior against time patterns
- Support investigation and reporting

---

## 🛡️ SOC RESPONSE & TUNING NOTES
- Build baselines over multiple weeks
- Account for holidays and special events
- Separate seasonal models by role and asset type
- Combine with anomaly and outlier detection
- Avoid alerting on known scheduled tasks
- Track recurring seasonal deviations

---

## 🧠 MITRE ATT&CK Mapping

| Technique | Description |
|---------|-------------|
| T1078 | Valid Accounts |
| T1041 | Exfiltration |
| T1071 | Command & Control |
| T1059 | Command Execution |
| T1021 | Remote Services |

---

## 📌 Summary
This file provides **advanced seasonal behavior modeling techniques** that enable SOC teams to detect **time-based anomalies and stealthy attacks** across **Linux, Windows, and Cloud environments**, while **reducing false positives caused by normal business cycles**.

