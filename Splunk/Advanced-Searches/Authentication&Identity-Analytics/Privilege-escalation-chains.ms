# ⬆️🛡️ Privilege Escalation Chains  
Advanced Detection of Multi-Step Privilege Escalation  
(Windows • Linux • Cloud)

---

## 📁 Folder Context (Professional Description)

The **Privilege Escalation Chains** module focuses on detecting **multi-step attack progressions** where an attacker moves from a **low-privileged account** to **administrative or root-level access**.

Unlike single privilege escalation alerts, this file tracks **chains of related events** that together indicate a **successful escalation path**.

This is a **core advanced-detection topic** for:
- SOC Tier 2 / Tier 3
- Threat hunters
- Detection engineers
- Incident response teams

---

## 🎯 File Objective

`Privilege-escalation-chains.md` aims to:
- Detect **step-by-step privilege escalation**
- Correlate authentication, process, and permission changes
- Identify escalation across **Windows, Linux, and Cloud**
- Expose stealthy abuse of legitimate tools and roles

---

## 🧩 Threat Context

Mapped to **MITRE ATT&CK**:
- TA0004 – Privilege Escalation  
- T1068 – Exploitation for Privilege Escalation  
- T1078 – Valid Accounts  
- T1548 – Abuse Elevation Control Mechanism  

Attackers often:
1. Gain user-level access
2. Enumerate permissions
3. Abuse misconfigurations or credentials
4. Escalate to admin/root/cloud-admin
5. Establish persistence

---

## 📊 Data Sources

| Source | Description |
|------|------------|
| Windows Security Logs | Logon, privilege use, admin group changes |
| Linux Audit / SSH Logs | sudo, su, permission changes |
| Endpoint Process Logs | Parent-child execution chains |
| Cloud IAM Logs | Role assignments and privilege grants |
| EDR / XDR | Behavioral escalation telemetry |

---

## 🔍 Advanced Privilege Escalation Chains (12 Patterns)

---

### 1️⃣ User Login ➜ Admin Logon (Windows)
```spl
index=wineventlog EventID=4624
| transaction user maxspan=30m
| search LogonType=2 AND LogonType=10
```
**Detects:** Local user login followed by remote admin access.

---

### 2️⃣ Linux User ➜ sudo ➜ root
```spl
index=linux ("sudo" OR "su")
| transaction user maxspan=15m
```
**Detects:** Command-based escalation to root.

---

### 3️⃣ New Admin Group Membership
```spl
index=wineventlog EventID=4728 OR EventID=4732
```
**Detects:** User added to privileged groups.

---

### 4️⃣ Service Account Privilege Abuse
```spl
index=auth user="svc_*"
| stats dc(host) by user
| where dc(host) > 2
```
**Detects:** Lateral privilege misuse by service accounts.

---

### 5️⃣ Process Escalation Chain (Endpoint)
```spl
index=endpoint
| stats values(parent_process) values(process) by user
```
**Detects:** Suspicious parent-child execution relationships.

---

### 6️⃣ UAC Bypass Indicators (Windows)
```spl
index=wineventlog EventID=4688
| search process="fodhelper.exe" OR process="eventvwr.exe"
```
**Detects:** Known UAC bypass techniques.

---

### 7️⃣ Linux SUID Binary Abuse
```spl
index=linux ("chmod +s" OR "setuid")
```
**Detects:** Manipulation of SUID binaries.

---

### 8️⃣ Cloud Role Escalation (AWS)
```spl
index=cloudtrail eventName IN ("AttachUserPolicy","PutUserPolicy","AddUserToGroup")
```
**Detects:** IAM privilege elevation.

---

### 9️⃣ Azure AD Privileged Role Assignment
```spl
index=azuread OperationName="Add member to role"
```
**Detects:** Elevation to privileged cloud roles.

---

### 🔟 Privilege Escalation After MFA Success
```spl
index=mfa action=success
| join user [ search index=auth admin=1 ]
```
**Detects:** Post-MFA escalation behavior.

---

### 1️⃣1️⃣ Escalation Outside Business Hours
```spl
index=auth admin=1
| where date_hour < 7 OR date_hour > 20
```
**Detects:** Suspicious admin access timing.

---

### 1️⃣2️⃣ Rare Privileged Access
```spl
index=auth admin=1
| stats count by user
| where count < 2
```
**Detects:** First-time or unusual admin usage.

---

## 🧠 Behavioral Indicators
- Rapid transition from user to admin
- Privileged actions without change tickets
- Use of LOLBins for escalation
- Cloud role changes without approval
- Off-hours admin access

---

## 🛡️ Response & Mitigation
- Immediately disable affected accounts
- Revoke elevated privileges
- Audit all accessed systems
- Rotate credentials and keys
- Enforce Just-In-Time (JIT) access
- Enable role approval workflows

---

## 📌 Summary

This file delivers **advanced, chain-based detection logic** for:
- On-prem privilege escalation
- Linux root abuse
- Cloud IAM role escalation

It focuses on **how attackers escalate**, not just *that they did*.


