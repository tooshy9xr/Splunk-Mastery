# 🗑️ Log Deletion Attempts — Windows & Linux

Detection queries for identifying attempts to clear, erase, or tamper with security, system, and audit logs.

---

# 🪟 Windows — Log Deletion Attempts

## 🔹 1. Security Log Cleared  
**Description:** Triggered when the Windows Security log is cleared.  
**Purpose:** High-risk event often linked to attackers covering tracks.

**🔍 SPL**
```
index=windows EventCode=1102
| stats count by Account_Name, Computer, _time
```

---

## 🔹 2. System / Application Logs Cleared  
**Description:** Detects clearing of system or application logs.  
**Purpose:** Useful for identifying log wipe operations.

**🔍 SPL**
```
index=windows (EventCode=104)
| stats count by Channel, Account_Name, Computer, _time
```

---

## 🔹 3. Clearing Logs Using Wevtutil  
**Description:** Detects manual log clearing via command-line tool.  
**Purpose:** Indicates deliberate log manipulation.

**🔍 SPL**
```
index=windows Process_Name="wevtutil.exe" CommandLine="*clear-log*"
| stats count by Account_Name, CommandLine, Computer, _time
```

---

## 🔹 4. Suspicious PowerShell Log Clearing  
**Description:** Detects clearing logs with PowerShell commands.  
**Purpose:** Attackers often use PowerShell to hide activity.

**🔍 SPL**
```
index=windows EventCode=4104 ("Clear-EventLog" OR "wevtutil")
| stats count by Account_Name, ScriptBlockText, Computer, _time
```

---

# 🐧 Linux — Log Deletion Attempts

## 🔹 5. Log File Deletion (rm on /var/log)  
**Description:** Detects deletion of log files.  
**Purpose:** Indicates attempts to erase audit trails.

**🔍 SPL**
```
index=linux sourcetype=linux_audit file="/var/log/*" action=deleted
| stats count by user, file, process, host, _time
```

---

## 🔹 6. Log Truncation ("> file" or ": > file")  
**Description:** Detects truncating logs to empty them without deleting.  
**Purpose:** Stealthy method attackers use to hide activity.

**🔍 SPL**
```
index=linux (COMMAND="*> /var/log/*" OR COMMAND=": > /var/log/*")
| stats count by user, COMMAND, host, _time
```

---

## 🔹 7. Clearing Logs with shred or wipe  
**Description:** Detects secure deletion tools used on log paths.  
**Purpose:** Strong indicator of malicious tampering.

**🔍 SPL**
```
index=linux (COMMAND="shred*" OR COMMAND="wipe*") "/var/log/"
| stats count by user, COMMAND, host, _time
```

---

## 🔹 8. Manual Log Removal Using rm  
**Description:** Detects use of `rm -rf` against log directories.  
**Purpose:** Critical alert for attempted cleanup of evidence.

**🔍 SPL**
```
index=linux COMMAND="rm*" "/var/log/"
| stats count by user, COMMAND, host, _time
```
