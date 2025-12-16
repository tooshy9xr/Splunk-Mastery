# ❌🗄️ Failed Database Connections  
Fundamental Searches for Database Authentication Failures  
(Windows • Linux • Cloud)

This file focuses on **monitoring failed database connection attempts** across **Windows, Linux, and Cloud environments**, using **basic searches** suitable for the *Fundamental Searches* level.  
Failed DB connections are a strong indicator of **brute-force attempts, misconfigurations, credential misuse, or application issues**.

---

## 🎯 Purpose
- Detect **failed database login attempts**
- Identify **brute-force or password spraying attacks**
- Monitor **misconfigured applications**
- Track **unauthorized access attempts**
- Support SOC investigations and database security monitoring

---

## 🖥️ Platforms Covered

### 🪟 Windows
- Microsoft SQL Server  
- Windows Event Logs (Application & Security)  
- SQL Server Error & Audit Logs  

### 🐧 Linux
- MySQL / MariaDB  
- PostgreSQL  
- Oracle Database  
- Database authentication and error logs  

### ☁️ Cloud
- Amazon RDS / Aurora  
- Azure SQL Database  
- Google Cloud SQL  
- Managed database audit logs  

---

## 📂 Common Log Sources
- Database authentication logs  
- Error and audit logs  
- Cloud database service logs  
- Application connection logs  

---

## 🧾 Sample Logs

### 🪟 Windows – MSSQL Failed Login
```
2025-03-06 12:01:22 Login failed for user 'sa'. Reason: Invalid password.
```

### 🐧 Linux – MySQL Failed Connection
```
2025-03-06 12:03:10 Access denied for user 'app_user'@'10.0.0.15'
```

### 🐧 Linux – PostgreSQL Failed Login
```
2025-03-06 12:05:33 FATAL: password authentication failed for user "admin"
```

### ☁️ Cloud – RDS Authentication Failure
```
2025-03-06 12:07:11 user=db_admin error=authentication failed source_ip=185.220.101.1
```

---

## 🔍 Fundamental Search Examples

### ❌ All Failed DB Connections
```spl
error IN ("authentication failed","Login failed","Access denied")
| table _time user host source_ip error
```

### 🔁 Repeated Failures from Same IP
```spl
| stats count by source_ip
| where count > 5
```

### 👤 Multiple Failures for Same User
```spl
| stats count by user
| where count > 5
```

### 🌍 External Failed Connections
```spl
| iplocation source_ip
| search Country NOT IN ("US","CA","UK")
```

---

## 🚨 Detection Scenarios

### 🧨 Database Brute-Force Attempt
```spl
| stats count by source_ip user
| where count > 10
```

### ⚠️ Failed Logins Outside Business Hours
```spl
| where date_hour < 8 OR date_hour > 18
```

### 🕵️ Failed Access to Privileged Accounts
```spl
| search user IN ("sa","root","admin")
```

---

## 🛡️ Mitigation & Response
- Enforce strong passwords and MFA (where supported)  
- Lock accounts after multiple failed attempts  
- Restrict database access by IP  
- Investigate misconfigured applications  
- Alert on brute-force patterns  

---

## 📌 Summary
This file provides **fundamental monitoring of failed database connections** across:
- 🪟 Windows databases  
- 🐧 Linux databases  
- ☁️ Cloud-managed databases  

It helps detect **brute-force attacks, credential misuse, and misconfigurations**.
