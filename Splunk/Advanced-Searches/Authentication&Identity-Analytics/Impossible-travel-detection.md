# 🌍✈️ Impossible Travel Detection  
Advanced Detection of Geographically Impossible Logins  
(Windows • Linux • Cloud)

---

## 📁 Folder Context (Professional Description)

The **Impossible Travel Detection** folder focuses on identifying **logins from geographically distant locations within an implausibly short timeframe**, a common sign of credential compromise.  

This technique is critical for:
- Detecting stolen credentials
- Identifying session hijacking
- Preventing lateral movement
- Protecting hybrid and cloud environments

It applies to **Windows, Linux, and Cloud authentication logs**.

---

## 🎯 File Objective

`Impossible-travel-detection.md` provides **advanced SPL detection logic** to:
- Identify suspicious rapid cross-geography logins
- Correlate multi-platform authentication events
- Reduce false positives through baseline and enrichment
- Support proactive SOC alerting and threat hunting

---

## 🧩 Threat Context

Mapped to **MITRE ATT&CK**:
- TA0006 – Credential Access  
- T1078 – Valid Accounts  

Attackers often:
1. Steal credentials (phishing, malware, leaks)
2. Authenticate from multiple distant locations quickly
3. Attempt lateral movement or cloud tenant abuse

---

## 📊 Data Sources

| Source | Description |
|--------|-------------|
| Windows Event Logs | Successful logins with source IP and location |
| Linux SSH Logs | SSH login with IP tracking |
| Cloud IAM / SaaS Logs | Login events across regions and services |
| VPN Logs | Remote access from external networks |
| GeoIP Enrichment | Map IPs to physical locations |

---

## 🔍 Advanced Detection Logic (10+ Scenarios)

---

### 1️⃣ Rapid Cross-Country Login
```spl
index=auth action=success
| iplocation src_ip
| stats earliest(_time) as first latest(_time) as last dc(Country) as country_count by user
| where country_count > 1 AND (last-first) < 3600
```
**Detects:** Logins from multiple countries within 1 hour.

---

### 2️⃣ Cross-Continent Login
```spl
| where Country IN ("US","CN","RU","BR") AND user!=service_account
```
**Detects:** Access from unlikely continental locations.

---

### 3️⃣ Rapid Internal-to-Cloud Login
```spl
index=cloud action=success
| join user [ search index=auth action=success ]
```
**Detects:** Same user accessing internal and cloud systems rapidly.

---

### 4️⃣ Impossible Travel with MFA Success
```spl
index=mfa action=success
| iplocation src_ip
| stats dc(Country) as countries by user
| where countries > 1
```
**Detects:** MFA success across distant locations within short timeframe.

---

### 5️⃣ Remote Login to Sensitive Host after Travel
```spl
index=auth action=success host IN ("DC","DB","ERP")
| iplocation src_ip
| stats earliest(_time) as first latest(_time) as last by user
| where last-first < 3600
```
**Detects:** Rapid access to high-value systems after remote login.

---

### 6️⃣ Off-Hours Impossible Travel
```spl
| where date_hour < 7 OR date_hour > 20
| stats dc(Country) as countries by user
| where countries > 1
```
**Detects:** Logins outside normal working hours across distant locations.

---

### 7️⃣ Impossible Travel to Cloud Services
```spl
index=cloud action=success
| iplocation src_ip
| stats dc(Country) as country_count values(AppDisplayName) as apps by user
| where country_count > 1
```
**Detects:** Cloud account compromise with unusual access pattern.

---

### 8️⃣ Suspicious IP Jump Detection
```spl
index=auth OR index=cloud
| iplocation src_ip
| transaction user maxspan=1h
| search dc(Country)>1
```
**Detects:** Rapid IP changes across locations.

---

### 9️⃣ Impossible Travel with Account Elevation
```spl
| search action=success AND admin=1
| iplocation src_ip
| stats dc(Country) as countries by user
| where countries > 1
```
**Detects:** Admin account compromise spanning multiple geographies.

---

### 🔟 Historical Baseline Comparison
```spl
| stats dc(Country) as country_count by user
| where country_count > 2 AND last_login > historical_avg
```
**Detects:** Rare geographic login deviations compared to user baseline.

---

## 🧠 Behavioral Indicators
- Multi-country logins in short period
- Unusual combinations of internal and cloud systems
- Off-hours login from unexpected locations
- Elevated account activity post-remote login

---

## 🛡️ Response & Mitigation
- Force password reset
- Temporarily block suspicious IPs
- Enforce MFA and conditional access
- Investigate accessed systems
- Alert SOC analysts with geo-context

---

## 📌 Summary
This file provides **advanced SPL searches for impossible travel detection** across:
- 🪟 Windows
- 🐧 Linux
- ☁️ Cloud environments

It enables detection of **compromised credentials and session hijacking**, forming a key part of **advanced threat hunting**.
