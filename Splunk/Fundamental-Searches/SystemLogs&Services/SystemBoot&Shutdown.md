# 🔄 System Boot & Shutdown — Windows & Linux

Detection queries for identifying system startup, shutdown, reboot cycles, and unexpected system restarts.

---

# 🪟 Windows — System Boot & Shutdown

## 🔹 1. System Boot (Startup)
**Description:** Detects when the system boots up.  
**Purpose:** Helps track reboots, scheduled maintenance, or unexpected startups.

**🔍 SPL**
```
index=windows EventCode=6005
| stats count by Computer, _time
```

---

## 🔹 2. System Shutdown  
**Description:** Triggered when the system is shut down normally.  
**Purpose:** Monitors controlled shutdown activity.

**🔍 SPL**
```
index=windows EventCode=6006
| stats count by Computer, _time
```

---

## 🔹 3. Unexpected Shutdown  
**Description:** Indicates a crash, power loss, or forced shutdown.  
**Purpose:** Useful for detecting system instability or malicious forced shutdowns.

**🔍 SPL**
```
index=windows EventCode=6008
| stats count by Computer, _time, Message
```

---

## 🔹 4. Restart by Administrator or Script  
**Description:** Detects restarts initiated by users or services.  
**Purpose:** Helps identify scheduled or unauthorized restarts.

**🔍 SPL**
```
index=windows EventCode=1074
| stats count by Account_Name, Process_Name, Reason, Computer, _time
```

---

# 🐧 Linux — System Boot & Shutdown

## 🔹 5. System Boot (Startup)  
**Description:** System started or kernel booted.  
**Purpose:** Used for uptime tracking and detecting unexpected reboots.

**🔍 SPL**
```
index=linux ("systemd" AND "Started") OR message="kernel: Booting"
| stats count by host, message, _time
```

---

## 🔹 6. System Shutdown  
**Description:** Detects controlled shutdown commands.  
**Purpose:** Tracks authorized shutdown activity.

**🔍 SPL**
```
index=linux (MESSAGE="Shutting down" OR COMMAND="/sbin/shutdown")
| stats count by host, user, COMMAND, _time
```

---

## 🔹 7. System Reboot Events  
**Description:** Captures reboot events from logs.  
**Purpose:** Helps identify automatic restarts or maintenance cycles.

**🔍 SPL**
```
index=linux (MESSAGE="reboot" OR MESSAGE="Restarting system")
| stats count by host, message, _time
```

---

## 🔹 8. Unexpected / Crash Reboots  
**Description:** Detects sudden restarts caused by kernel issues or hardware failure.  
**Purpose:** Useful for troubleshooting or security incident response.

**🔍 SPL**
```
index=linux (MESSAGE="Kernel panic" OR MESSAGE="fatal" OR MESSAGE="crash")
| stats count by host, message, _time
```
