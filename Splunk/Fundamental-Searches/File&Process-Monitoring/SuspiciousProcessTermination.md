# ❌ Suspicious Process Termination — Windows & Linux

Detection queries for identifying abnormal, forced, or malicious termination of processes that may indicate kill-switch activity, malware cleanup, or anti-forensic behavior.

---

# 🪟 Windows — Suspicious Process Termination

## 🔹 1. Process Killed by Task Manager  
**Description:** Detects when a user manually ends a process.  
**Purpose:** Useful for spotting unauthorized or unusual manual process termination.

**🔍 SPL**
```
index=windows EventCode=4689
| stats count by Process_Name, Account_Name, Exit_Status, Computer, _time
```

---

## 🔹 2. Process Terminated by Another Process  
**Description:** Identifies when one process forcefully kills another.  
**Purpose:** Helps detect malware or scripts terminating security tools.

**🔍 SPL**
```
index=windows EventCode=1 sourcetype="Sysmon" 
| stats count by ParentImage, Image, Computer, _time
```

---

## 🔹 3. Antivirus / Security Tool Stopped  
**Description:** Detects when AV or security agents are terminated.  
**Purpose:** High-risk indicator of malicious activity attempting to disable defenses.

**🔍 SPL**
```
index=windows (Process_Name="MsMpEng.exe" OR Process_Name="WRSA.exe" OR Process_Name="savservice.exe") Exit_Status="*"
| stats count by Process_Name, Account_Name, Computer, _time
```

---

## 🔹 4. Suspicious Script Killing Processes  
**Description:** Detects PowerShell or cmd scripts terminating multiple processes.  
**Purpose:** Identifies malware or cleanup operations.

**🔍 SPL**
```
index=windows EventCode=4104 ("Stop-Process" OR "taskkill")
| stats count by Account_Name, ScriptBlockText, Computer, _time
```

---

# 🐧 Linux — Suspicious Process Termination

## 🔹 5. Process Killed (SIGKILL, SIGTERM)  
**Description:** Detects when critical processes receive kill signals.  
**Purpose:** Useful for spotting forced shutdowns or malicious interference.

**🔍 SPL**
```
index=linux ("killed" OR "terminated" OR "SIGKILL" OR "SIGTERM")
| stats count by host, process, pid, message, _time
```

---

## 🔹 6. Unauthorized Kill Command Usage  
**Description:** Detects usage of the `kill` or `killall` commands.  
**Purpose:** Helps identify suspicious administrative or automated process termination.

**🔍 SPL**
```
index=linux COMMAND="kill*" OR COMMAND="killall*"
| stats count by user, COMMAND, host, _time
```

---

## 🔹 7. Security Tools Terminated (Linux AV, EDR, Agents)  
**Description:** Logs when security tools or agents are stopped.  
**Purpose:** Often used by attackers to disable detection.

**🔍 SPL**
```
index=linux ("stopped" OR "terminated") ("auditd" OR "falcon-sensor" OR "osqueryd" OR "clamd")
| stats count by host, process, message, _time
```

---

## 🔹 8. High-Value Process Unexpectedly Stopped  
**Description:** Detects termination of critical processes (ssh, systemd, nginx, databases).  
**Purpose:** Indicates malicious disruption or system instability.

**🔍 SPL**
```
index=linux ("stopped" OR "failed") (process="ssh" OR process="nginx" OR process="mysqld" OR process="systemd")
| stats count by host, process, message, _time
```
