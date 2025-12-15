# 🧩 IOC Monitoring (Indicators of Compromise)
Fundamental Searches for Threat Indicators

This file focuses on **monitoring Indicators of Compromise (IOCs)** across **endpoints, network, email, and security logs**, using **basic searches** suitable for the *Fundamental Searches* level.  
IOC monitoring helps detect **known malicious activity** such as compromised IPs, domains, hashes, URLs, and file names.

---

## 🎯 Purpose
- Detect **known malicious indicators**
- Correlate IOCs across multiple data sources
- Identify **infected or compromised systems**
- Support **threat hunting and incident response**
- Enable proactive security monitoring

---

## 🖥️ Platforms & Data Sources Covered
- 🪟 Windows Endpoints  
- 🐧 Linux Servers  
- 🌐 Network Devices (Firewall, Proxy, IDS/IPS)  
- 📧 Email Security Systems  
- ☁️ Cloud & SaaS Logs  

---

## 📂 Common IOC Types

### 🌐 Network IOCs
- Malicious IP addresses  
- Suspicious domains  
- Known bad URLs  

### 🧾 Endpoint IOCs
- File hashes (MD5, SHA1, SHA256)  
- Malicious file names  
- Suspicious process names  

### 📧 Email IOCs
- Malicious sender addresses  
- Phishing domains  
- Malicious attachments  

---

## 📂 Common Log Sources

### 🪟 Windows
- Security Event Log (EventID **4688**, **4663**)  
- Sysmon logs  
- Defender / EDR logs  

### 🐧 Linux
- `auditd` logs  
- `/var/log/syslog`  
- Application logs  

### 🌐 Network
- DNS logs  
- Proxy logs  
- Firewall logs  

---

## 🧾 Sample Logs

### 🌐 Malicious IP Connection
```
2025-02-15 11:01:22 Firewall SrcIP=192.168.1.55 DestIP=185.220.101.1 Action=Allowed
```

### 🪟 Windows – Malicious Hash Execution
```
2025-02-15 11:03:10 WIN-WS01 EventID=4688 User=alice Hash=5f4dcc3b5aa765d61d8327deb882cf99
```

### 🐧 Linux – Malicious Script Execution
```
Feb 15 11:05:33 server01 audit[1234]: USER=root CMD=/tmp/bad_script.sh
```

### 📧 Email – Malicious Sender
```
2025-02-15 11:07:44 EmailGateway Sender=hacker@evil.com Action=Blocked
```

---

## 🔍 Fundamental Search Examples

### 🌐 Known Bad IP Addresses
```spl
| search DestIP IN ("185.220.101.1","45.153.160.98")
```

### 🌍 Malicious Domains
```spl
| search Domain IN ("evil.com","bad-domain.net")
```

### 🧾 File Hash Matching
```spl
| search Hash IN ("5f4dcc3b5aa765d61d8327deb882cf99","e99a18c428cb38d5f260853678922e03")
```

### 📧 Phishing Email Indicators
```spl
| search Sender IN ("hacker@evil.com","phish@fakebank.com")
```

---

## 🚨 Detection Scenarios

### 🔁 Repeated IOC Hits
```spl
| stats count by DestIP
| where count > 3
```

### 👤 Multiple Hosts Contacting Same IOC
```spl
| stats dc(host) as hosts by DestIP
| where hosts > 1
```

### ⚡ IOC + Suspicious Process
```spl
| search NewProcessName IN ("*powershell*","*cmd*")
```

---

## 🛡️ Mitigation & Response
- Block malicious IPs, domains, and URLs
- Quarantine infected endpoints
- Reset compromised credentials
- Update IOC feeds regularly
- Correlate IOCs with behavior-based detection

---

## 📌 Summary
This file provides **fundamental IOC monitoring coverage** for:
- Network, endpoint, and email indicators
- Known threats and malicious artifacts
- SOC detection, hunting, and response


