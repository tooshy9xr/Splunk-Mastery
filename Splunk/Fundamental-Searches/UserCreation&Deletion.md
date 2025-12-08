# 🌟 User Creation & Deletion — Windows & Linux

A beginner-friendly list of Splunk searches to monitor user account creation and deletion on Windows and Linux systems. Each search includes a short description, purpose, and SPL query.

---

## 🖥️ Windows User Management

🔹 **1. User Creation Events**

**Description:** Displays events where new user accounts are created.

**Purpose:** Monitors the addition of new accounts for auditing and security.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=4720
```

---

🔹 **2. User Deletion Events**

**Description:** Displays events where user accounts are deleted.

**Purpose:** Detects account removals that may indicate security incidents.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=4726
```

---

🔹 **3. User Modification Events**

**Description:** Displays events where user accounts are modified (passwords, groups, privileges).

**Purpose:** Monitors account changes that could affect security or compliance.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=4738
```

---

🔹 **4. Disabled Accounts**

**Description:** Shows events where user accounts are disabled.

**Purpose:** Detects administrative actions or potentially malicious account deactivation.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=4725
```

---

🔹 **5. User Changes per Hour**

**Description:** Time-based chart showing user creation, deletion, and modification events per hour.

**Purpose:** Identifies unusual spikes in user management activity.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=4720 OR EventCode=4726 OR EventCode=4738 OR EventCode=4725 | timechart span=1h count
```

---

## 🐧 Linux User Management

🔹 **1. User Creation Events**

**Description:** Displays events where new Linux user accounts are added.

**Purpose:** Monitors account additions for auditing and security.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_secure action=useradd
```

---

🔹 **2. User Deletion Events**

**Description:** Displays events where Linux user accounts are removed.

**Purpose:** Detects account deletions that may indicate security incidents.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_secure action=userdel
```

---

🔹 **3. User Modification Events**

**Description:** Shows events where Linux users are modified (groups, passwords, permissions).

**Purpose:** Monitors account changes for security and compliance.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_secure action=usermod
```

---

🔹 **4. Disabled Accounts**

**Description:** Displays events where Linux accounts are disabled.

**Purpose:** Helps detect administrative actions or potential malicious activity.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_secure action=disable_user
```

---

🔹 **5. User Changes per Hour**

**Description:** Time-based chart showing creation, deletion, and modification of Linux users per hour.

**Purpose:** Detects unusual spikes in user management activity.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_secure action=useradd OR action=userdel OR action=usermod OR action=disable_user | timechart span=1h count
```
