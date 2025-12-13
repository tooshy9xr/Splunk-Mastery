# 🔒 Sensitive File Tracking (Windows & Linux)
Fundamental Searches for Monitoring Critical Files

This file focuses on **tracking access and changes to sensitive files** across **Windows and Linux systems**, using **basic searches** suitable for the *Fundamental Searches* level.  
Monitoring sensitive files helps detect **unauthorized access, insider threats, and potential data breaches**.

---

## 🎯 Purpose
- Monitor **access, modification, deletion, and movement** of sensitive files
- Detect **unauthorized or suspicious activity**
- Track **user interaction with critical files**
- Support SOC investigations and auditing
- Enable proactive alerting

---

## 🖥️ Platforms Covered
- 🪟 Windows Servers & Workstations
- 🐧 Linux Servers & Endpoints
- ☁️ Cloud Storage Systems (optional)

---

## 📂 Common Log Sources

### 🪟 Windows
- Security Event Log  
  - EventID **4663** (Object Access)  
  - EventID **4656** (Handle Requested)  
- File system auditing logs
- PowerShell logs

### 🐧 Linux
- `/var/log/audit/audit.log` (auditd)
- `/var/log/syslog`
- File monitoring tools (`inotify`, `auditd`)
- Application-specific logs

---

## 🧾 Sample Logs

### 🪟 Windows – File Access
```
2025-02-12 21:01:22 WIN-SRV01 EventID=4663 User=john.doe File=C:\Sensitive\report.xlsx Operation=Read
```

### 🪟 Windows – File Modification
```
2025-02-12 21:03:10 WIN-SRV01 EventID=4663 User=alice File=C:\Sensitive\report.xlsx Operation=Write
```

### 🐧 Linux – Sensitive File Access
```
Feb 12 21:05:33 server01 audit[1234]: PATH=/home/alice/confidential.txt OP=open USER=alice
```

### 🐧 Linux – Sensitive File Modification
```
Feb 12 21:07:11 server01 audit[5678]: PATH=/etc/passwd OP=write USER=root
```

---

## 🔍 Fundamental Search Examples

### 🔒 Access to Sensitive Files
```spl
(EventID=4663 OR "open") 
| search file IN ("C:\\Sensitive\\*", "/home/*/confidential*", "/etc/passwd")
| table _time host user file operation
```

### ✏️ File Modifications
```spl
(EventID=4663 OR "write")
| search file IN ("C:\\Sensitive\\*", "/home/*/confidential*", "/etc/passwd")
| table _time host user file operation
```

### 👤 User-Specific File Activity
```spl
| stats count by user file operation
```

---

## 🚨 Detection Scenarios

### 🔁 Multiple Access by One User
```spl
| stats count by user
| where count > 10
```

### 🧨 Unauthorized Access
```spl
| search user!="authorized_user"
```

### ⚠️ Modification of Critical System Files
```spl
| search file IN ("C:\\Windows\\System32\\*", "/etc/passwd", "/etc/shadow")
```

---

## 🛡️ Mitigation & Response
- Enable file system auditing
- Restrict access to sensitive files
- Alert on unauthorized access or modifications
- Review access logs regularly
- Restore from trusted backups if necessary

---

## 📌 Summary
This file provides **fundamental sensitive file tracking** for:
- Windows file system auditing
- Linux auditd and inotify monitoring
- Detection of unauthorized or suspicious file access and modifications
