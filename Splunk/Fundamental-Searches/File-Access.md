# 🌟 File Access Searches — Splunk

A beginner-friendly list of Splunk searches to monitor file access events on Windows and Linux. Each search includes a short description, purpose, and SPL query.

---

## 🖥️ Windows File Access

🔹 **1. File Creation Events**

**Description:** Shows all file creation events on Windows machines.

**Purpose:** Helps detect new files being created, potentially malicious.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=4663 Object_Type=file Access_Mask=0x2
```

---

🔹 **2. File Deletion Events**

**Description:** Shows files that have been deleted.

**Purpose:** Helps track data deletion and potential tampering.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=4660
```

---

🔹 **3. File Modification Events**

**Description:** Displays modifications to files.

**Purpose:** Useful for monitoring changes to sensitive files.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=4663 Object_Type=file Access_Mask=0x4
```

---

🔹 **4. File Access by User**

**Description:** Counts file access events grouped by user.

**Purpose:** Identifies who is interacting with important files.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=4663 | stats count by Account_Name
```

---

## 🐧 Linux File Access

🔹 **1. File Read Events**

**Description:** Displays all file read events on Linux systems.

**Purpose:** Monitors sensitive file access.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_audit action=read
```

---

🔹 **2. File Write Events**

**Description:** Shows all file write events.

**Purpose:** Detects changes to important files.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_audit action=write
```

---

🔹 **3. File Delete Events**

**Description:** Displays file deletions on Linux hosts.

**Purpose:** Helps track potential data loss or malicious deletions.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_audit action=unlink
```

---

🔹 **4. File Access by User**

**Description:** Counts file access events per user.

**Purpose:** Monitors which users are accessing files frequently.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_audit | stats count by user
```

---

🔹 **5. File Access per Hour**

**Description:** Time-based chart showing hourly file access events.

**Purpose:** Identifies unusual activity peaks.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_audit | timechart span=1h count
```
