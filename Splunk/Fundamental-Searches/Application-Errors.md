# 🚨 Application Errors — Windows & Linux

Detection queries for identifying crashes, failures, and abnormal behavior in system or user applications.

---

# 🪟 Windows — Application Errors

## 🔹 1. Application Crash (EventCode 1000)  
**Description:** Detects when an application crashes unexpectedly.  
**Purpose:** Helps identify unstable applications or potential exploit attempts.

**🔍 SPL**
```
index=windows EventCode=1000
| stats count by Computer, Process_Name, Message, _time
```

---

## 🔹 2. Application Hang (EventCode 1002)  
**Description:** Triggered when an app becomes unresponsive.  
**Purpose:** Useful for diagnosing system performance or suspicious hangs.

**🔍 SPL**
```
index=windows EventCode=1002
| stats count by Computer, Process_Name, Message, _time
```

---

## 🔹 3. Application Error in System Log (EventCode 1001)  
**Description:** Indicates errors logged during app recovery or crash reporting.  
**Purpose:** Helps identify repeated failures.

**🔍 SPL**
```
index=windows EventCode=1001
| stats count by Computer, Message, _time
```

---

## 🔹 4. PowerShell Errors  
**Description:** Detects PowerShell execution errors.  
**Purpose:** Helps identify script misuse or failed malicious activity.

**🔍 SPL**
```
index=windows EventCode=4103 Level=Error
| stats count by Account_Name, ScriptBlockText, Computer, _time
```

---

# 🐧 Linux — Application Errors

## 🔹 5. Application Segmentation Faults  
**Description:** Detects app crashes caused by segmentation faults.  
**Purpose:** Useful for debugging and detecting exploitation attempts.

**🔍 SPL**
```
index=linux ("segfault" OR "segmentation fault")
| stats count by host, process, pid, message, _time
```

---

## 🔹 6. Application Errors in Syslog  
**Description:** General Linux app error logs.  
**Purpose:** Helps track failures in user and system applications.

**🔍 SPL**
```
index=linux ("error" OR "failed" OR "fatal") NOT ("ssh" OR "auth")
| stats count by host, process, message, _time
```

---

## 🔹 7. Service/Application Failure (systemd)  
**Description:** Detects services that enter a failed state.  
**Purpose:** Helps identify broken apps or suspicious interruptions.

**🔍 SPL**
```
index=linux ("systemd" AND "failed")
| stats count by host, unit, message, _time
```

---

## 🔹 8. Core Dump Detected  
**Description:** Logs when an application generates a core dump.  
**Purpose:** Helpful for analyzing crashes or potential exploitation attempts.

**🔍 SPL**
```
index=linux ("core dumped" OR "core dump")
| stats count by host, process, pid, message, _time
```
