# 🌟 Easy Linux Authentication Searches — Splunk

A clean, structured, and beginner-friendly list of simple Splunk searches for Linux authentication events.
Each search includes a short explanation, purpose, and the SPL query.

---

🔹 **1. Basic Successful Linux Logins**

**Description:** Displays all successful login events on Linux machines with timestamp, username, and source IP.

**Purpose:** Provides a quick view of who logged in, when, and from where.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_secure action=success
```

---

🔹 **2. Count Successful Linux Logins by User**

**Description:** Counts how many successful logins each user has on Linux systems.

**Purpose:** Helps identify the most active accounts or unusual login spikes.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_secure action=success | stats count by user
```

---

🔹 **3. Count Successful Logins by Source IP**

**Description:** Shows how many logins came from each IP address on Linux hosts.

**Purpose:** Useful for spotting repeated logins from a single IP or unfamiliar sources.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_secure action=success | stats count by src_ip
```

---

🔹 **4. Last Successful Login Per User**

**Description:** Returns the latest successful login time for each Linux user.

**Purpose:** Good for tracking user activity and verifying expected login behavior.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_secure action=success | stats latest(_time) by user
```

---

🔹 **5. Failed Linux Login Attempts**

**Description:** Displays failed login attempts on Linux machines.

**Purpose:** Helps identify potential brute force attacks or misconfigured accounts.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_secure action=failure
```

---

🔹 **6. Successful Logins per Hour**

**Description:** Simple time-based chart showing hourly successful Linux logins.

**Purpose:** Helps visualize login activity peaks or unusual patterns.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_secure action=success | timechart span=1h count
```
