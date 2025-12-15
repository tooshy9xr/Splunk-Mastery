# 🧨 Ransomware Detection (Windows & Linux)
Fundamental Searches for Ransomware Activity

This file focuses on **detecting ransomware-related behavior** across **Windows and Linux systems**, using **basic searches** suitable for the *Fundamental Searches* level.  
Ransomware detection relies on identifying **abnormal file activity, process behavior, and system changes**.

---

## 🎯 Purpose
- Detect **early-stage ransomware execution**
- Monitor **mass file encryption or deletion**
- Identify **suspicious processes and scripts**
- Detect **persistence and lateral movement indicators**
- Support SOC investigations and rapid response

---

## 🖥️ Platforms Covered
- 🪟 Windows Servers & Workstations  
- 🐧 Linux Servers & Endpoints  
- ☁️ Cloud-hosted VMs  

---

## 📂 Common Log Sources

### 🪟 Windows
- Security Event Log (EventID **4688** – Process Creation)  
- File system auditing (EventID **4663**)  
- PowerShell logs (EventID **4104**)  
- Sysmon (Process & File Events)

### 🐧 Linux
- `auditd` logs (`/var/log/audit/audit.log`)  
- `/var/log/syslog`  
- File monitoring tools (`inotify`)  
- Cron and scheduled task logs  

---

## 🧾 Sample Logs

### 🪟 Windows – Suspicious Encryption Process
```
2025-02-14 10:01:22 WIN-WS01 EventID=4688 User=john.doe NewProcessName=C:\Temp\encrypt.exe
```

### 🪟 Windows – Mass File Modification
```
2025-02-14 10:03:10 WIN-WS01 EventID=4663 User=john.doe File=C:\Users\john\Documents\file1.docx Operation=Write
```

### 🐧 Linux – Encryption Script Execution
```
Feb 14 10:05:33 server01 audit[1234]: USER=alice CMD=/tmp/encrypt.sh
```

### 🐧 Linux – Mass File Renaming
```
Feb 14 10:07:11 server01 audit[5678]: PATH=/home/alice/*.locked OP=rename
```

---

## 🔍 Fundamental Search Examples

### 🧨 Suspicious Process Execution
```spl
EventID=4688 OR "CMD"
| search NewProcessName IN ("*encrypt*","*crypt*","*locker*")
```

### 📁 Mass File Modifications
```spl
EventID=4663 OR "write"
| stats count by user host
| where count > 100
```

### 🧾 Script-Based Ransomware
```spl
EventID=4104 OR "CMD"
| search Command="*encrypt*" OR Command="*base64*"
```

---

## 🚨 Detection Scenarios

### 🔁 Rapid File Changes by Single User
```spl
| stats count by user
| where count > 200
```

### 🧨 Execution from Temporary Directories
```spl
| search NewProcessName IN ("C:\\Temp\\*", "/tmp/*")
```

### 🔐 Privilege Escalation Followed by Encryption
```spl
| search NewProcessName IN ("*vssadmin*", "*wbadmin*")
```

---

## 🛡️ Mitigation & Response
- Immediately isolate affected systems
- Terminate suspicious processes
- Disable compromised accounts
- Restore from verified backups
- Block indicators of compromise (IOCs)

---

## 📌 Summary
This file provides **fundamental ransomware detection coverage** for:
- Windows and Linux endpoints
- Process, file, and script activity
- Early detection and response use cases


