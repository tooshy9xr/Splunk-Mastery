# 🔐 SSH Sessions Monitoring (Linux & Network)
Fundamental Searches for SSH Authentication & Session Activity

This file focuses on **monitoring SSH sessions** across **Linux systems and network devices**, using **basic searches** suitable for the *Fundamental Searches* level.  
SSH monitoring is essential for detecting **unauthorized access, brute-force attacks, and suspicious remote administration activity**.

---

## 🎯 Purpose
- Track **successful and failed SSH logins**
- Monitor **active SSH sessions**
- Detect **brute-force and credential stuffing attempts**
- Identify **suspicious source IPs and locations**
- Support SOC investigations and incident response

---

## 🖥️ Platforms Covered
- 🐧 Linux Servers & Endpoints  
- 🌐 Network Devices (routers, switches, firewalls)  
- ☁️ Cloud-based Linux instances  

---

## 📂 Common SSH Event Types

### 🔑 Authentication Events
- Successful SSH login
- Failed SSH login
- Invalid user login attempts

### 🔄 Session Events
- SSH session opened
- SSH session closed
- Session timeout or disconnect

### 🌍 Connection Metadata
- Source IP address
- Username
- Authentication method (password, key)

---

## 📂 Common Log Sources

### 🐧 Linux
- `/var/log/auth.log`  
- `/var/log/secure`  
- `sshd` logs  
- `auditd` logs  

### 🌐 Network Devices
- Syslog (SSH access logs)  

---

## 🧾 Sample Logs

### 🐧 Linux – Successful SSH Login
```
Feb 20 19:01:22 server01 sshd[1234]: Accepted password for alice from 8.8.8.8 port 51234
```

### 🐧 Linux – Failed SSH Login
```
Feb 20 19:03:10 server01 sshd[5678]: Failed password for invalid user admin from 185.220.101.1
```

### 🐧 Linux – SSH Session Closed
```
Feb 20 19:05:33 server01 sshd[1234]: pam_unix(sshd:session): session closed for user alice
```

### 🌐 Network Device – SSH Access
```
2025-02-20 19:07:11 router01 SSH login user=netadmin src=10.10.10.5
```

---

## 🔍 Fundamental Search Examples

### 🔐 Successful SSH Logins
```spl
"Accepted password" OR "Accepted publickey"
```

### ❌ Failed SSH Logins
```spl
"Failed password" OR "invalid user"
```

### 🌍 SSH Sessions from Suspicious IPs
```spl
| search src_ip IN ("185.220.101.1","45.153.160.98")
```

---

## 🚨 Detection Scenarios

### 🔁 Brute-Force SSH Attempts
```spl
| stats count by src_ip
| where count > 10
```

### 👤 Multiple Failed Logins for Same User
```spl
| stats count by user
| where count > 5
```

### ⚠️ SSH Access Outside Business Hours
```spl
| search hour < 7 OR hour > 19
```

---

## 🛡️ Mitigation & Response
- Enforce key-based authentication
- Disable password authentication where possible
- Block malicious IPs via firewall
- Monitor privileged SSH access
- Enable MFA or jump hosts

---

## 📌 Summary
This file provides **fundamental SSH session monitoring** for:
- Linux SSH authentication and sessions
- Network device SSH access
- Detection of unauthorized and malicious remote access
