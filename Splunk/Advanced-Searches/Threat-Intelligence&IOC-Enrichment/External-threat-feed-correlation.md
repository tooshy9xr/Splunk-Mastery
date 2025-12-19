# 🌐 External Threat Feed Correlation
## Threat Intelligence & IOC Enrichment (Advanced Splunk Detection Engineering)

This document focuses on **correlating internal security telemetry with external threat intelligence feeds**, enabling SOC teams to detect **known malicious infrastructure, attacker tools, and active campaigns** in real time.

Threat intelligence correlation enhances detections by:
- Adding external context to internal events
- Increasing confidence and prioritization
- Reducing investigation time
- Connecting isolated alerts into campaigns

Designed for:
- SOC Tier 2 / Tier 3 Analysts
- Threat Hunters
- Detection Engineers
- Threat Intelligence Teams
- Splunk Mastery – Advanced Searches

---

## 🎯 Objectives
- Correlate logs with external IOC feeds
- Detect known malicious IPs, domains, hashes, and URLs
- Enrich alerts with threat context
- Support faster triage and response
- Bridge internal detections with global threat activity

---

## 🧠 What Is External Threat Feed Correlation?

External threat feed correlation involves:
- Ingesting third-party threat intelligence
- Matching indicators against internal logs
- Enriching events with reputation, actor, and campaign data

Common threat feeds include:
- IP and domain blacklists
- Malware hash feeds
- C2 infrastructure feeds
- Phishing and fraud feeds
- APT and campaign reports

> Intelligence turns alerts into **answers**.

---

## 🧠 Common Threat Intelligence Sources

| Source Type | Examples |
|------------|----------|
| Commercial Feeds | Recorded Future, Mandiant, CrowdStrike |
| Open Source | AbuseIPDB, AlienVault OTX, Spamhaus |
| ISAC / Sharing | FS-ISAC, CERTs |
| Vendor Feeds | Cloud providers, firewall vendors |
| Internal TI | Previous incidents, honeypots |

---

## 🟡 INGESTING THREAT INTELLIGENCE

### 🔍 Example IOC Index
Assume threat intel is stored in:
- `index=threat_intel`
- Fields: `ioc_type`, `ioc_value`, `threat_level`, `source`, `confidence`

---

## 🔴 IP ADDRESS CORRELATION

### 🌐 Match Network Traffic Against Malicious IPs
```spl
index=network_logs
| lookup threat_intel ioc_value AS dest_ip OUTPUT threat_level source confidence
| where isnotnull(threat_level)
```

Purpose:
- Detect communication with known malicious IPs
- Identify C2 or staging servers

---

## 🟠 DOMAIN & URL CORRELATION

### 🔗 DNS / Proxy Correlation
```spl
index IN (dns_logs, proxy_logs)
| lookup threat_intel ioc_value AS query OUTPUT threat_level source confidence
| where isnotnull(threat_level)
```

Purpose:
- Detect malicious domains and phishing infrastructure
- Identify early-stage compromise

---

## 🔵 HASH CORRELATION

### 🧬 Malware Hash Matching
```spl
index IN (windows_logs, linux_logs, edr_logs)
| lookup threat_intel ioc_value AS file_hash OUTPUT threat_level source confidence
| where isnotnull(threat_level)
```

Purpose:
- Detect known malware execution
- Identify reused attacker tooling

---

## 🟣 CLOUD IOC CORRELATION

### ☁️ Malicious Cloud API or IP Usage
```spl
index=cloud_logs
| lookup threat_intel ioc_value AS sourceIPAddress OUTPUT threat_level source confidence
| where isnotnull(threat_level)
```

Purpose:
- Detect compromised cloud workloads
- Identify attacker-controlled infrastructure

---

## 🔥 MULTI-IOC CORRELATION (HIGH CONFIDENCE)

### 🔗 Multiple Indicators in One Session
```spl
index=*
| lookup threat_intel ioc_value AS indicator OUTPUT threat_level
| stats count dc(ioc_value) AS ioc_hits by host user
| where ioc_hits > 1
```

Purpose:
- Detect active compromise
- Increase alert confidence

---

## 🔗 IOC + BEHAVIOR CORRELATION

### 🧠 Threat Intel + Anomalous Behavior
```spl
index IN (network_logs, windows_logs, linux_logs)
| lookup threat_intel ioc_value AS dest_ip OUTPUT threat_level
| where isnotnull(threat_level)
| table _time user host dest_ip action
```

Purpose:
- Combine reputation with behavior
- Reduce false positives

---

## ⏱️ THREAT INTEL CORRELATION TIMELINE

```spl
index=*
| lookup threat_intel ioc_value AS indicator OUTPUT threat_level source
| sort _time
| table _time indicator threat_level source user host action
```

Purpose:
- Track threat activity over time
- Support incident reconstruction

---

## 🛡️ SOC RESPONSE & INTEL HANDLING NOTES
- Validate IOC confidence and freshness
- Prioritize high-confidence and multi-feed hits
- Combine TI hits with anomaly detections
- Avoid alerting on stale or low-confidence IOCs
- Track false positives and tune feeds
- Share validated IOCs back to intel teams

---

## 🧠 MITRE ATT&CK Mapping

| Technique | Description |
|---------|-------------|
| T1071 | Command & Control |
| T1041 | Exfiltration |
| T1566 | Phishing |
| T1105 | Ingress Tool Transfer |
| T1588 | Obtain Capabilities |

---

## 📌 Summary
This file provides **advanced external threat intelligence correlation techniques** that enable SOC teams to **enrich detections with global threat context**, identify **known attacker infrastructure**, and accelerate **triage, investigation, and response** by connecting **internal telemetry with external intelligence feeds**.

