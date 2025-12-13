# 🔐 MFA Authentication (Windows & Linux)
Fundamental Searches for Multi-Factor Authentication Events

This file focuses on **Multi-Factor Authentication (MFA)** activity across **Windows and Linux environments**, using **basic searches** suitable for *Fundamental Searches*.

---

## 🎯 Purpose
- Monitor **successful and failed MFA challenges**
- Detect **MFA fatigue / push abuse**
- Identify **authentication without MFA**
- Track **remote access and high-risk logins**
- Support SOC investigations

---

## 🖥️ Platforms & MFA Providers
- 🪟 Windows (Azure AD / Entra ID, AD FS)
- 🐧 Linux (PAM MFA integrations)
- 🔐 MFA Providers  
  - Duo  
  - Microsoft Authenticator  
  - Okta  
  - Google Authenticator (log style)

---

## 📂 Common Log Sources

### 🪟 Windows / Cloud
- Azure AD / Entra ID Sign-In Logs
- Windows Security Event Log
- AD FS Logs

### 🐧 Linux
- `/var/log/auth.log`
- PAM MFA modules
- Vendor MFA agent logs

---

## 🧾 Sample MFA Logs

### 🪟 Windows – MFA Success
```
2025-02-12 09:45:21 AzureAD SignIn User=john.doe Method=Push Result=Success SrcIP=192.168.1.55
```

### 🪟 Windows – MFA Failure
```
2025-02-12 09:47:11 AzureAD SignIn User=admin Method=OTP Result=Failure SrcIP=203.0.113.77
```

### 🪟 Windows – MFA Challenge Denied
```
2025-02-12 09:49:33 AzureAD SignIn User=sara Method=Push Result=Denied SrcIP=198.51.100.25
```

---

### 🐧 Linux – MFA Success (PAM + Duo)
```
Feb 12 10:01:22 server01 pam_duo(sshd:auth): authentication success for user mike from 203.0.113.98
```

### 🐧 Linux – MFA Failure
```
Feb 12 10:03:11 server01 pam_duo(sshd:auth): authentication failure for user root from 203.0.113.98
```

### 🐧 Linux – MFA Bypass Attempt
```
Feb 12 10:05:44 server01 pam_unix(sshd:auth): authentication failure bypass_attempt user=guest
```

---

## 🔍 Fundamental Search Examples

### 🔐 Successful MFA Authentication
```spl
(AzureAD Result=Success) OR (pam_duo "authentication success")
```

### ❌ Failed MFA Attempts
```spl
(AzureAD Result=Failure) OR (pam_duo "authentication failure")
```

### 🚨 MFA Push Fatigue Detection
```spl
(AzureAD Method=Push Result=Failure)
| stats count by user
| where count > 5
```

---

## 🚨 Basic Detection Use Cases

### 🔁 MFA Push Abuse
- Multiple push requests in short time
```spl
AzureAD Method=Push
| stats count by user src_ip
| where count > 10
```

### 🌍 MFA from New Location
```spl
AzureAD Result=Success
| iplocation SrcIP
| search Country!="YourCountry"
```

### 👑 Admin MFA Login
```spl
(AzureAD User=admin) OR (pam_duo user=root)
```

---

## 🛡️ MFA Security Best Practices
- Enforce MFA for all remote access
- Monitor push denial patterns
- Alert on MFA bypass attempts
- Restrict admin access tightly
- Correlate MFA with VPN and SSH

---

## 📌 Summary
This file provides **fundamental MFA authentication monitoring** across:
- 🪟 Windows / Cloud identity systems
- 🐧 Linux PAM-based MFA


