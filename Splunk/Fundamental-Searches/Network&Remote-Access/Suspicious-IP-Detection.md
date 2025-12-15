# 🕵️ Suspicious IP Detection
Fundamental Searches for Malicious or Anomalous IP Activity

This file focuses on **detecting suspicious IP addresses** across **network, endpoint, and security logs**, using **basic searches** suitable for the *Fundamental Searches* level.  
Monitoring IPs helps identify **malware command-and-control traffic, scanning activity, brute-force attacks, and compromised hosts**.

---

## 🎯 Purpose
- Detect **known malicious IP addresses**
- Identify **anomalous or unusual IP activity**
- Monitor **failed logins, unauthorized access, and brute-force attempts**
- Correlate network traffic with endpoint logs
- Support SOC investigations and threat hunting

---

## 🖥️ Platforms & Devices Covered
- 🌐 Firewalls, IDS/IPS, and routers  
- 🪟 Windows Endpoints  
- 🐧 Linux Endpoints  
- ☁️ Cloud Security & Network Logs  

---

## 📂 Common Suspicious IP Events
- Repeated failed authentication attempts  
- Connections to known malicious IPs  
- Abnormal traffic volumes  
- Unusual geolocation or new IPs  
- Traffic to high-risk ports  

---

## 📂 Common Log Sources
- Firewall and router logs  
- IDS/IPS logs  
- Windows Event Logs (failed logins)  
- Linux auth.log and syslog  
- Proxy and VPN logs  

---

## 🧾 Sample Logs

### 🌐 Network – Suspicious Connection
```
2025-02-22 11:01:22 Firewall SrcIP=192.168.1.55 DestIP=185.220.101.1 Action=Allowed
```

### 🪟 Windows – Failed Login from Suspicious IP
```
2025-02-22 11:03:10 WIN-WS01 EventID=4625 User=alice SrcIP=45.153.160.98
```

### 🐧 Linux – SSH Attempt from Malicious IP
```
Feb 22 11:05:33 server01 sshd[1234]: Failed password for invalid user admin from 185.220.101.1
```

### 🌐 Proxy – Suspicious Web Access
```
2025-02-22 11:07:11 ProxyServer User=bob URL=http://malicious.com SrcIP=10.10.10.55
```

---

## 🔍 Fundamental Search Examples

### 🌍 Known Malicious IPs
```spl
| search SrcIP IN ("185.220.101.1","45.153.160.98")
```

### 🔎 Repeated Failed Logins from IP
```spl
EventID=4625 OR "Failed password"
| stats count by SrcIP
| where count > 5
```

### ⚡ Anomalous IP Access
```spl
| stats dc(host) as hosts by SrcIP
| where hosts > 1
```

---

## 🚨 Detection Scenarios

### 🔁 Multiple Failed Logins from Same IP
```spl
| stats count by SrcIP
| where count > 5
```

### 🧨 Access from High-Risk Countries
```spl
| search country IN ("CN","RU","IR","KP")
```

### ⚠️ New or Unrecognized IPs
```spl
| search NOT SrcIP IN ([trusted_network_list])
```

---

## 🛡️ Mitigation & Response
- Block known malicious IPs at firewall or proxy  
- Alert on repeated failed logins  
- Investigate connections from unknown or high-risk IPs  
- Correlate with endpoint and network activity  
- Update threat intelligence feeds regularly  

---

## 📌 Summary
This file provides **fundamental suspicious IP detection** for:
- Network, endpoint, and proxy logs  
- Known and anomalous IP activity  
- Early detection of attacks and malicious behavior  
