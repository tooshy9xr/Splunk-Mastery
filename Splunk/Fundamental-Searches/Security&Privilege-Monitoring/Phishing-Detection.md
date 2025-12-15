# 🎣 Phishing Detection (Windows, Email & Network)
Fundamental Searches for Phishing Activity

This file focuses on **detecting phishing-related activity** using **logs and events**, suitable for the *Fundamental Searches* level.  
Phishing is often the **initial attack vector** leading to credential theft, malware delivery, and account compromise.

---

## 🎯 Purpose
- Detect **phishing emails and malicious links**
- Identify **user interaction with phishing content**
- Monitor **credential harvesting attempts**
- Correlate email, endpoint, and network activity
- Support SOC investigations and response

---

## 🖥️ Platforms & Data Sources Covered
- 📧 Email Security Gateways (O365, Exchange, Gmail, Secure Email Gateways)
- 🪟 Windows Endpoints
- 🐧 Linux Servers (mail servers, proxies)
- 🌐 Network & Web Proxies
- ☁️ Cloud Identity Providers

---

## 📂 Common Log Sources

### 📧 Email Logs
- Email Gateway logs
- Microsoft 365 / Exchange Message Trace
- Anti-spam / Anti-phishing engine logs

### 🪟 Windows
- Browser history logs
- Security Event Logs
- PowerShell logs
- Endpoint protection logs

### 🌐 Network
- Proxy logs
- DNS logs
- Firewall logs

---

## 🧾 Sample Logs

### 📧 Phishing Email Detected
```
2025-02-13 09:01:22 EmailGateway Action=Quarantine Sender=support@fakebank.com Subject="Verify Your Account"
```

### 📧 User Clicked Phishing Link
```
2025-02-13 09:05:44 O365 User=john.doe ClickedURL=http://fake-login[.]com/login
```

### 🌐 DNS Query to Phishing Domain
```
2025-02-13 09:07:11 DNS Query=fake-login.com SrcIP=192.168.1.55
```

### 🪟 Windows – Credential Prompt via Browser
```
2025-02-13 09:10:33 WIN-WS01 Browser=Chrome URL=http://fake-login.com/login User=john.doe
```

---

## 🔍 Fundamental Search Examples

### 🎣 Phishing Email Detection
```spl
Action=Quarantine OR ThreatType=Phishing
```

### 🔗 Clicked Malicious URLs
```spl
ClickedURL="http*"
| search ClickedURL IN ("*login*","*verify*","*secure*")
```

### 🌐 DNS Queries to Suspicious Domains
```spl
| search Query IN ("*login*","*verify*","*secure*")
```

### 🔐 Possible Credential Harvesting
```spl
| search URL="*login*" AND NOT URL="*trusted-domain*"
```

---

## 🚨 Detection Scenarios

### 👤 User Interaction with Phishing
```spl
| stats count by user ClickedURL
| where count > 1
```

### 🌍 Phishing from Newly Registered Domains
```spl
| search DomainAge < 30
```

### 🔁 Multiple Users Targeted
```spl
| stats dc(user) as users by Sender
| where users > 5
```

---

## 🛡️ Mitigation & Response
- Block malicious domains and URLs
- Force password reset for affected users
- Enable MFA
- Educate users on phishing awareness
- Review mailbox rules and account activity

---

## 📌 Summary
This file provides **fundamental phishing detection coverage** across:
- Email security logs
- Endpoint and browser activity
- DNS and network traffic


