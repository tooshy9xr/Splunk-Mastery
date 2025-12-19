# ☁️🔐 Cloud IAM Abuse Detection
## Cloud & Hybrid Advanced Detection (AWS • Azure • GCP)

This document focuses on **detecting Identity and Access Management (IAM) abuse in cloud environments**, where attackers exploit **permissions, roles, service accounts, and tokens** to gain persistence, escalate privileges, and access sensitive resources.

IAM abuse is one of the **most critical cloud attack vectors** because:
- Actions are authenticated
- Abuse often looks legitimate
- Permissions can span entire environments
- One compromised identity can equal full cloud compromise

Designed for:
- SOC Tier 2 / Tier 3 Analysts
- Cloud Security Engineers
- Threat Hunters
- Detection Engineers
- Splunk Mastery – Advanced Searches

---

## 🎯 Objectives
- Detect privilege escalation and permission abuse
- Identify compromised cloud identities
- Detect persistence via IAM changes
- Correlate IAM activity with cloud resource access
- Support rapid cloud incident response

---

## 🧠 What Is Cloud IAM Abuse?

Cloud IAM abuse includes:
- Over-privileged role assignment
- Unauthorized policy attachment
- Service account misuse
- Token generation and abuse
- Cross-account / cross-project access
- Persistence via hidden IAM changes

> In the cloud, **identity is the perimeter**.

---

## 🧠 Common Cloud IAM Abuse Techniques

| Technique | Description |
|---------|-------------|
| Privilege Escalation | Attaching admin-level roles |
| Persistence | Creating new users, keys, tokens |
| Lateral Movement | Assuming roles across accounts |
| Defense Evasion | Modifying logging or policies |
| Data Access | IAM-driven access to storage & DBs |

---

## 🟡 IAM BASELINE ESTABLISHMENT

### 🔍 Normal IAM Activity by User
```spl
index=cloud_logs
| stats count by user eventName
```

Purpose:
- Understand expected IAM behavior
- Identify unusual actions later

---

## 🔴 PRIVILEGE ESCALATION DETECTION

### ⬆️ High-Risk Role or Policy Assignment
```spl
index=cloud_logs
| search eventName IN (
    "AttachUserPolicy",
    "AttachRolePolicy",
    "AddMemberToRole",
    "SetIamPolicy",
    "CreateRole"
)
| table _time user target resource policy
```

Purpose:
- Detect sudden elevation of privileges
- Identify misused admin actions

---

## 🟠 PERSISTENCE VIA IAM

### 🔑 New Credentials & Tokens
```spl
index=cloud_logs
| search eventName IN (
    "CreateAccessKey",
    "CreateServiceAccountKey",
    "GenerateAccessToken"
)
| table _time user target sourceIPAddress
```

Purpose:
- Detect persistence mechanisms
- Identify long-lived attacker access

---

## 🔵 ROLE ASSUMPTION & LATERAL MOVEMENT

### 🔁 Cross-Account / Cross-Project Access
```spl
index=cloud_logs
| search eventName IN ("AssumeRole","GenerateAccessToken")
| stats count by user target
```

Purpose:
- Detect lateral movement via IAM
- Identify expansion of attacker access

---

## 🟣 DEFENSE EVASION VIA IAM

### 🛑 Logging & Security Policy Changes
```spl
index=cloud_logs
| search eventName IN (
    "StopLogging",
    "DeleteTrail",
    "UpdateTrail",
    "SetAuditConfig"
)
| table _time user eventName
```

Purpose:
- Detect attempts to hide activity
- High-confidence malicious behavior

---

## 🔥 IAM-DRIVEN DATA ACCESS

### 📦 Sensitive Resource Access After IAM Change
```spl
index=cloud_logs
| search eventName IN ("GetObject","Read","storage.objects.get")
| table _time user resource sourceIPAddress
```

Purpose:
- Confirm impact of IAM abuse
- Detect data access following escalation

---

## ☁️ SERVICE ACCOUNT ABUSE

### 🤖 Abnormal Service Account Activity
```spl
index=cloud_logs
| search user LIKE "%service%"
| stats count by user eventName
```

Purpose:
- Detect compromised service accounts
- Identify automation abuse

---

## 🔗 IAM + BEHAVIOR CORRELATION

### 🧠 IAM Changes Followed by Anomalies
```spl
index IN (cloud_logs, network_logs)
| table _time user eventName dest_ip bytes_out
```

Purpose:
- Increase confidence by chaining signals
- Detect real attacks vs admin changes

---

## ⏱️ IAM ABUSE TIMELINE

```spl
index=cloud_logs
| sort _time
| table _time user eventName target resource sourceIPAddress
```

Purpose:
- Reconstruct IAM attack path
- Support cloud incident response

---

## 🛡️ SOC RESPONSE & CLOUD IR NOTES
- Immediately revoke suspicious roles or keys
- Rotate compromised credentials
- Review all IAM changes within incident window
- Apply least-privilege policies
- Enable and protect audit logging
- Monitor identities post-remediation

---

## 🧠 MITRE ATT&CK Mapping

| Technique | Description |
|---------|-------------|
| T1078 | Valid Accounts |
| T1098 | Account Manipulation |
| T1087 | Account Discovery |
| T1562 | Impair Defenses |
| T1530 | Data from Cloud Storage |

---

## 📌 Summary
This file provides **advanced detection techniques for cloud IAM abuse**, enabling SOC and cloud security teams to identify **privilege escalation, persistence, lateral movement, and data access abuse** across **AWS, Azure, and GCP**, where identity is the primary attack surface.

