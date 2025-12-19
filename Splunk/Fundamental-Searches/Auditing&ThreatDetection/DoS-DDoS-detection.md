# 🌊 DoS & DDoS Detection
## Fundamental Searches (SOC Level 1)

This file focuses on **fundamental detection searches** for **Denial of Service (DoS) and Distributed Denial of Service (DDoS)** attacks using **basic log analysis and simple SPL**.

These searches are designed for:
- SOC Tier 1 Analysts
- Junior Threat Hunters
- Blue Team Beginners
- Splunk Mastery – Fundamental Searches

The goal is to **identify traffic floods and availability attacks** using **clear, easy-to-understand logic** before moving to advanced analytics or dashboards.

---

## 🎯 Purpose
- Detect abnormal traffic spikes
- Identify potential DoS or DDoS attacks
- Detect single-source vs multi-source flooding
- Support basic incident triage
- Build a foundation for advanced detection & dashboards

---

## 🧠 What Is DoS vs DDoS?

| Attack Type | Description |
|-----------|-------------|
| DoS | Flood from a single source |
| DDoS | Flood from many distributed sources |

Common targets:
- Web servers
- APIs
- DNS services
- Authentication endpoints

---

## 📂 Common Log Sources
- Firewall logs
- Network traffic logs
- Web server logs
- Load balancer logs
- IDS / IPS logs

Assumed fields:
- `src_ip`
- `dest_ip`
- `dest_port`
- `bytes`
- `_time`
- `action`

---

## 🔍 Fundamental Detection Searches

### 🚨 Traffic Spike Detection (General DoS Indicator)
```spl
index=network_logs
| bucket _time span=1m
| stats count AS requests by _time
| where requests > 10000
```

Purpose:
- Detect sudden traffic floods
- First indicator of availability attacks

---

### 🎯 Single-Source DoS Detection
```spl
index=network_logs
| bucket _time span=1m
| stats count AS requests by src_ip
| where requests > 1000
```

Purpose:
- Detect DoS attacks from a single IP
- Identify misbehaving hosts or attackers

---

### 🌐 Multi-Source DDoS Detection
```spl
index=network_logs
| bucket _time span=1m
| stats dc(src_ip) AS unique_sources by dest_ip
| where unique_sources > 100
```

Purpose:
- Detect distributed flooding
- Identify DDoS-style behavior

---

### 🔁 Repeated Requests to Same Destination
```spl
index=network_logs
| stats count by src_ip dest_ip dest_port
| where count > 500
```

Purpose:
- Detect application-layer DoS
- Identify focused service targeting

---

### 🚪 High Traffic to Sensitive Services
```spl
index=network_logs
| search dest_port IN (80,443,53,22)
| stats count by dest_port
| where count > 5000
```

Purpose:
- Detect attacks against web, DNS, or SSH
- Identify critical service impact

---

### 🌙 Off-Hours Traffic Flooding
```spl
index=network_logs
| eval hour=strftime(_time,"%H")
| search hour < 6 OR hour > 22
| stats count by src_ip
```

Purpose:
- Detect stealthy or timed attacks
- Reduce false positives during business hours

---

## 🚨 Simple DoS / DDoS Indicators

| Indicator | Meaning |
|--------|--------|
| Sudden traffic spikes | Possible flood |
| High request rate | DoS attempt |
| Many source IPs | DDoS |
| Repeated requests | Application-layer attack |
| Service slowdown | Availability impact |

---

## 🛡️ SOC Tier 1 Response (Basic)
- Validate traffic spike timing
- Identify top source IPs
- Check affected destination/service
- Notify network/security teams
- Apply temporary blocking or rate limiting
- Escalate if attack persists

---

## 📌 Summary
This file provides **fundamental DoS and DDoS detection searches** that help SOC analysts **identify availability attacks early**, understand **basic attack patterns**, and perform **initial triage** before escalating to advanced analytics or dashboards.

These searches form the **foundation** for:
- Advanced DDoS analytics
- Behavioral baselining
- Network security dashboards

