# 📝 Event Logs (Windows & Linux)
Fundamental Searches for Operating System and Application Events

This file focuses on **collecting and analyzing event logs** across **Windows and Linux systems**, using **basic searches** suitable for the *Fundamental Searches* level.  
Event logs provide critical insights into **system health, security incidents, and application behavior**.

---

## 🎯 Purpose
- Monitor **system, security, and application events**
- Detect **errors, warnings, and failures**
- Track **user logins and activity**
- Support SOC and operational investigations
- Serve as a foundation for advanced searches, dashboards, and alerts

---

## 🖥️ Platforms Covered
- 🪟 Windows Servers & Workstations
- 🐧 Linux Servers & Endpoints
- ☁️ Cloud-hosted VMs

---

## 📂 Common Log Sources

### 🪟 Windows
- Event Viewer  
  - **System**: OS errors, warnings, service issues  
  - **Security**: Logons, privilege changes, policy modifications  
  - **Application**: Application errors and crashes  
- WMI logs  
- IIS or other service logs

### 🐧 Linux
- `/var/log/syslog`  
- `/var/log/messages`  
- `/var/log/auth.log`  
- `journalctl` (systemd logs)  
- Application-specific logs (`nginx`, `apache2`, `mysql`)

---

## 🧾 Sample Logs

### 🪟 Windows – System Event
```
2025-02-12 13:01:21 WIN-SRV01 EventID=7036 Service=Spooler Status=Running
```

### 🪟 Windows – Security Event (Login)
```
2025-02-12 13:05:44 WIN-SRV01 EventID=4624 User=john.doe LogonType=2 SrcIP=192.168.1.10
```

### 🪟 Windows – Application Error
```
2025-02-12 13:10:33 WIN-SRV01 EventID=1000 Application=svchost.exe FaultingModule=ntdll.dll
```

### 🐧 Linux – System Message
```
Feb 12 13:15:22 server01 systemd[1]: nginx.service failed with result 'exit-code'
```

### 🐧 Linux – Authentication Event
```
Feb 12 13:17:11 server01 sshd[2111]: Accepted password for alice from 203.0.113.77 port 51422 ssh2
```

### 🐧 Linux – Application Log
```
Feb 12 13:20:44 server01 mysql[3221]: Error: Table 'employees' doesn't exist
```

---

## 🔍 Fundamental Search Examples

### 🖥️ Windows System & Security Events
```spl
index=windows_logs (EventID=4624 OR EventID=4625 OR EventID=7036)
| table _time host EventID User Status
```

### 🐧 Linux Syslog & Auth Logs
```spl
index=linux_logs sourcetype=syslog OR sourcetype=auth.log
| table _time host process message
```

### ⚠️ Errors and Warnings
```spl
(index=windows_logs OR index=linux_logs)
| search "error" OR "failed" OR "warning"
```

---

## 🚨 Detection Scenarios

### 🔁 Frequent Service Failures
```spl
index=windows_logs EventID=7036
| stats count by Service Status
| where Status="Stopped" AND count > 2
```

### 🧑‍💻 Suspicious Logins
```spl
index=windows_logs EventID=4624 OR index=linux_logs "Accepted password"
| stats count by user src_ip
| where count > 10
```

### 💥 Application Errors
```spl
index=windows_logs EventID=1000 OR index=linux_logs "error"
| stats count by Application process
```

---

## 🛡️ Mitigation & Response
- Investigate repeated system/service errors
- Alert on unusual login patterns
- Patch or restart failing applications
- Track configuration changes
- Correlate logs with security incidents

---

## 📌 Summary
This file provides **fundamental event log monitoring** for:
- Windows System, Security, and Application logs
- Linux Syslog, Auth, and Application logs
- Operational health and security insights


