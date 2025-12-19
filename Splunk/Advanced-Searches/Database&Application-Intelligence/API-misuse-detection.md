# 🔌 API Misuse Detection
## Application & Cloud Intelligence (Advanced Splunk Detection Engineering)

This document focuses on **detecting API misuse**, where attackers abuse **legitimate APIs, tokens, and application logic** to perform **reconnaissance, data exfiltration, privilege abuse, or automation-based attacks**.

API misuse is especially dangerous because:
- Requests are authenticated
- Payloads are valid
- Traffic is encrypted (HTTPS)
- Abuse blends into normal application behavior

Designed for:
- SOC Tier 2 / Tier 3 Analysts
- Threat Hunters
- Detection Engineers
- Splunk Mastery – Advanced Searches

---

## 🎯 Objectives
- Detect abnormal API usage patterns
- Identify compromised API keys and tokens
- Detect automation, scraping, and enumeration
- Correlate API activity with DB and network signals
- Support investigations into application-layer abuse

---

## 🧠 What Is API Misuse?

API misuse occurs when attackers:
- Abuse valid API keys or tokens
- Enumerate resources via APIs
- Automate high-volume requests
- Access endpoints outside intended roles
- Exfiltrate data through API responses
- Chain APIs to bypass application controls

> No exploit needed — just **valid access + malicious intent**.

---

## 🧠 Common API Misuse Patterns

| Pattern | Description |
|-------|-------------|
| API Enumeration | Accessing many IDs or endpoints |
| Automation Abuse | Scripted or bot-driven requests |
| Token Abuse | Stolen or leaked API keys |
| Role Misuse | API actions outside role scope |
| Bulk Extraction | Large or repeated API responses |
| Off-Hours Abuse | API usage at unusual times |

---

## 🟡 BASELINING NORMAL API USAGE

### 🔍 Normal API Calls per User / Token
```spl
index=api_logs
| stats avg(count) AS avg_calls by user api_endpoint
```

Purpose:
- Establish normal API usage
- Detect deviations later

---

## 🔴 API ENUMERATION DETECTION

### 🔁 High Number of Unique Resources Accessed
```spl
index=api_logs
| stats dc(resource_id) AS unique_resources by user
| where unique_resources > 50
```

Purpose:
- Detect IDOR-style enumeration
- Identify reconnaissance via APIs

---

## 🟠 API AUTOMATION & BOT ABUSE

### 🤖 High-Frequency API Requests
```spl
index=api_logs
| bucket _time span=1m
| stats count AS requests by user _time
| eventstats avg(requests) AS avg_req stdev(requests) AS sd_req by user
| where requests > avg_req + (3*sd_req)
```

Purpose:
- Detect scripted abuse
- Identify compromised tokens or bots

---

## 🔵 RARE OR DANGEROUS API METHODS

### 🧬 Uncommon API Operations
```spl
index=api_logs
| stats count by user http_method
| where http_method IN ("PUT","DELETE","PATCH")
```

Purpose:
- Detect destructive or sensitive operations
- Identify privilege misuse

---

## 🟣 ROLE & SCOPE VIOLATION

### 🔐 API Actions Outside Assigned Role
```spl
index=api_logs
| stats count by user role api_action
| where role="user" AND api_action IN ("admin","config_update","permission_change")
```

Purpose:
- Detect broken authorization
- Identify abuse of business logic

---

## 🔥 BULK DATA EXTRACTION VIA API

### 📦 Large API Response Sizes
```spl
index=api_logs
| stats avg(response_size) AS avg_size max(response_size) AS max_size by user
| where max_size > avg_size * 5
```

Purpose:
- Detect data exfiltration through APIs
- Identify abused export or list endpoints

---

## 🌙 TIME-BASED API MISUSE

### ⏱️ Off-Hours API Activity
```spl
index=api_logs
| eval hour=strftime(_time,"%H")
| search hour < 6 OR hour > 22
| stats count by user api_endpoint
```

Purpose:
- Detect stealthy automation
- Identify compromised credentials

---

## ☁️ CLOUD API MISUSE

### ☁️ Abnormal Cloud API Usage
```spl
index=cloud_logs
| stats count AS api_calls by user
| eventstats avg(api_calls) AS avg_calls stdev(api_calls) AS sd_calls
| where api_calls > avg_calls + (3*sd_calls)
```

Purpose:
- Detect cloud API abuse
- Identify compromised service accounts

---

## 🔗 API + DATABASE CORRELATION

### 🗄️ API Requests Triggering DB Exfiltration
```spl
index IN (api_logs, db_logs)
| table _time user api_endpoint query table rows_returned
```

Purpose:
- Confirm backend data abuse
- Identify exploited API endpoints

---

## 🔗 API + NETWORK CORRELATION

### 🌐 API Abuse Followed by Egress
```spl
index IN (api_logs, network_logs)
| table _time user api_endpoint dest_ip bytes_out
```

Purpose:
- Validate exfiltration path
- Increase detection confidence

---

## ⏱️ API MISUSE TIMELINE

```spl
index=api_logs
| sort _time
| table _time user api_key api_endpoint http_method response_code response_size
```

Purpose:
- Reconstruct API abuse sequence
- Support incident response and reporting

---

## 🛡️ SOC RESPONSE & INVESTIGATION NOTES
- Rotate compromised API keys immediately
- Identify abused endpoints and scopes
- Enforce rate limiting and quotas
- Apply least-privilege API permissions
- Add logging for sensitive endpoints
- Correlate with DB, exfiltration, and anomaly detections

---

## 🧠 MITRE ATT&CK Mapping

| Technique | Description |
|---------|-------------|
| T1190 | Exploit Public-Facing Application |
| T1078 | Valid Accounts |
| T1041 | Exfiltration |
| T1567 | Exfiltration Over Web Services |
| T1059 | Command Execution |

---

## 📌 Summary
This file provides **advanced API misuse detection techniques** that enable SOC teams to uncover **enumeration, automation abuse, token compromise, and data exfiltration** through APIs, across **on-prem and cloud application environments**, where traditional perimeter defenses often fail.

