# ❌ Audit Failures Monitoring (Windows & Linux)
Fundamental Searches for Failed Security Audits

This file focuses on **detecting audit failures** across **Windows and Linux systems**, using **basic searches** suitable for the *Fundamental Searches* level.  
Audit failures often indicate **unauthorized access attempts, misconfigurations, privilege abuse, or active attacks**.

---

## 🎯 Purpose
- Detect **failed access attempts** to systems and resources
- Monitor **authentication and authorization failures**
- Identify **misconfigured permissions and policies**
- Support SOC investigations and compliance auditing
- Enable early detection of malicious activity

---

## 🖥️ Platforms Covered
- 🪟 Windows Servers & Workstations  
- 🐧 Linux Servers & Endpoints  
- ☁️ Identity & Authentication Services  

---

## 📂 Common Audit Failure Types

### 🔐 Authentication Failures
- Failed logins
- Invalid credentials
- Expired passwords
- MFA failures

### 🛂 Authorization Failures
- Access denied to files or resources
- Privilege escalation failures
- Restricted command execution

### ⚙️ System & Policy Failures
- Group policy failures
- Audit policy misconfigurations
- Security control enforcement failures

---

## 📂 Common Log Sources

### 🪟 Windows
- Security Event Log  
  - **4625** – Failed logon  
  - **4670** – Permission change failure  
  - **4907** – Audit policy change failure  
- Group Policy logs

### 🐧 Linux
- `/var/log/auth.log`  
- `/var/log/secure`  
- `auditd` logs  
- PAM authentication logs  

---

## 🧾 Sample Logs

### 🪟 Windows – Failed Logon
```
2025-02-18 16:01:22 WIN-WS01 EventID=4625 User=john.doe LogonType=10 FailureReason=BadPassword
```

### 🪟 Windows – Access Denied
```
2025-02-18 16:03:10 WIN-SRV01 EventID=4670 User=alice Object=C:\Secure\Data.txt Status=AccessDenied
```

### 🐧 Linux – Failed Authentication
```
Feb 18 16:05:33 server01 sshd[1234]: Failed password for invalid user admin from 10.10.10.5
```

### 🐧 Linux – Authorization Failure
```
Feb 18 16:07:11 server01 sudo: bob : user NOT in sudoers
```

---

## 🔍 Fundamental Search Examples

### ❌ Failed Authentication Events
```spl
EventID=4625 OR "Failed password"
```

### 🛂 Access Denied Events
```spl
EventID=4670 OR "AccessDenied"
```

### 👤 User-Focused Audit Failures
```spl
| stats count by user
```

---

## 🚨 Detection Scenarios

### 🔁 Multiple Failures from Same User
```spl
| stats count by user
| where count > 5
```

### 🌍 Brute Force Indicators
```spl
| stats count by src_ip
| where count > 10
```

### ⚠️ Privileged Account Audit Failures
```spl
| search user IN ("Administrator","root")
```

---

## 🛡️ Mitigation & Response
- Lock or monitor accounts with repeated failures
- Enforce strong password and MFA policies
- Review access control lists and permissions
- Investigate potential brute-force or misuse attempts
- Correct misconfigured audit or security policies

---

## 📌 Summary
This file provides **fundamental audit failure monitoring** for:
- Authentication and authorization failures
- Windows and Linux audit logs
- Early detection of attacks and misconfigurations


