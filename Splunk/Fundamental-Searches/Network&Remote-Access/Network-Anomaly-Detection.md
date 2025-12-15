# 🌐 Network Anomaly Detection
Fundamental Searches for Unusual Network Activity

This file focuses on **detecting network anomalies** across **firewalls, routers, endpoints, and cloud environments**, using **basic searches** suitable for the *Fundamental Searches* level.  
Network anomaly detection helps identify **suspicious traffic patterns, unusual connections, and potential security incidents**.

---

## 🎯 Purpose
- Detect **unexpected traffic patterns**  
- Identify **abnormal protocol usage or port activity**  
- Monitor **bandwidth spikes and unusual connections**  
- Spot **malware communication, lateral movement, and reconnaissance**  
- Support SOC investigations and threat hunting  

---

## 🖥️ Platforms & Devices Covered
- 🌐 Firewalls, routers, and IDS/IPS  
- 🪟 Windows endpoints  
- 🐧 Linux servers  
- ☁️ Cloud network and VPC logs  

---

## 📂 Common Network Anomalies
- Unusual traffic volumes (spikes/drops)  
- Connections from rare or foreign IP addresses  
- Unexpected protocols or port usage  
- Rapid repeated connections (DDoS, scanning)  
- Internal lateral movement detection  

---

## 📂 Common Log Sources
- Firewall and router logs  
- IDS/IPS alerts (Snort, Suricata, Zeek)  
- Windows Event Logs (network events)  
- Linux syslog and firewall logs  
- Cloud VPC Flow Logs  

---

## 🧾 Sample Logs

### 🌐 Firewall – Unusual Traffic Spike
```
2025-02-25 14:01:22 Firewall SrcIP=10.10.10.55 DestIP=10.0.0.5 DestPort=443 Bytes=1048576
```

### 🌐 Router – Connections to Rare IP
```
2025-02-25 14:03:10 Router01 SrcIP=10.10.10.20 DestIP=203.0.113.7 Protocol=TCP Action=Allowed
```

### 🐧 Linux – Unexpected Protocol Usage
```
Feb 25 14:05:33 server01 audit[1234]: Protocol=ICMP SrcIP=192.168.1.55 DestIP=10.0.0.10
```

### 🪟 Windows – Lateral Movement Attempt
```
2025-02-25 14:07:11 WIN-WS01 EventID=5156 SrcIP=10.10.10.55 DestIP=10.10.10.60 DestPort=445 Action=Allowed
```

---

## 🔍 Fundamental Search Examples

### ⚡ High Volume Traffic
```spl
| stats sum(Bytes) by SrcIP DestIP
| where sum(Bytes) > 1000000
```

### 🌍 Connections from Rare IPs
```spl
| stats count by SrcIP DestIP
| where count < 2
```

### 🧨 Unexpected Protocol Usage
```spl
| search Protocol IN ("ICMP","Telnet","FTP")
```

### 🔁 Rapid Connections / Lateral Movement
```spl
| stats dc(DestIP) as hosts by SrcIP
| where hosts > 5
```

---

## 🚨 Detection Scenarios

### 🔁 Sudden Traffic Spike
```spl
| timechart sum(Bytes) by SrcIP
| where sum(Bytes) > threshold
```

### 🧭 Connections from Foreign Countries
```spl
| search GeoIP NOT IN ("US","CA","UK")
```

### ⚠️ Unauthorized Protocol or Port Use
```spl
| search DestPort IN (21,23,445,3389)
```

---

## 🛡️ Mitigation & Response
- Block suspicious IPs and ports  
- Review network traffic patterns  
- Correlate anomalies with endpoint and authentication logs  
- Implement IDS/IPS alerts and rate limiting  
- Investigate potential malware or lateral movement  

---

## 📌 Summary
This file provides **fundamental network anomaly detection** for:
- Identifying unusual traffic patterns and connections  
- Detecting potential attacks and suspicious activity  
- Enhancing SOC visibility and response capabilities 
