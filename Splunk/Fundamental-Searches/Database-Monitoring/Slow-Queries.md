# 🐢🗄️ Slow Queries Monitoring  
Fundamental Searches for Database Performance Issues  
(Windows • Linux • Cloud)

This file focuses on **monitoring slow database queries** across **Windows, Linux, and Cloud environments**, using **basic searches** suitable for the *Fundamental Searches* level.  
Slow query monitoring is essential for detecting **performance bottlenecks, inefficient queries, potential Denial-of-Service (DoS) attacks, and application misconfigurations**.

---

## 🎯 Purpose
- Identify **long-running SQL queries**  
- Monitor **high resource-consuming queries**  
- Detect **inefficient joins, missing indexes, or suboptimal queries**  
- Prevent **database performance degradation**  
- Support SOC and DBA performance investigations  

---

## 🖥️ Platforms Covered

### 🪟 Windows
- Microsoft SQL Server  
- SQL Server Query Store & Slow Query Logs  
- Windows Event Logs  

### 🐧 Linux
- MySQL / MariaDB Slow Query Logs  
- PostgreSQL pg_stat_activity & logs  
- Oracle Database SQL Trace  

### ☁️ Cloud
- Amazon RDS / Aurora slow query logs  
- Azure SQL Database Query Store  
- Google Cloud SQL slow query logging  

---

## 📂 Common Log Sources
- Database slow query logs  
- Audit logs capturing query execution time  
- Cloud-managed database query performance logs  
- Application performance logs  

---

## 🧾 Sample Logs

### 🪟 Windows – MSSQL Long Query
```
2025-03-08 14:01:22 user=db_admin query="SELECT * FROM orders JOIN customers ON orders.customer_id=customers.id;" duration=12s
```

### 🐧 Linux – MySQL Slow Query
```
2025-03-08 14:03:10 user=app_user query="SELECT * FROM transactions WHERE status='pending';" duration=15s
```

### ☁️ Cloud – RDS Slow Query
```
2025-03-08 14:05:33 user=db_service query="UPDATE payments SET status='complete' WHERE id=1024;" duration=18s
```

---

## 🔍 Fundamental Search Examples

### 🐢 All Slow Queries
```spl
| search duration>5
| table _time user host query duration
```

### 🧨 High Resource Queries
```spl
| search query IN ("JOIN","GROUP BY","ORDER BY")
| sort -duration
```

### 👤 Slow Queries by Non-Privileged Users
```spl
| search user!="db_admin"
```

### 🔁 Frequent Slow Queries
```spl
| stats count by query
| where count > 3
```

---

## 🚨 Detection Scenarios

### ⚠️ Repeated Slow Queries
```spl
| stats count by query user
| where count > 5
```

### 🧨 Long-Running Updates or Deletes
```spl
| search query IN ("UPDATE","DELETE") AND duration>10
```

### 🕵️ Queries Outside Business Hours
```spl
| where date_hour < 8 OR date_hour > 18
```

---

## 🛡️ Mitigation & Response
- Optimize slow queries (indexes, query rewriting)  
- Limit resource-intensive operations  
- Monitor application query patterns  
- Alert DBA on repeated long-running queries  
- Review cloud database performance metrics  

---

## 📌 Summary
This file provides **fundamental monitoring of slow queries** across:
- 🪟 Windows databases  
- 🐧 Linux databases  
- ☁️ Cloud-managed databases  

It helps detect **performance issues, inefficient queries, and potential DoS patterns**.

