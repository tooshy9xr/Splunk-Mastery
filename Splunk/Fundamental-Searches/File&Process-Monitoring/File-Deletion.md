# 🗑️ File Deletion Monitoring (Windows & Linux)
Fundamental Searches for File Deletion Events

This file focuses on **monitoring file deletion activity** across **Windows and Linux systems**, using **basic searches** suitable for the *Fundamental Searches* level.  
File deletions can indicate **malicious activity, accidental data loss, or security incidents**.

---

## 🎯 Purpose
- Detect **unauthorized file deletions**
- Track **critical system and data file deletions**
- Identify **potential malware or insider threats**
- Support SOC investigations and auditing
- Enable proactive alerting

---

## 🖥️ Platforms Covered
- 🪟 Windows Servers & Workstations
- 🐧 Linux Servers & Endpoints
- ☁️ Cloud Storage Systems (optional logs)

---

## 📂 Common Log Sources

### 🪟 Windows
- Security Event Log  
  - EventID **4660** (Object Deleted)  
  - EventID **4663** (Access Attempted)  
- File system auditing logs
- Recycle Bin monitoring

### 🐧 Linux
- `/var/log/audit/audit.log` (auditd)
- `/var/log/syslog`
- File system change monitoring tools (`inotify`, `auditd`)
- Application-specific logs

---

## 🧾 Sample Logs

### 🪟 Windows – File Deletion
```
2025-02-12 16:01:22 WIN-SRV01 EventID=4660 User=john.doe File=C:\Sensitive\report.xlsx
```

### 🪟 Windows – Access Attempted Before Deletion
```
2025-02-12 16:03:10 WIN-SRV01 EventID=4663 User=john.doe File=C:\Sensitive\report.xlsx Operation=Delete
```

### 🐧 Linux – File Deletion via Auditd
```
Feb 12 16:10:33 server01 audit[1234]: PATH=/home/alice/confidential.txt OP=unlink USER=alice
```

### 🐧 Linux – Application Log
```
Feb 12 16:12:11 server01 app_log: File /var/www/html/config.php deleted by process apache2
```

---

## 🔍 Fundamental Search Examples

### 🗑️ File Deletion Events
```spl
(EventID=4660 OR "unlink") 
| table _time host user file process
```

### 🔎 Unauthorized or Suspicious Deletions
```spl
(EventID=4660 OR "unlink") 
| search file IN ("C:\\Sensitive\\*", "/home/*/confidential*")
```

### 👤 User-Specific File Deletions
```spl
(EventID=4660 OR "unlink") 
| stats count by user file
```

---

## 🚨 Detection Scenarios

### 🔁 Multiple Deletions by One User
```spl
(EventID=4660 OR "unlink")
| stats count by user
| where count > 10
```

### 🧨 Deletion of Critical Files
```spl
| search file IN ("C:\\Windows\\System32\\*", "/etc/passwd", "/var/www/html/config.php")
```

### 🌍 File Deletions from External Access
```spl
| search src_ip!=10.0.0.0/8
```

---

## 🛡️ Mitigation & Response
- Enable file system auditing
- Restrict permissions on sensitive files
- Alert on critical file deletions
- Investigate unusual deletion patterns
- Restore from backups if needed

---

## 📌 Summary
This file provides **fundamental file deletion monitoring** for:
- Windows file system auditing
- Linux auditd and inotify monitoring
- Detection of malicious or unauthorized deletions


