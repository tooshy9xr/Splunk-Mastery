# ☁️🔐 Cloud IAM Changes Monitoring
Fundamental Searches for Identity & Access Changes

This file focuses on **monitoring Identity and Access Management (IAM) changes** across **AWS, Azure, and GCP**, using **basic searches** suitable for the *Fundamental Searches* level.  
IAM change monitoring is critical for detecting **privilege escalation, account compromise, misconfigurations, and insider threats**.

---

## 🎯 Purpose
- Track **user, role, and service account changes**  
- Detect **privilege escalation and risky permissions**  
- Monitor **role assignments and policy modifications**  
- Identify **unauthorized or suspicious IAM activity**  
- Support SOC investigations and cloud incident response  

---

## ☁️ Cloud Platforms Covered

### 🟠 AWS
- IAM user and role changes  
- Policy attachments and updates  
- Access key creation and deletion  

### 🔵 Azure
- Azure AD role assignments  
- User and group management  
- Conditional Access policy changes  

### 🟢 GCP
- IAM policy updates  
- Service account key management  
- Role binding changes  

---

## 📂 Common Log Sources
- **AWS CloudTrail** – IAM API calls  
- **Azure AD Audit Logs** – Identity changes  
- **Azure Activity Logs** – Role and policy updates  
- **GCP Cloud Audit Logs** – IAM policy changes  

---

## 🧾 Sample Logs

### 🔐 AWS – IAM Policy Attachment
```
2025-03-02 09:01:22 eventName=AttachUserPolicy userName=alice policy=AdministratorAccess
```

### 🔐 Azure – Role Assignment
```
2025-03-02 09:03:10 Operation=Add member to role Role=GlobalAdmin InitiatedBy=john.doe
```

### 🔐 GCP – IAM Policy Change
```
2025-03-02 09:05:33 principalEmail=bob@company.com methodName=SetIamPolicy resource=projects/prod
```

---

## 🔍 Fundamental Search Examples

### 🔐 Privileged Role Assignments
```spl
eventName IN ("AttachUserPolicy","Add member to role","SetIamPolicy")
| table _time user Role resource
```

### ❌ Access Key Creation
```spl
eventName IN ("CreateAccessKey","Add service account key")
```

### 🔁 Frequent IAM Changes
```spl
| stats count by user
| where count > 5
```

---

## 🚨 Detection Scenarios

### 🧨 Privilege Escalation Attempts
```spl
| search policy="AdministratorAccess" OR Role IN ("GlobalAdmin","Owner")
```

### ⚠️ IAM Changes Outside Business Hours
```spl
| where date_hour < 8 OR date_hour > 18
```

### 🌍 Changes from Unusual Locations
```spl
| iplocation sourceIPAddress
| search Country NOT IN ("US","CA","UK")
```

---

## 🛡️ Mitigation & Response
- Enforce least-privilege IAM policies  
- Enable MFA for all privileged users  
- Review IAM changes regularly  
- Alert on high-risk role assignments  
- Rotate compromised credentials  

---

## 📌 Summary
This file provides **fundamental IAM change monitoring** for:
- AWS, Azure, and GCP identity activity  
- Detecting privilege escalation and misconfigurations  
- Enhancing cloud identity security  


