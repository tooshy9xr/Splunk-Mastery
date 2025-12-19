# 🧠 Hash, IP & Domain Enrichment
## Threat Intelligence & IOC Enrichment (Advanced Splunk Detection Engineering)

This document focuses on **enriching hashes, IP addresses, and domains** with **threat intelligence context**, transforming raw indicators into **actionable, high-confidence security signals**.

IOC enrichment improves detection by:
- Adding reputation and context
- Prioritizing alerts
- Reducing false positives
- Accelerating investigations
- Enabling risk-based response

Designed for:
- SOC Tier 2 / Tier 3 Analysts
- Threat Intelligence Teams
- Detection Engineers
- Incident Responders
- Splunk Mastery – Advanced Searches

---

## 🎯 Objectives
- Enrich hashes, IPs, and domains with threat context
- Correlate enriched IOCs with internal telemetry
- Improve alert fidelity and prioritization
- Support faster triage and investigation
- Enable intelligence-driven detections

---

## 🧠 Why IOC Enrichment Matters

Raw indicators alone answer **“what”**, but enrichment answers:
- Who is behind it?
- How dangerous is it?
- Is it active or stale?
- Is it part of a known campaign?

> Enrichment turns indicators into **intelligence**.

---

## 🧠 Common Enrichment Attributes

| Attribute | Description |
|---------|-------------|
| Reputation | Malicious, suspicious, benign |
| Confidence | Reliability of the indicator |
| Source | Feed or provider |
| First Seen | When indicator appeared |
| Last Seen | Most recent activity |
| Threat Type | Malware, C2, phishing, botnet |
| Campaign / Actor | Known threat groups |
| Geo / ASN | Infrastructure context |

---

## 🟡 ASSUMED THREAT INTEL DATA MODEL

Threat intelligence stored in:
- `index=threat_intel`

Common fields:
- `ioc_value`
- `ioc_type` (hash, ip, domain)
- `threat_level`
- `confidence`
- `source`
- `first_seen`
- `last_seen`
- `threat_type`
- `campaign`
- `actor`

---

## 🔴 HASH ENRICHMENT

### 🧬 File Hash Reputation Enrichment
```spl
index IN (windows_logs, linux_logs, edr_logs)
| lookup threat_intel ioc_value AS file_hash OUTPUT threat_level confidence threat_type source
| where isnotnull(threat_level)
```

Purpose:
- Detect known malware execution
- Identify reused attacker tooling

---

## 🟠 IP ADDRESS ENRICHMENT

### 🌐 Network Traffic IP Enrichment
```spl
index=network_logs
| lookup threat_intel ioc_value AS dest_ip OUTPUT threat_level confidence threat_type source
| where isnotnull(threat_level)
```

Purpose:
- Detect C2 or malicious infrastructure
- Prioritize outbound connections

---

## 🔵 DOMAIN ENRICHMENT

### 🔗 DNS / Proxy Domain Enrichment
```spl
index IN (dns_logs, proxy_logs)
| lookup threat_intel ioc_value AS query OUTPUT threat_level confidence threat_type source
| where isnotnull(threat_level)
```

Purpose:
- Detect malicious domains and phishing
- Identify early-stage compromise

---

## 🟣 CLOUD IOC ENRICHMENT

### ☁️ Cloud Source IP / Domain Enrichment
```spl
index=cloud_logs
| lookup threat_intel ioc_value AS sourceIPAddress OUTPUT threat_level confidence threat_type
| where isnotnull(threat_level)
```

Purpose:
- Detect compromised cloud workloads
- Identify attacker-controlled infrastructure

---

## 🔥 MULTI-IOC ENRICHMENT (HIGH CONFIDENCE)

### 🔗 Multiple Indicator Types in One Session
```spl
index=*
| lookup threat_intel ioc_value AS indicator OUTPUT threat_level
| stats count dc(ioc_value) AS ioc_hits by host user
| where ioc_hits > 1
```

Purpose:
- Identify active compromise
- Increase alert confidence

---

## 🔗 ENRICHMENT + BEHAVIOR CORRELATION

### 🧠 Enriched IOC + Anomalous Activity
```spl
index IN (network_logs, windows_logs, linux_logs)
| lookup threat_intel ioc_value AS dest_ip OUTPUT threat_level threat_type
| where isnotnull(threat_level)
| table _time user host dest_ip threat_type action
```

Purpose:
- Reduce false positives
- Add behavioral confirmation

---

## ⏱️ ENRICHED IOC TIMELINE

```spl
index=*
| lookup threat_intel ioc_value AS indicator OUTPUT threat_level source campaign
| sort _time
| table _time indicator threat_level source campaign user host action
```

Purpose:
- Track threat activity over time
- Support incident reconstruction

---

## 🛡️ SOC & INTEL OPERATIONS NOTES
- Prioritize high-confidence and recently seen IOCs
- Avoid alerting on enrichment alone
- Combine enrichment with anomaly detections
- Track feed quality and false positives
- Expire stale indicators automatically
- Share validated IOCs with partners and ISACs

---

## 🧠 MITRE ATT&CK Mapping

| Technique | Description |
|---------|-------------|
| T1071 | Command & Control |
| T1105 | Ingress Tool Transfer |
| T1041 | Exfiltration |
| T1566 | Phishing |
| T1588 | Obtain Capabilities |

---

## 📌 Summary
This file provides **advanced hash, IP, and domain enrichment techniques** that enable SOC teams to **add intelligence context to detections**, prioritize alerts effectively, and accelerate **threat investigation and response** by transforming raw indicators into **actionable security intelligence**.

