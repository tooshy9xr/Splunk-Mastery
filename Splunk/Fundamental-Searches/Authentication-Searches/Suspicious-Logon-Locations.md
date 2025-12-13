# 🌍 Suspicious Logon Locations (Windows & Linux)
Fundamental Searches for Geographic & Location-Based Login Anomalies

This file focuses on **detecting suspicious login locations** across **Windows and Linux environments**, using **basic searches** suitable for the *Fundamental Searches* level.  
Location-based anomalies are common indicators of **account compromise**.

---

## 🎯 Purpose
- Detect **logins from unusual countries or regions**
- Identify **impossible travel scenarios**
- Monitor **remote access from high-risk locations**
- Correlate VPN vs non-VPN access
- Support SOC investigations

---

## 🖥️ Platforms Covered
- 🪟 Windows (AD, RDP, VPN, Azure AD)
- 🐧 Linux (SSH, PAM)
- ☁️ Cloud Identity Providers

---

## 📂 Common Log Sources

### 🪟 Windows / Cloud
- Security Event Log  
  - EventID **4624** (Successful logon)
- Azure AD Sign-In Logs
- VPN authentication logs

### 🐧 Linux
- `/var/log/auth.log`
- SSH (`sshd`) logs

---

## 🧾 Sample Logs

### 🪟 Windows – Successful Logon
```
2025-02-12 08:45:21 DC01 EventID=4624 User=john SrcIP=198.51.100.44 LogonType=10
```

### 🪟 Azure AD – Cloud Login
```
2025-02-12 08:47:11 AzureAD User=john Country=RU Result=Success SrcIP=198.51.100.44
```

### 🐧 Linux – SSH Login
```
Feb 12 08:51:33 server01 sshd[2111]: Accepted password for sara from 203.0.113.77 port 51422 ssh2
```

---

## 🔍 Fundamental Search Examples

### 🌍 Logons with Geo Location
```spl
(EventID=4624) OR (sshd "Accepted")
| iplocation src_ip
| table _time user src_ip Country City
```

### 🚨 Logons from High-Risk Countries
```spl
| iplocation src_ip
| search Country IN ("RU","IR","KP","CN")
```

### ✈️ Impossible Travel Detection
```spl
(EventID=4624) OR (AzureAD Result=Success)
| iplocation src_ip
| sort user _time
| streamstats current=f last(_time) as last_time last(Country) as last_country by user
| eval time_diff=_time-last_time
| where time_diff < 3600 AND Country!=last_country
```

---

## 🚨 Detection Scenarios

### 🔑 Successful Login from New Country
```spl
(EventID=4624)
| iplocation src_ip
| stats dc(Country) as countries by user
| where countries > 1
```

### 🔐 Login Outside Business Hours
```spl
(EventID=4624)
| eval hour=strftime(_time,"%H")
| where hour < 6 OR hour > 20
```

---

## 🛡️ Mitigation & Response
- Enforce MFA
- Require VPN for remote access
- Block high-risk regions
- Alert on impossible travel
- Review account activity

---

## 📌 Summary
This file provides **fundamental location-based login detection** for:
- Windows authentication
- Linux SSH access
- Cloud identity providers
