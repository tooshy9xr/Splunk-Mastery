# 📤 Data Exfiltration via Databases
## Database & Application Intelligence (Advanced Splunk Detection Engineering)

This document focuses on **detecting data exfiltration via databases**, where attackers abuse **legitimate queries, application access, or database privileges** to extract large volumes of sensitive data.

Database-driven exfiltration is often:
- Low-and-slow
- Authenticated
- Blended with normal application behavior
- Missed by perimeter-only controls

Designed for:
- SOC Tier 2 / Tier 3 Analysts
- Threat Hunters
- Detection Engineers
- Splunk Mastery – Advanced Searches

---

## 🎯 Objectives
- Detect bulk data extraction from databases
- Identify abnormal query patterns tied to exfiltration
- Correlate DB activity with application and network signals
- Detect insider threats and compromised applications
- Support rapid scoping and containment

---

## 🧠 What Is Database Exfiltration?

Database exfiltration typically involves:
- Large SELECT queries
- Repeated access to sensitive tables
- Incremental extraction over time
- Off-hours data access
- Export features (CSV, dumps, backups)
- Abuse of reporting or analytics endpoints

> Most DB exfiltration uses **valid credentials** — behavior is the giveaway.

---

## 🧠 Common Data Sources

| Source | Examples |
|------|---------|
| DB Logs | MySQL, PostgreSQL, MSSQL, Oracle |
| App Logs | Web apps, APIs, BI tools |
| Cloud DB | RDS, Azure SQL, Cloud SQL |
| Network Logs | Egress from DB hosts |
| Auth Logs | DB users, service accounts |

---

## 🟡 BASELINING NORMAL DATA ACCESS

### 🔍 Normal Rows Returned per User
```spl
index=db_logs
| stats avg(rows_returned) AS avg_rows by user
```

Purpose:
- Establish normal query result sizes
- Detect abnormal extraction later

---

## 🔴 BULK DATA EXTRACTION DETECTION

### 📦 Large Result Sets
```spl
index=db_logs
| stats avg(rows_returned) AS avg_rows max(rows_returned) AS max_rows by user
| where max_rows > avg_rows * 5
```

Purpose:
- Detect mass data pulls
- Identify suspicious reporting or dumps

---

## 🟠 REPEATED SENSITIVE TABLE ACCESS

### 📂 High-Frequency Access to Sensitive Tables
```spl
index=db_logs
| search table IN ("users","credentials","payments","ssn","tokens","secrets")
| stats count AS accesses by user
| where accesses > 50
```

Purpose:
- Detect focused data harvesting
- Identify targeted exfiltration

---

## 🔵 INCREMENTAL (LOW-AND-SLOW) EXFILTRATION

### 🐢 Steady Extraction Over Time
```spl
index=db_logs
| bucket _time span=1h
| stats sum(rows_returned) AS rows by user _time
| eventstats avg(rows) AS avg_rows stdev(rows) AS sd_rows by user
| where rows > avg_rows + (3*sd_rows)
```

Purpose:
- Detect slow data leakage
- Catch attackers staying under thresholds

---

## 🟣 OFF-HOURS DATA ACCESS

### 🌙 Suspicious Timing of Queries
```spl
index=db_logs
| eval hour=strftime(_time,"%H")
| search hour < 6 OR hour > 22
| stats count sum(rows_returned) by user
```

Purpose:
- Detect stealthy extraction
- Identify compromised credentials

---

## 🔥 DATA EXPORT & DUMP ACTIVITY

### 📁 Export / Dump Commands
```spl
index=db_logs
| search query IN ("*INTO OUTFILE*","*COPY*","*pg_dump*","*mysqldump*","*bcp*")
| table _time user query
```

Purpose:
- Detect explicit data export
- Identify high-confidence exfiltration

---

## ☁️ CLOUD DATABASE EXFILTRATION

### ☁️ Abnormal Cloud DB Read Activity
```spl
index=cloud_logs
| search service IN ("RDS","AzureSQL","CloudSQL")
| stats sum(rows_returned) AS rows by user
| where rows > 100000
```

Purpose:
- Detect cloud-based data theft
- Identify abused service accounts

---

## 🔗 DATABASE + NETWORK CORRELATION

### 🌐 DB Reads Followed by Egress
```spl
index IN (db_logs, network_logs)
| table _time user host dest_ip bytes_out rows_returned
```

Purpose:
- Correlate data access with outbound transfer
- Confirm exfiltration path

---

## 🔗 APPLICATION + DATABASE CORRELATION

### 🔑 Abused Application Endpoints
```spl
index IN (app_logs, db_logs)
| table _time app endpoint user query table rows_returned
```

Purpose:
- Identify exploited APIs or reports
- Trace exfiltration to entry point

---

## ⏱️ EXFILTRATION TIMELINE

```spl
index=db_logs
| sort _time
| table _time user table rows_returned query_type
```

Purpose:
- Reconstruct data theft sequence
- Estimate scope and impact

---

## 🛡️ SOC RESPONSE & INVESTIGATION NOTES
- Identify impacted datasets and records
- Disable or rotate compromised DB credentials
- Revoke unnecessary read permissions
- Review application endpoints and reports
- Correlate with endpoint and beaconing detections
- Notify data owners and initiate IR procedures

---

## 🧠 MITRE ATT&CK Mapping

| Technique | Description |
|---------|-------------|
| T1078 | Valid Accounts |
| T1041 | Exfiltration Over C2 Channel |
| T1530 | Data from Cloud Storage Object |
| T1567 | Exfiltration Over Web Services |
| T1190 | Exploit Public-Facing Application |

---

## 📌 Summary
This file provides **advanced detection techniques for database-driven data exfiltration**, enabling SOC teams to identify **bulk, incremental, and stealthy data theft** via **databases and applications**, across **on-prem and cloud environments**.

