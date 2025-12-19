# ☁️⬆️ Cloud Privilege Escalation Detection
## Cloud & Hybrid Advanced Detection (AWS • Azure • GCP)

This document focuses on **detecting cloud privilege escalation**, where attackers expand permissions from a **low-privileged identity** to **high-privileged or admin-level access** by abusing **IAM roles, policies, service accounts, and misconfigurations**.

Cloud privilege escalation is especially dangerous because:
- It uses valid identities
- Changes are often persistent
- Escalation can span accounts/projects
- It enables full control over cloud resources

Designed for:
- SOC Tier 2 / Tier 3 Analysts
- Cloud Security Engineers
- Threat Hunters
- Detection Engineers
- Splunk Mastery – Advanced Searches

---

## 🎯 Objectives
- Detect permission increases and role changes
- Identify escalation paths across IAM entities
- Detect abuse of misconfigured policies
- Correlate escalation with follow-on actions
- Support rapid cloud incident response

---

## 🧠 What Is Cloud Privilege Escalation?

Cloud privilege escalation includes:
- Attaching higher-privileged roles or policies
- Modifying existing policies to grant more access
- Exploiting pass-role / assume-role permissions
- Abusing service account impersonation
- Creating new privileged identities
- Leveraging default or overly broad permissions

> In the cloud, **one role change can equal root**.

---

## 🧠 Common Escalation Paths (Cross-Cloud)

| Path | Description |
|-----|-------------|
| Policy Attachment | Add admin policies to a user/role |
| Role Assumption | Assume higher-privileged role |
| Policy Modification | Edit policy to allow more actions |
| Service Account Abuse | Impersonate or grant roles to SAs |
| New Identity Creation | Create new privileged users/keys |
| Indirect Escalation | Gain permissions via trusted services |

---

## 🟡 BASELINE IAM PERMISSIONS

### 🔍 Normal Permission Change Activity
```spl
index=cloud_logs
| stats count by user eventName
```

Purpose:
- Establish expected IAM modification behavior
- Identify anomalous privilege changes

---

## 🔴 DIRECT PRIVILEGE ESCALATION

### ⬆️ High-Risk Role / Policy Assignment
```spl
index=cloud_logs
| search eventName IN (
    "AttachUserPolicy",
    "AttachRolePolicy",
    "AddMemberToRole",
    "AssignRole",
    "SetIamPolicy"
)
| table _time user target resource policy
```

Purpose:
- Detect direct elevation to admin or powerful roles
- High-confidence escalation signal

---

## 🟠 POLICY MODIFICATION ABUSE

### 🧾 Editing Policies to Expand Permissions
```spl
index=cloud_logs
| search eventName IN ("CreatePolicyVersion","PutRolePolicy","UpdateRole")
| table _time user target policy
```

Purpose:
- Detect stealthy escalation via policy edits
- Identify permission creep abuse

---

## 🔵 ROLE ASSUMPTION ESCALATION

### 🔁 Assuming Higher-Privileged Roles
```spl
index=cloud_logs
| search eventName IN ("AssumeRole","GenerateAccessToken","ImpersonateServiceAccount")
| stats count by user target
```

Purpose:
- Detect escalation via trust relationships
- Identify cross-account or cross-project abuse

---

## 🟣 SERVICE ACCOUNT PRIVILEGE ESCALATION

### 🤖 Service Account Role Expansion
```spl
index=cloud_logs
| search user LIKE "%service%"
| search eventName IN ("AddMemberToRole","SetIamPolicy")
| table _time user target role
```

Purpose:
- Detect abused automation identities
- Identify escalation hidden in CI/CD activity

---

## 🔥 ESCALATION VIA NEW IDENTITY CREATION

### 🆕 Creating Privileged Users or Keys
```spl
index=cloud_logs
| search eventName IN (
    "CreateUser",
    "CreateAccessKey",
    "CreateServiceAccount",
    "CreateServiceAccountKey"
)
| table _time user target sourceIPAddress
```

Purpose:
- Detect persistence + escalation
- Identify attacker-controlled identities

---

## ☁️ ESCALATION FOLLOWED BY IMPACT

### 📦 Privileged Access to Sensitive Resources
```spl
index=cloud_logs
| search eventName IN ("GetObject","Read","ListBuckets","ExportData")
| table _time user resource sourceIPAddress
```

Purpose:
- Confirm escalation impact
- Detect data access after elevation

---

## 🔗 ESCALATION CHAIN CORRELATION

### 🧠 Privilege Change → Role Assumption → Data Access
```spl
index=cloud_logs
| sort _time
| table _time user eventName target resource
```

Purpose:
- Reconstruct full escalation chain
- Support incident response and reporting

---

## ⏱️ PRIVILEGE ESCALATION TIMELINE

```spl
index=cloud_logs
| sort _time
| table _time user eventName policy role sourceIPAddress
```

Purpose:
- Visualize escalation progression
- Identify first elevation point

---

## 🛡️ SOC RESPONSE & CLOUD IR NOTES
- Immediately revoke escalated roles or policies
- Rotate all affected credentials and tokens
- Review IAM changes across full incident window
- Audit trust relationships and pass-role permissions
- Enforce least privilege and separation of duties
- Enable alerts on all IAM modification events

---

## 🧠 MITRE ATT&CK Mapping

| Technique | Description |
|---------|-------------|
| T1078 | Valid Accounts |
| T1098 | Account Manipulation |
| T1087 | Account Discovery |
| T1548 | Abuse Elevation Control Mechanism |
| T1530 | Data from Cloud Storage |

---

## 📌 Summary
This file provides **advanced detection techniques for cloud privilege escalation**, enabling SOC and cloud security teams to identify **permission abuse, role escalation, and identity-based attacks** across **AWS, Azure, and GCP**, where **IAM missteps can lead to full environment compromise**.

