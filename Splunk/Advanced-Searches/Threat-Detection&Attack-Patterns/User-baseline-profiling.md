# 👤📊 User Baseline Profiling  
Advanced Behavioral Baseline & Anomaly Detection  
(Windows • Linux • Cloud)

---

## 📁 Folder Context (Professional Description)

The **User Baseline Profiling** module focuses on building a **normal behavior profile** for each user and then detecting **deviations from that baseline**.  
Instead of relying on static rules, this approach uses **historical behavior, frequency, time patterns, locations, and resource usage** to identify suspicious activity.

This file represents a **core concept in advanced detection, UEBA, and threat hunting**.

---

## 🎯 File Objective

`User-baseline-profiling.md` is designed to:
- Establish **normal user behavior baselines**
- Detect **anomalies and rare actions**
- Reduce false positives from static detections
- Identify compromised or abused accounts
- Support advanced SOC and UEBA-style analytics

---

## 🧩 Threat Context

Mapped to **MITRE ATT&CK**:
- T1078 – Valid Accounts  
- TA0006 – Credential Access  
- TA0008 – Lateral Movement  

Attackers often:
- Mimic normal user behavior
- Slowly drift away from baseline
- Abuse accounts over time
- Avoid noisy actions

Baseline profiling detects **subtle deviations**, not obvious attacks.

---

## 📊 Data Sources

| Source | Description |
|------|------------|
| Authentication Logs | Login time, frequency, and success patterns |
| Endpoint Logs | Commands, processes, and applications |
| Network Logs | Destinations, protocols, volume |
| Cloud IAM Logs | SaaS usage and API activity |
| VPN Logs | Remote access behavior |

---

## 🔍 Advanced Baseline Models (12 Patterns)

---

### 1️⃣ Normal Login Hours Baseline
```spl
index=auth action=success
| stats avg(date_hour) as avg_hour by user
```
**Detects:** Logins far outside a user’s normal working hours.

---

### 2️⃣ Login Frequency Deviation
```spl
| stats count as login_count by user
| where login_count > avg(login_count)*2
```
**Detects:** Sudden spikes in authentication activity.

---

### 3️⃣ Rare Host Access
```spl
| stats count by user host
| where count < 2
```
**Detects:** First-time or unusual system access.

---

### 4️⃣ New Source IP for User
```spl
| stats count by user src_ip
| where count = 1
```
**Detects:** Logins from previously unseen IPs.

---

### 5️⃣ Geographic Deviation
```spl
| iplocation src_ip
| stats values(Country) by user
```
**Detects:** Access from new countries or regions.

---

### 6️⃣ Abnormal Command Usage (Linux)
```spl
index=linux
| stats count by user cmd
| where count < 2
```
**Detects:** Rare or first-time command execution.

---

### 7️⃣ New Process Execution (Windows)
```spl
index=endpoint EventID=4688
| stats count by user process
| where count < 2
```
**Detects:** Execution of previously unseen binaries.

---

### 8️⃣ Cloud Application Drift
```spl
index=cloud action=success
| stats dc(AppDisplayName) by user
```
**Detects:** Sudden access to new SaaS applications.

---

### 9️⃣ Data Volume Anomaly
```spl
index=network
| stats sum(bytes) by user
| where sum(bytes) > avg(sum(bytes))*3
```
**Detects:** Potential data exfiltration behavior.

---

### 🔟 Off-Hours Activity Drift
```spl
| where date_hour < 7 OR date_hour > 20
```
**Detects:** Behavior occurring outside user baseline time.

---

### 1️⃣1️⃣ Privilege Usage Deviation
```spl
index=auth admin=1
| stats count by user
| where count < 2
```
**Detects:** Rare admin actions by non-admin users.

---

### 1️⃣2️⃣ Authentication Method Change
```spl
| stats dc(auth_method) by user
| where dc(auth_method) > 1
```
**Detects:** Sudden shift in login method (password ➜ token ➜ API).

---

## 🧠 Behavioral Indicators Summary
- Rare or first-time actions
- Sudden spikes in activity
- New locations, IPs, or systems
- Time-of-day deviations
- Privilege behavior changes
- Application usage drift

---

## 🛡️ Response & Mitigation
- Validate user activity with business context
- Enforce step-up authentication (MFA)
- Temporarily restrict access
- Investigate correlated endpoint/network activity
- Update baseline after verified changes

---

## 📌 Final Summary

This file provides **advanced user behavior baselining** across:
- 🪟 Windows
- 🐧 Linux
- ☁️ Cloud environments

It is a **foundational capability for UEBA and advanced threat hunting**, enabling detection of **stealthy account compromise and insider threats**.


