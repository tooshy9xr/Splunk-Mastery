# 🛡️ Port Scanning Detection
Fundamental Searches for Network Reconnaissance Activity

This file focuses on **detecting port scanning activity** across **network and endpoint logs**, using **basic searches** suitable for the *Fundamental Searches* level.  
Port scanning detection is critical for identifying **early reconnaissance, vulnerability probing, and potential intrusion attempts**.

---

## 🎯 Purpose
- Detect **network scanning attempts** targeting hosts and services  
- Identify **suspicious IP addresses performing scans**  
- Monitor **frequency and type of port scans**  
- Support SOC investigations and threat hunting  
- Enable proactive defense measures  

---

## 🖥️ Platforms & Devices Covered
- 🌐 Firewalls and routers  
- 🐧 Linux servers (intrusion detection logs)  
- 🪟 Windows endpoints (IDS/EDR logs)  
- ☁️ Cloud network monitoring logs  

---

## 📂 Common Port Scanning Events
- Multiple connection attempts to sequential ports  
- Rapid connections to multiple hosts  
- Unusual traffic patterns from a single source  
- Detection by IDS/IPS systems  

---

## 📂 Common Log Sources
- Firewall logs (allowed/denied connections)  
- IDS/IPS alerts (Snort, Suricata)  
- Windows Event Logs (network connections)  
- Linux syslog and firewall logs  

---

## 🧾 Sample Logs

### 🌐 Firewall – Multiple Ports
```
2025-02-24 13:01:22 Firewall SrcIP=192.168.1.55 DestIP=10.0.0.5 DestPort=22 Action=Allowed
2025-02-24 13:01:23 Firewall SrcIP=192.168.1.55 DestIP=10.0.0.5 DestPort=23 Action=Allowed
2025-02-24 13:01:24 Firewall SrcIP=192.168.1.55 DestIP=10.0.0.5 DestPort=80 Action=Allowed
```

### 🐧 Linux – IDS Alert
```
Feb 24 13:05:33 server01 snort[1234]: [1:2010935:1] Portscan detected from 45.153.160.98
```

### 🪟 Windows – EDR Detection
```
2025-02-24 13:07:11 WIN-WS01 EventID=5156 SrcIP=185.220.101.1 DestPort=3389 Action=Blocked
```

---

## 🔍 Fundamental Search Examples

### 🌐 Multiple Ports Scanned
```spl
| stats count by SrcIP DestIP DestPort
| where count > 5
```

### 🧨 IDS Alerts for Scanning
```spl
Signature="Portscan detected"
| table _time SrcIP DestIP DestPort
```

### ⚡ Repeated Attempts to Multiple Hosts
```spl
| stats dc(DestIP) as unique_hosts by SrcIP
| where unique_hosts > 3
```

---

## 🚨 Detection Scenarios

### 🔁 Rapid Scanning from Single IP
```spl
| stats count by SrcIP
| where count > 10
```

### 🧭 Targeting Privileged Ports
```spl
| search DestPort IN (22,23,80,443,3389)
```

### ⚠️ Scanning from External IPs
```spl
| search SrcIP NOT IN ([trusted_network_list])
```

---

## 🛡️ Mitigation & Response
- Block or quarantine scanning IPs  
- Alert on repeated scanning attempts  
- Harden exposed services  
- Correlate scanning activity with threat intelligence  
- Implement rate-limiting and IDS rules  

---

## 📌 Summary
This file provides **fundamental port scanning detection** for:
- Firewall, IDS/IPS, and endpoint logs  
- Detection of network reconnaissance and suspicious activity  
- Early warning for potential attacks .
