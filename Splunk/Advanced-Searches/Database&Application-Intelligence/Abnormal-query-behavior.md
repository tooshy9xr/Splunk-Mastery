# 🗄️ Abnormal Query Behavior
## Database & Application Intelligence (Advanced Splunk Detection Engineering)

This document focuses on **detecting abnormal database and application query behavior**, a critical capability for identifying **data theft, SQL abuse, compromised applications, and insider threats**.

Query-level anomalies often indicate:
- SQL injection exploitation
- Application compromise
- Data exfiltration
- Privilege abuse
- Enumeration and reconnaissance
- Misconfigured or abused services

Designed for:
- SOC Tier 2 / Tier 3 Analysts
- Threat Hunters
- Detection Engineers
- Splunk Mastery – Advanced Searches

---

## 🎯 Objectives
- Detect abnormal database query patterns
- Identify misuse of applications and APIs
- Detect data access abuse and exfiltration
- Model normal query behavior vs anomalies
- Support investigations into DB and app compromises

---

## 🧠 What Is Abnormal Query Behavior?

Abnormal query behavior includes:
- Queries executed at unusual times
- Sudden spikes in query volume
- Rare or dangerous query types
- Queries accessing sensitive tables unexpectedly
- Large result sets inconsistent with normal usage
- Behavior deviating from application baselines

> Applications rarely change behavior suddenly — attackers do.

---

## 🧠 Common Data Sources

| Source | Examples |
|------|---------|
| Database Logs | MySQL, PostgreSQL, MSSQL, Oracle |
| App Logs | Web apps, APIs, microservices |
| Cloud DB Logs | RDS, Azure SQL, Cloud SQL |
| WAF / Proxy | SQL injection indicators |

---

## 🟡 BASELINING NORMAL QUERY BEHAVIOR

### 🔍 Normal Query Volume per User / App
```spl
index=db_logs
| stats avg(query_count) AS avg_queries by user app
```

Purpose:
- Establish normal access patterns
- Detect deviations later

---

## 🔴 QUERY VOLUME ANOMALIES

### 📈 Sudden Spike in Queries
```spl
index=db_logs
| bucket _time span=5m
| stats count AS queries by user _time
| eventstats avg(queries) AS avg_q stdev(queries) AS sd_q by user
| where queries > avg_q + (3*sd_q)
```

Purpose:
- Detect enumeration or automated extraction
- Identify compromised applications

---

## 🟠 RARE QUERY TYPES

### 🧬 Uncommon SQL Operations
```spl
index=db_logs
| stats count by user query_type
| where query_type IN ("DROP","ALTER","TRUNCATE","GRANT","UNION")
```

Purpose:
- Detect destructive or high-risk queries
- Identify SQL injection or privilege abuse

---

## 🔵 ABNORMAL DATA ACCESS

### 📂 Sensitive Table Access Anomalies
```spl
index=db_logs
| stats count by user table
| where table IN ("users","credentials","payments","secrets")
```

Purpose:
- Detect unauthorized access to sensitive data
- Identify lateral data movement

---

## 🟣 LARGE RESULT SET ANOMALIES

### 📦 Unusually Large Query Responses
```spl
index=db_logs
| stats avg(rows_returned) AS avg_rows max(rows_returned) AS max_rows by user
| where max_rows > avg_rows * 5
```

Purpose:
- Detect bulk data extraction
- Identify exfiltration attempts

---

## 🔥 TIME-BASED QUERY ANOMALIES

### 🌙 Off-Hours Database Activity
```spl
index=db_logs
| eval hour=strftime(_time,"%H")
| search hour < 6 OR hour > 22
| stats count by user app
```

Purpose:
- Detect stealthy data access
- Identify compromised credentials

---

## ☁️ CLOUD DATABASE ABUSE

### ☁️ Abnormal Cloud DB API Usage
```spl
index=cloud_logs
| search service IN ("RDS","AzureSQL","CloudSQL")
| stats count AS api_calls by user
| eventstats avg(api_calls) AS avg_calls stdev(api_calls) AS sd_calls
| where api_calls > avg_calls + (3*sd_calls)
```

Purpose:
- Detect cloud DB automation abuse
- Identify compromised service accounts

---

## 🔗 APPLICATION + DATABASE CORRELATION

### 🔑 App Requests Triggering DB Anomalies
```spl
index IN (app_logs, db_logs)
| table _time app user endpoint query table rows_returned
```

Purpose:
- Tie abnormal DB queries to application behavior
- Identify exploited endpoints

---

## 🧠 SQL INJECTION INDICATORS

### 🧪 Suspicious Query Patterns
```spl
index=db_logs
| search query="*UNION SELECT*" OR query="*OR 1=1*" OR query="*--*"
| table _time user query
```

Purpose:
- Detect active SQL injection attempts
- Identify exploited applications

---

## ⏱️ QUERY BEHAVIOR TIMELINE

```spl
index=db_logs
| sort _time
| table _time user app query_type table rows_returned
```

Purpose:
- Reconstruct data access behavior
- Support incident scoping and reporting

---

## 🛡️ SOC RESPONSE & TUNING NOTES
- Whitelist known admin and maintenance queries
- Separate application users from human users
- Tune per application and database role
- Correlate with WAF, auth, and endpoint alerts
- Investigate large result sets immediately
- Rotate credentials if abuse confirmed

---

## 🧠 MITRE ATT&CK Mapping

| Technique | Description |
|---------|-------------|
| T1059 | Command Execution |
| T1078 | Valid Accounts |
| T1190 | Exploit Public-Facing Application |
| T1041 | Exfiltration |
| T1530 | Data from Cloud Storage Object |

---

## 📌 Summary
This file provides **advanced database and application intelligence techniques** for detecting **abnormal query behavior**, enabling SOC teams to uncover **data exfiltration, SQL abuse, and application compromise** across **on-prem and cloud environments**.

