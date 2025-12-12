# 👤 User Behavior Analytics (UBA) — Fundamental Searches

User Behavior Analytics (UBA) focuses on detecting **anomalous, risky, or suspicious user activity** by analyzing behavioral deviations.  
This document provides **Windows + Linux** fundamental searches to identify compromised accounts, insider threats, and abnormal user actions.

---

# 🎯 What UBA Helps Detect
- Account compromise  
- Insider movement  
- Credential misuse  
- Privilege abuse  
- Unusual login times & geolocation anomalies  
- Abnormal file/process access  

---

# 1️⃣ Login Behavior Anomalies  
Detect unusual or risky authentication activity.

---

## 🟦 Windows

### Unusual login times (outside business hours)  
```spl
index=windows EventCode=4624
| eval hour=strftime(_time,"%H")
| where hour < 6 OR hour > 20
| stats count by user host hour
```

### Multiple failed logins followed by success  
```spl
index=windows (EventCode=4625 OR EventCode=4624)
| transaction user maxspan=10m
| search EventCode=4625 EventCode=4624
```

### Logins from multiple hosts in short time  
```spl
index=windows EventCode=4624
| stats dc(host) as host_count values(host) by user
| where host_count > 3
```

---

## 🟩 Linux

### Unusual SSH login times  
```spl
index=linux "Accepted"
| eval hour=strftime(_time,"%H")
| where hour < 6 OR hour > 20
```

### Excessive failed SSH attempts  
```spl
index=linux "Failed password"
| stats count by user src_ip
| where count > 10
```

### SSH logins from new or rare IPs  
```spl
index=linux "Accepted"
| stats count by user src_ip
| where count=1
```

---

# 2️⃣ Privilege Abuse & Role Misuse  
Detect abnormal or risky use of privileged access.

---

## Windows  
### Sudden admin group membership  
```spl
index=windows EventCode=4728 OR EventCode=4732
```

### Unusual use of sensitive commands  
```spl
index=windows EventCode=1
| search ("net user" OR "whoami /priv" OR "wmic process")
```

---

## Linux  
### Abnormal use of sudo  
```spl
index=linux "sudo"
| stats count by user command
```

### Privilege escalation attempts  
```spl
index=linux ("su -" OR "sudo -i" OR "pkexec")
```

---

# 3️⃣ Account Behavior Deviations  
Detect activities unusual compared to a user’s normal profile.

---

## Impossible travel (Geo/IP anomaly)  
```spl
index=* (EventCode=4624 OR "Accepted")
| iplocation src_ip
| stats earliest(_time) as first latest(_time) as last by user Country
| where first+300 < last  AND Country != ""
```

## Sudden spike in user activity  
```spl
index=* 
| stats count as events by user
| eventstats avg(events) as avg stdev(events) as std
| where events > avg + (2*std)
```

## User accessing unusual hosts  
```spl
index=* 
| stats dc(host) as hosts by user
| where hosts > 5
```

---

# 4️⃣ File & System Interaction Abnormalities  
Detect when a user interacts with unusual or sensitive files.

---

## Windows  
### File access outside normal patterns  
```spl
index=windows EventCode=4663
| stats count by user ObjectName
| where count=1
```

### Rare process execution by user  
```spl
index=windows EventCode=1
| stats count by user process_name
| where count=1
```

---

## Linux  
### Unusual system file access  
```spl
index=linux 
| search ("shadow" OR "passwd" OR "/etc/sudoers") 
| stats count by user
```

### User executing rare commands  
```spl
index=linux 
| stats count by user command
| where count=1
```

---

# 5️⃣ Data Access & Exfiltration Patterns  
Detect high data movement or reading sensitive info.

---

## Abnormal outbound data volume  
```spl
index=network bytes_out>50000000
| stats sum(bytes_out) by user src_ip
```

## Users downloading large amounts of files  
```spl
index=* ("download" OR "GET")
| stats count by user
```

## Accessing many different files in short time  
```spl
index=* 
| stats dc(file) as files by user
| where files > 100
```

---

# 📌 Summary  
This UBA fundamentals file includes coverage for:

- Login anomalies  
- Privilege misuse  
- Account behavior deviations  
- File and process anomalies  
- Data exfiltration indicators  

