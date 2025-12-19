# ⛓️ Script Chaining Detection
## Endpoint Advanced Analytics (Windows • Linux • macOS)

This document focuses on **script chaining detection**, an advanced endpoint analytics technique that identifies **multi-stage attacks where scripts invoke other scripts, interpreters, or native binaries** to deliver payloads, evade detection, and progress through post-exploitation.

Script chaining is heavily used in:
- Fileless malware
- Living-off-the-Land (LOLBin) attacks
- Initial access via phishing
- Privilege escalation
- Lateral movement preparation

Designed for:
- SOC Tier 2 / Tier 3 Analysts
- Endpoint Security Engineers
- Threat Hunters
- Detection Engineers
- Splunk Mastery – Advanced Searches

---

## 🎯 Objectives
- Detect chained script execution patterns
- Identify abuse of scripting engines
- Expose fileless and staged attacks
- Correlate script chains with network and file activity
- Support endpoint attack-chain reconstruction

---

## 🧠 What Is Script Chaining?

Script chaining occurs when:
- One script launches another script
- Scripts invoke shells or interpreters
- Scripts spawn native binaries (LOLBins)
- Multiple execution stages occur in rapid sequence

Examples:
- VBA → PowerShell → cmd → payload
- PowerShell → mshta → rundll32
- Bash → curl → chmod → execute
- Python → subprocess → shell

> Scripts are rarely the payload — they are the **delivery system**.

---

## 🧠 Common Data Sources

| Platform | Logs |
|--------|------|
| Windows | Sysmon (EID 1), Security 4688, EDR |
| Linux | auditd, syslog, EDR |
| macOS | Unified Logs, EDR |

Normalized fields assumed:
- `process_name`
- `parent_process`
- `command_line`
- `user`
- `host`
- `process_id`
- `parent_process_id`

---

## 🟡 BASELINE SCRIPT EXECUTION

### 🔍 Normal Script Parent → Child Patterns
```spl
index=endpoint_logs
| search process_name IN ("powershell.exe","wscript.exe","cscript.exe","bash","sh","python","perl")
| stats count by parent_process process_name
```

Purpose:
- Establish expected script usage
- Identify abnormal chains later

---

## 🔴 SCRIPT → SCRIPT CHAINING

### ⛓️ One Script Launching Another Script
```spl
index=endpoint_logs
| search parent_process IN ("powershell.exe","wscript.exe","cscript.exe","bash","sh","python","perl")
| search process_name IN ("powershell.exe","wscript.exe","cscript.exe","bash","sh","python","perl")
| table _time host user parent_process process_name command_line
```

Purpose:
- Detect multi-stage script loaders
- Identify fileless attack progression

---

## 🟠 SCRIPT → LOLBIN EXECUTION

### 🧪 Scripts Spawning Native Binaries
```spl
index=endpoint_logs
| search parent_process IN ("powershell.exe","wscript.exe","cscript.exe","bash","sh","python")
| search process_name IN ("cmd.exe","mshta.exe","rundll32.exe","regsvr32.exe","curl","wget")
| table _time host user parent_process process_name command_line
```

Purpose:
- Detect LOLBin abuse
- Identify stealthy payload execution

---

## 🔵 SCRIPT-DRIVEN DOWNLOAD CHAINS

### 🌐 Script → Network Tool → Execute
```spl
index=endpoint_logs
| search parent_process IN ("powershell.exe","bash","sh","python")
| search command_line="*curl*" OR command_line="*wget*" OR command_line="*Invoke-WebRequest*"
| table _time host user parent_process process_name command_line
```

Purpose:
- Detect payload staging
- Identify malware delivery chains

---

## 🟣 SCRIPT CHAINING WITH OBFUSCATION

### 🧬 Encoded or Obfuscated Script Execution
```spl
index=endpoint_logs
| search command_line="*-enc*" OR command_line="*base64*" OR command_line="*FromBase64String*"
| table _time host user parent_process process_name command_line
```

Purpose:
- Detect evasion techniques
- Identify hidden payload delivery

---

## 🔥 RARE OR FIRST-SEEN SCRIPT CHAINS

### 🎯 Uncommon Script Execution Paths
```spl
index=endpoint_logs
| stats count by parent_process process_name
| where count < 3
```

Purpose:
- Detect rare execution patterns
- Catch early-stage or targeted attacks

---

## 🔗 SCRIPT CHAIN + NETWORK CORRELATION

### 🌐 Script Execution Followed by Network Activity
```spl
index IN (endpoint_logs, network_logs)
| table _time host user process_name dest_ip dest_port
```

Purpose:
- Confirm script-led C2 or exfiltration
- Increase detection confidence

---

## 🔗 SCRIPT CHAIN + FILE SYSTEM ACTIVITY

### 📂 Script Writing or Executing Files
```spl
index IN (endpoint_logs, file_logs)
| table _time host user process_name file_path action
```

Purpose:
- Detect dropper behavior
- Identify persistence preparation

---

## ⏱️ SCRIPT CHAIN TIMELINE

```spl
index=endpoint_logs
| sort _time
| table _time host user parent_process process_name command_line
```

Purpose:
- Reconstruct multi-stage execution
- Support endpoint forensics

---

## 🛡️ SOC RESPONSE & ENDPOINT IR NOTES
- Isolate host immediately if malicious chaining confirmed
- Capture full process tree and command-line history
- Retrieve scripts and downloaded artifacts
- Inspect persistence mechanisms
- Check lateral movement attempts
- Reset credentials used during execution

---

## 🧠 MITRE ATT&CK Mapping

| Technique | Description |
|---------|-------------|
| T1059 | Command and Scripting Interpreter |
| T1204 | User Execution |
| T1106 | Native API |
| T1055 | Process Injection |
| T1105 | Ingress Tool Transfer |

---

## 📌 Summary
This file provides **advanced script chaining detection techniques** that enable SOC and endpoint security teams to uncover **fileless malware, LOLBin abuse, staged payload delivery, and post-exploitation activity** by analyzing **how scripts invoke and chain execution across interpreters and binaries**.

Script chaining reveals **how attackers move step-by-step** —  
not just where they land.

