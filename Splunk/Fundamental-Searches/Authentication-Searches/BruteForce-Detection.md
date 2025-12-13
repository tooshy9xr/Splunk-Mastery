# 🚨 Brute Force Detection (Windows & Linux)
Fundamental Searches for Authentication Attack Patterns

This file focuses on **detecting brute-force attacks** across **Windows and Linux systems**, using **basic SPL searches** suitable for the *Fundamental Searches* level.

---

## 🎯 Purpose
- Detect **multiple failed authentication attempts**
- Identify **password spraying**
- Monitor **credential stuffing patterns**
- Highlight **targeted account attacks**
- Support SOC alerting and investigations

---

## 🖥️ Platforms Covered
- 🪟 Windows (AD, RDP, VPN, LDAP)
- 🐧 Linux (SSH, sudo, PAM)
- 🌐 Network Services (VPN, RADIUS)

---

## 📂 Common Log Sources

### 🪟 Windows
- Security Event Log  
  - EventID **4625** (Failed logon)
- RDP logs
- VPN / NPS logs

### 🐧 Linux
- `/var/log/auth.log`
- `/var/log/secure`
- SSH (`sshd`) logs

---

## 🧾 Sample Logs

### 🪟 Windows – Failed Logons
```
2025-02-12 09:11:21 DC01 EventID=4625 User=admin SrcIP=203.0.113.50 Reason=BadPassword
```

### 🪟 Windows – Multiple Accounts
```
2025-02-12 09:12:11 DC01 EventID=4625 User=john SrcIP=203.0.113.50
2025-02-12 09:12:13 DC01 EventID=4625 User=sara SrcIP=203.0.113.50
```

### 🐧 Linux – SSH Failures
```
Feb 12 09:15:22 server01 sshd[2111]: Failed password for root from 203.0.113.50 port 42211 ssh2
```

---

## 🔍 Fundamental Search Examples

### 🔁 Basic Brute Force (By Source IP)
```spl
(EventID=4625) OR (sshd "Failed password")
| stats count by src_ip
| where count > 10
```

### 👤 Password Spraying (Many Users, One IP)
```spl
(EventID=4625) OR (sshd "Failed password")
| stats dc(user) as users by src_ip
| where users > 5
```

### 🎯 Targeted Account Attack
```spl
(EventID=4625 User=admin) OR (sshd "root")
| stats count by src_ip
| where count > 5
```

---

## 🚨 Detection Scenarios

### 🔥 Brute Force from Single IP
- Many failures
- Short time window
```spl
(EventID=4625) OR (sshd "Failed")
| bin _time span=5m
| stats count by src_ip, _time
| where count > 20
```

### 🌍 External Attack Source
```spl
(EventID=4625) OR (sshd "Failed")
| search src_ip!=10.0.0.0/8
```

---

## 🛡️ Mitigation & Response
- Block attacking IP
- Force password reset
- Enable MFA
- Enforce account lockout policies
- Monitor post-attack successful logins

---

## 📌 Summary
This file provides **fundamental brute-force detection coverage** for:
- Windows authentication
- Linux SSH access
- Network authentication services


