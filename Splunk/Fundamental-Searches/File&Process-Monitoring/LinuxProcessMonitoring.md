# 🌟 Linux Process Monitoring — English

A beginner-friendly list of Splunk searches to monitor processes on Linux, with short descriptions, purpose, and ready SPL queries.

---

🔹 **1. Basic Process Listing**

**Description:** Shows all active processes on the Linux system.

**Purpose:** Provides visibility of all running processes.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_process
```

---

🔹 **2. Processes by User**

**Description:** Counts the number of processes run by each user.

**Purpose:** Helps identify which users are running the most processes.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_process | stats count by user
```

---

🔹 **3. Processes by Name**

**Description:** Counts processes grouped by process name.

**Purpose:** Identifies common or potentially suspicious processes.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_process | stats count by process_name
```

---

🔹 **4. Processes by PID**

**Description:** Displays processes along with their Process ID (PID) and Parent PID.

**Purpose:** Useful for tracking specific processes and their details.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_process | table _time user process_name pid parent_pid
```

---

🔹 **5. Processes per Hour**

**Description:** Time-based chart showing the number of processes run per hour.

**Purpose:** Helps detect unusual activity spikes.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_process | timechart span=1h count
```

---

🔹 **6. Suspicious Processes**

**Description:** Displays processes with unusual or suspicious names.

**Purpose:** Helps detect potential malicious activity on the system.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_process process_name="*suspicious*"
```
