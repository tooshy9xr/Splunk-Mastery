# 🗄️ SQL Queries Monitoring  
Fundamental Searches for Database Activity (Windows • Linux • Cloud)

This file focuses on **monitoring SQL query activity** across **Windows, Linux, and Cloud environments**, using **basic searches** suitable for the *Fundamental Searches* level.  
SQL monitoring is critical for detecting **unauthorized access, SQL injection attempts, data exfiltration, privilege abuse, and abnormal database behavior**.

---

## 🎯 Purpose
- Monitor **SQL query execution** and database access  
- Detect **malicious or suspicious SQL statements**  
- Identify **abnormal query volume or patterns**  
- Track **privileged database user activity**  
- Support SOC investigations and database incident response  

---

## 🖥️ Platforms Covered

### 🪟 Windows
- Microsoft SQL Server  
- Windows Event Logs (Application & Security)  
- SQL Server Audit & Error Logs  

### 🐧 Linux
- MySQL / MariaDB  
- PostgreSQL  
- Oracle Database  
- Database audit and slow query logs  

### ☁️ Cloud
- Amazon RDS / Aurora  
- Azure SQL Database  
- Google Cloud SQL  
- Managed database audit logs  

---

## 📂 Common Log Sources
- Database audit logs  
- Query execution logs  
- Error and authentication logs  
- Cloud provider database audit logs  

---

## 🧾 Sample Logs

### 🪟 Windows – MSSQL Query
```
2025-03-05 11:01:22 user=sa host=WIN-DB01 query="SELECT * FROM users;"
```

### 🐧 Linux – MySQL Query
```
2025-03-05 11:03:10 user=app_user host=10.0.0.12 query="SELECT email,password FROM customers;"
```

### ☁️ Cloud – RDS Audit Log
```
2025-03-05 11:05:33 user=db_admin action=DROP TABLE payments;
```

### ❌ SQL Injection Attempt
```
2025-03-05 11:07:11 user=webapp query="SELECT * FROM users WHERE id='1 OR 1=1'"
```

---

## 🔍 Fundamental Search Examples

### 📄 All SQL Queries
```spl
| table _time user host query
```

### ❌ Failed Database Authentication
```spl
| search error="Login failed"
| stats count by user host
```

### 🧨 Destructive SQL Commands
```spl
| search query IN ("DROP","DELETE","TRUNCATE","ALTER")
```

### ⚠️ SQL Injection Indicators
```spl
| search query="*OR 1=1*" OR query="*UNION SELECT*"
```

---

## 🚨 Detection Scenarios

### 🔁 Excessive Queries from Single User
```spl
| stats count by user
| where count > 1000
```

### 🕵️ Access to Sensitive Tables
```spl
| search query="*password*" OR query="*credit_card*"
```

### 🧨 Unauthorized Schema Changes
```spl
| search query="*DROP TABLE*" AND user!="db_admin"
```

---

## 🛡️ Mitigation & Response
- Enable auditing on all database platforms  
- Enforce least-privilege database roles  
- Monitor and restrict destructive commands  
- Block suspicious IPs and application users  
- Investigate and contain SQL injection attempts  

---

## 📌 Summary
This file provides **fundamental SQL query monitoring** across:
- 🪟 Windows databases  
- 🐧 Linux databases  
- ☁️ Cloud-managed databases  

It helps detect **malicious queries, privilege abuse, and data exposure risks**.
