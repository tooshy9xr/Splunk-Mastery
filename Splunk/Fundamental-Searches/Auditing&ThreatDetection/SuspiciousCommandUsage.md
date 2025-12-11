# 🌟 Suspicious Command Usage — Linux

A beginner-friendly list of Splunk searches to monitor suspicious command usage on Linux systems. Each search includes a short description, purpose, and SPL query.

---

🔹 **1. Basic Suspicious Commands**

**Description:** Displays command executions that match suspicious patterns.

**Purpose:** Helps detect potential malicious activity or abnormal usage.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_secure command="*rm -rf*" OR command="*nc*" OR command="*wget*"
```

---

🔹 **2. Commands by User**

**Description:** Counts suspicious command executions by user.

**Purpose:** Identifies which users may be performing risky operations.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_secure command="*rm -rf*" OR command="*nc*" | stats count by user
```

---

🔹 **3. Commands by Source IP**

**Description:** Shows suspicious command usage grouped by source IP.

**Purpose:** Detects unusual activity from specific machines or network locations.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_secure command="*rm -rf*" OR command="*nc*" | stats count by src_ip
```

---

🔹 **4. Commands per Hour**

**Description:** Time-based chart showing execution of suspicious commands per hour.

**Purpose:** Identifies spikes in risky command activity over time.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_secure command="*rm -rf*" OR command="*nc*" | timechart span=1h count
```

---

🔹 **5. Detailed Command Info**

**Description:** Displays suspicious commands along with the executing user and process details.

**Purpose:** Provides context for each suspicious command to assist in investigation.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_secure command="*rm -rf*" OR command="*nc*" | table _time user command process_name pid
```
