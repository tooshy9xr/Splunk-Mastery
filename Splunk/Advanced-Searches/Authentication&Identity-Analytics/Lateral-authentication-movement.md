# 🔄🔐 Lateral Authentication Movement  
Advanced Detection of Lateral Movement via Valid Credentials  
(Windows • Linux • Cloud)

---

## 🎯 Objective
Detect **east–west authentication movement** where attackers reuse **valid credentials** to access multiple systems across **on-prem and cloud environments** after initial compromise.

This file contains **multiple advanced detection patterns (10+)** covering:
- Windows
- Linux
- Cloud & SaaS environments

---

## 📊 Data Sources
- Windows Security Event Logs (4624, 4672)
- Linux SSH / PAM logs
- VPN logs
- Active Directory / LDAP
- Cloud IAM (Azure AD, AWS CloudTrail, GCP IAM)
- SaaS authentication logs

---

## 🔍 Advanced Detection Commands (Detailed)

---

### 1️⃣ Rapid Authentication to Multiple Hosts (Windows/Linux)
```spl
index=auth action=success
| stats dc(host) as host_count values(host) as hosts by user
| where host_count > 3
```
**Detects:** Credential reuse for lateral movement.

---

### 2️⃣ Sequential Logins in Short Time Window
```spl
index=auth action=success
| transaction user maxspan=15m
| stats count values(host) by user
| where count > 3
```
**Detects:** Automated or attacker-driven authentication chains.

---

### 3️⃣ Lateral Movement After VPN Access
```spl
index=vpn action=success
| join user
  [ search index=auth action=success ]
```
**Detects:** External access pivoting into internal systems.

---

### 4️⃣ Linux SSH Lateral Movement
```spl
index=linux sshd "Accepted password"
| stats dc(host) by user
| where dc(host) > 3
```
**Detects:** SSH-based east–west movement.

---

### 5️⃣ Windows Admin Logons Across Hosts
```spl
index=wineventlog EventID=4624 LogonType=10
| stats dc(host) by user
| where dc(host) > 2
```
**Detects:** Remote admin access spread.

---

### 6️⃣ Privileged Account Lateral Use
```spl
index=auth action=success
| search user IN ("admin","root","svc_*")
| stats dc(host) by user
| where dc(host) > 2
```
**Detects:** Abuse of high-value accounts.

---

### 7️⃣ Authentication to Sensitive Systems
```spl
index=auth action=success
| search host IN ("DC","DB","ERP","Finance")
```
**Detects:** Movement toward critical assets.

---

### 8️⃣ Cloud Cross-Service Authentication
```spl
index=cloud action=success
| stats dc(service) as service_count by user
| where service_count > 2
```
**Detects:** Lateral movement across SaaS or cloud services.

---

### 9️⃣ Azure AD Cross-App Sign-ins
```spl
index=azuread OperationName="Sign-in"
| stats dc(AppDisplayName) by UserPrincipalName
| where dc(AppDisplayName) > 3
```
**Detects:** Identity expansion in cloud tenants.

---

### 🔟 AWS IAM Role Chaining
```spl
index=cloudtrail eventName="AssumeRole"
| stats dc(requestParameters.roleArn) by userIdentity.arn
| where dc(requestParameters.roleArn) > 2
```
**Detects:** Role pivoting and privilege expansion.

---

### 1️⃣1️⃣ Rare Host Authentication
```spl
index=auth action=success
| stats count by user host
| where count < 2
```
**Detects:** First-time access to new systems.

---

### 1️⃣2️⃣ Off-Hours Lateral Movement
```spl
index=auth action=success
| where date_hour < 7 OR date_hour > 19
| stats dc(host) by user
| where dc(host) > 2
```
**Detects:** Suspicious activity outside normal hours.

---

## 🧠 Behavioral Indicators Summary
- Rapid access expansion
- Multi-host authentication
- Privileged account misuse
- Cross-platform identity abuse
- Cloud service hopping

---

## 🛡️ Response & Mitigation
- Disable affected accounts
- Rotate credentials and keys
- Investigate accessed hosts
- Restrict east–west access
- Enforce conditional access & MFA

---

## 📌 Summary
This file provides **12 advanced SPL detection patterns** for identifying **lateral authentication movement** across:
- 🪟 Windows
- 🐧 Linux
- ☁️ Cloud environments

It focuses on **attack chains**, not single events, and is designed for **advanced SOC and threat-hunting operations**.

