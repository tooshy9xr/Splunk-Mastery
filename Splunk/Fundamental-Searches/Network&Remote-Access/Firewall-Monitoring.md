# 🌟 Firewall & Network Monitoring — Windows & Linux

A beginner-friendly list of Splunk searches to monitor firewall and network events on Windows and Linux systems. Each search includes a short description, purpose, and SPL query.

---

## 🖥️ Windows Firewall & Network

🔹 **1. Blocked Connections**

**Description:** Displays firewall events where connections were blocked.

**Purpose:** Helps identify unauthorized access attempts.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=5152
```

---

🔹 **2. Allowed Connections**

**Description:** Displays firewall events where connections were allowed.

**Purpose:** Monitors normal network traffic.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=5156
```

---

🔹 **3. Network Connections by IP**

**Description:** Counts network connections grouped by source or destination IP.

**Purpose:** Helps detect unusual traffic or repeated access from a single IP.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=5156 | stats count by SourceAddress, DestinationAddress
```

---

🔹 **4. Connections by Port**

**Description:** Displays network activity by port number.

**Purpose:** Monitors which services are accessed most frequently.

**🔍 SPL:**

```spl
index=windows sourcetype=WinEventLog:Security EventCode=5156 | stats count by DestinationPort
```

---

## 🐧 Linux Firewall & Network

🔹 **1. Dropped Packets**

**Description:** Shows dropped packets by Linux firewall (iptables or ufw).

**Purpose:** Identifies blocked or unauthorized connection attempts.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_firewall action=drop
```

---

🔹 **2. Allowed Packets**

**Description:** Displays allowed network connections through the firewall.

**Purpose:** Monitors normal traffic flows.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_firewall action=accept
```

---

🔹 **3. Network Connections by IP**

**Description:** Counts connections grouped by source or destination IP.

**Purpose:** Detects unusual traffic or repeated access from a single IP.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_firewall | stats count by src_ip, dest_ip
```

---

🔹 **4. Connections by Port**

**Description:** Displays network activity by port.

**Purpose:** Monitors frequently used services.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_firewall | stats count by dest_port
```

---

🔹 **5. Network Traffic per Hour**

**Description:** Time-based chart showing network connection volume per hour.

**Purpose:** Detects spikes in network activity over time.

**🔍 SPL:**

```spl
index=linux sourcetype=linux_firewall | timechart span=1h count
```
