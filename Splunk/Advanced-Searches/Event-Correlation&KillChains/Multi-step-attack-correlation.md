# 🔗 Multi‑Step Attack Correlation  
Advanced Attack Chain & Kill‑Chain Analytics  
(Windows • Linux • Cloud)

---

## 📁 Folder Context (Professional Description)

The **Multi‑Step Attack Correlation** module is designed to detect **complex attacks that unfold over multiple stages**, users, hosts, and time windows.  
Instead of alerting on isolated events, this module **correlates sequences of actions** to identify **real attack campaigns**.

This is a **core advanced SOC capability** used in:
- Threat hunting
- Incident response
- Purple team operations
- Detection engineering

---

## 🎯 File Objective

`Multi-step-attack-correlation.md` aims to:
- Correlate **initial access → execution → persistence → lateral movement → exfiltration**
- Reduce false positives from single-event alerts
- Identify attacker behavior patterns
- Detect slow, stealthy, and low‑and‑slow attacks
- Provide high‑confidence detections

---

## 🧠 Detection Philosophy

Single alerts ≠ attacks.  
**Attackers operate in chains**, often spread across:
- Different users
- Multiple hosts
- Long time ranges
- Mixed platforms (endpoint + cloud)

This module focuses on:
- **Temporal correlation**
- **Behavioral sequencing**
- **Cross‑data‑source analytics**

---

## 🧩 MITRE ATT&CK Coverage

- TA0001 – Initial Access  
- TA0002 – Execution  
- TA0003 – Persistence  
- TA0004 – Privilege Escalation  
- TA0008 – Lateral Movement  
- TA0011 – Command & Control  
- TA0010 – Exfiltration  

---

## 📊 Data Sources

| Source | Purpose |
|------|--------|
| Windows Security Logs | Auth, services, tasks |
| Linux Audit / Auth Logs | SSH, sudo, cron |
| Endpoint Telemetry | Process & file events |
| Network Logs | Proxy, firewall, DNS |
| Cloud Logs | IAM, API activity |
| EDR / XDR | Behavioral signals |

---

## 🔍 Advanced Correlation Scenarios (15+)

---

## 🧱 Initial Access → Execution

### 1️⃣ Phishing → Process Execution
```spl
| transaction user maxspan=30m
| search event_type=phishing OR process_start
```
📌 Email‑borne compromise.

---

### 2️⃣ VPN Login → Rare Command
```spl
| transaction user maxspan=20m
```
📌 Remote access abuse.

---

---

## 🔑 Credential Abuse → Lateral Movement

### 3️⃣ Failed Logins → Success → New Host
```spl
| transaction user maxspan=15m
```
📌 Password spraying progression.

---

### 4️⃣ Admin Login → SMB / RDP
```spl
destination_port IN (445,3389)
```
📌 Lateral movement.

---

---

## 🪟 Windows Attack Chains

### 5️⃣ Service Creation → Scheduled Task
```spl
EventID IN (7045,4698)
```
📌 Persistence layering.

---

### 6️⃣ Registry Run Key → Network Beacon
```spl
registry_path="*\\Run"
```
📌 Malware startup + C2.

---

---

## 🐧 Linux Attack Chains

### 7️⃣ SSH Login → Sudo → Cron Job
```spl
| transaction user maxspan=20m
```
📌 Privilege escalation + persistence.

---

### 8️⃣ File Drop → Execution → Network Call
```spl
process_path="/tmp/*"
```
📌 Dropper activity.

---

---

## ☁️ Cloud Attack Chains

### 9️⃣ API Key Creation → Resource Access
```spl
action=CreateAccessKey
```
📌 Cloud persistence.

---

### 🔟 New IAM Role → Data Download
```spl
| transaction user maxspan=30m
```
📌 Privilege escalation in cloud.

---

---

## 🔄 Cross‑Platform Correlation

### 1️⃣1️⃣ Endpoint Compromise → Cloud Login
```spl
| transaction user maxspan=60m
```
📌 Identity pivot.

---

### 1️⃣2️⃣ VPN Login → Cloud Console Access
```spl
source_ip=* AND cloud_action=Login
```
📌 Hybrid attack path.

---

---

## 📦 Exfiltration Chains

### 1️⃣3️⃣ Data Access → Compression → Upload
```spl
process IN ("zip","tar","7z")
```
📌 Staging + exfiltration.

---

### 1️⃣4️⃣ Large Transfer → External IP
```spl
bytes_out > threshold
```
📌 Data theft.

---

---

## 🧠 Behavioral Correlation

### 1️⃣5️⃣ Rare Sequence Detection
```spl
| stats count by user sequence
| where count < 2
```
📌 Anomalous attack chain.

---

## 🧪 Advanced Techniques Used

- `transaction`
- `stats + timechart`
- `eventstats`
- `streamstats`
- Risk‑based scoring
- Entity correlation (user, host, IP)

---

## 🛡️ Response & Action

- Validate full attack timeline
- Isolate affected hosts
- Reset compromised credentials
- Revoke cloud keys and tokens
- Perform scoped threat hunt
- Feed findings into detection tuning

---

## 📌 Final Summary

**Multi‑Step Attack Correlation** transforms noisy alerts into **actionable attack stories**.

This module enables:
- High‑confidence detections
- Faster investigations
- Reduced alert fatigue
- True attacker visibility


