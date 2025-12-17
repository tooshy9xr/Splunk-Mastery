# 📦⚙️ Software Install & Uninstall Monitoring  
Fundamental Searches for Application Lifecycle Activity  
(Windows • Linux • macOS)

This file focuses on **monitoring software installation and removal events** across **endpoints**, using **basic searches** suitable for the *Fundamental Searches* level.  
Software install/uninstall monitoring is critical for detecting **unauthorized applications, malware installation, policy violations, and persistence mechanisms**.

---

## 🎯 Purpose
- Track **software installations and removals**
- Detect **unauthorized or suspicious applications**
- Identify **malware or unwanted software deployment**
- Monitor **application lifecycle changes**
- Support SOC investigations and endpoint compliance monitoring

---

## 🖥️ Platforms Covered

### 🪟 Windows
- Windows Installer logs (MSI)
- Windows Event Logs (Application & Security)
- Registry-based install events
- Defender / EDR application control logs

### 🐧 Linux
- Package manager logs (APT, YUM, DNF, Zypper)
- Syslog / journalctl
- Application install scripts

### 🍎 macOS
- Unified logs
- Installer and pkg logs
- Endpoint security logs

---

## 📂 Common Log Sources
- OS application and installer logs
- Endpoint Detection & Response (EDR)
- Package manager logs
- Application whitelisting / control logs

---

## 🧾 Sample Logs

### 🪟 Windows – Software Installed
```
2025-03-11 11:01:22 EventID=11707 Product=Google Chrome User=alice
```

### 🪟 Windows – Software Uninstalled
```
2025-03-11 11:03:10 EventID=11724 Product=7-Zip User=bob
```

### 🐧 Linux – Package Installed
```
Mar 11 11:05:33 host01 apt: Installed python3-pip
```

### 🍎 macOS – Application Installed
```
2025-03-11 11:07:11 Installer App=Slack User=john
```

---

## 🔍 Fundamental Search Examples

### 📦 All Software Installations
```spl
| search EventID=11707 OR "Installed"
| table _time user host Product
```

### 🗑 Software Removals
```spl
| search EventID=11724 OR "Removed"
```

### 🚫 Unauthorized Software
```spl
| search Product NOT IN ("ApprovedApp1","ApprovedApp2")
```

### 🔁 Frequent Install/Uninstall Activity
```spl
| stats count by user Product
| where count > 3
```

---

## 🚨 Detection Scenarios

### 🧨 Malware or Unauthorized Tool Installation
```spl
| search Product IN ("mimikatz","nmap","netcat")
```

### ⚠️ Installations Outside Business Hours
```spl
| where date_hour < 8 OR date_hour > 18
```

### 🕵️ Install Activity by Non-Admin Users
```spl
| search user!="admin"
```

---

## 🛡️ Mitigation & Response
- Enforce application allowlists
- Restrict installation privileges
- Alert on unauthorized software changes
- Remove suspicious applications immediately
- Correlate install activity with endpoint and network logs

---

## 📌 Summary
This file provides **fundamental monitoring of software installation and removal** across:
- 🪟 Windows
- 🐧 Linux
- 🍎 macOS

It helps detect **unauthorized applications, malware installs, and policy violations**.


