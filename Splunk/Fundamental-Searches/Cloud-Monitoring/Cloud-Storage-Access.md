# ☁️📦 Cloud Storage Access Monitoring
Fundamental Searches for Cloud Storage Activity

This file focuses on **monitoring cloud storage access** across **AWS, Azure, and GCP**, using **basic searches** suitable for the *Fundamental Searches* level.  
Cloud storage monitoring is essential for detecting **unauthorized access, data exfiltration, misconfigurations, and insider threats**.

---

## 🎯 Purpose
- Monitor **read, write, delete operations** on cloud storage  
- Detect **unauthorized or suspicious access**  
- Identify **public exposure or permission abuse**  
- Track **data exfiltration attempts**  
- Support SOC investigations and cloud incident response  

---

## ☁️ Cloud Platforms Covered

### 🟠 AWS
- S3 bucket access logs  
- CloudTrail data events  

### 🔵 Azure
- Azure Storage Analytics logs  
- Blob, File, Queue, and Table access logs  

### 🟢 GCP
- Cloud Storage audit logs  
- Object-level access logs  

---

## 📂 Common Log Sources
- **AWS CloudTrail** – S3 object-level operations  
- **Azure Activity Logs** – Storage account operations  
- **Azure Storage Analytics** – Blob & file access  
- **GCP Cloud Audit Logs** – Object access & permissions  

---

## 🧾 Sample Logs

### 📦 AWS S3 – Object Download
```
2025-03-01 10:01:22 eventName=GetObject bucket=my-backups object=db_dump.sql user=john.doe
```

### 📦 Azure Blob – File Read
```
2025-03-01 10:03:10 StorageAccount=corpdata Operation=Read Blob=secrets.zip User=alice
```

### 📦 GCP Storage – Object Delete
```
2025-03-01 10:05:33 bucket=gcp-data object=logs.tar.gz method=storage.objects.delete principalEmail=bob@company.com
```

---

## 🔍 Fundamental Search Examples

### 📥 Object Read / Download Activity
```spl
eventName IN ("GetObject","Read","storage.objects.get")
| table _time user bucket object
```

### 🗑 Object Deletions
```spl
eventName IN ("DeleteObject","storage.objects.delete")
| stats count by user bucket
```

### 🔐 Access by Privileged Users
```spl
| search user IN ("admin","root","service-account")
```

### 🌍 Access from Unusual Locations
```spl
| iplocation sourceIPAddress
| search Country NOT IN ("US","CA","UK")
```

---

## 🚨 Detection Scenarios

### 🔁 Mass File Downloads (Data Exfiltration)
```spl
| stats count by user
| where count > 100
```

### ⚠️ Public Bucket or Container Access
```spl
eventName IN ("PutBucketAcl","SetIamPolicy")
```

### 🧨 Deletions by Non-Admin Users
```spl
| search eventName="DeleteObject" AND user!="admin"
```

---

## 🛡️ Mitigation & Response
- Enforce least-privilege access policies  
- Enable object-level logging  
- Block public access unless required  
- Alert on mass downloads or deletions  
- Rotate compromised credentials immediately  

---

## 📌 Summary
This file provides **fundamental cloud storage access monitoring** for:
- AWS S3, Azure Storage, and GCP Storage  
- Detecting unauthorized access and data exfiltration  
- Improving cloud data security visibility  

