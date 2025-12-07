# 🌟 Windows Process Creation Searches — Splunk

A beginner-friendly list of Splunk searches to monitor process creation events on Windows machines. Each search includes a short description, purpose, and SPL query.

---

🔹 **1. Basic Process Creation**

**Description:** Shows all process creation events on Windows hosts.

**Purpose:** Helps identify new processes running on the system.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=4688
```

---

🔹 **2. Process Creation by User**

**Description:** Counts process creation events grouped by user.

**Purpose:** Identifies which users are starting processes frequently.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=4688 | stats count by Account_Name
```

---

🔹 **3. Specific Process Creation (e.g., cmd.exe)**

**Description:** Tracks creation of specific processes, like command prompt or PowerShell.

**Purpose:** Useful for detecting suspicious or administrative activity.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=4688 New_Process_Name="*cmd.exe*"
```

---

🔹 **4. Process Creation with Parent Process**

**Description:** Shows processes along with their parent process.

**Purpose:** Helps trace process lineage for forensic analysis.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=4688 | table _time Account_Name New_Process_Name Parent_Process_Name
```

---

🔹 **5. Process Creation per Hour**

**Description:** Time-based chart showing number of process creation events per hour.

**Purpose:** Detects unusual activity spikes over time.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=4688 | timechart span=1h count
```
