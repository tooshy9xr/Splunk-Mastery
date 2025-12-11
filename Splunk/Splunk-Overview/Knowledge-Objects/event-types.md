# 🧩 Splunk Event Types — Complete Guide  
Understanding Event Categorization, How They Work, and Why SOC Teams Use Them

Event types in Splunk allow you to **categorize events** based on search criteria.  
They are essentially *saved searches* that tag events dynamically at **search time**, enabling consistent classification for dashboards, alerts, and correlation rules.

---

# 1️⃣ What Are Event Types?

An **event type** is a saved rule that applies a label to events that match specific search conditions.

Example:

Search rule:
```
index=windows sourcetype=WinEventLog:Security EventCode=4624
```

Event type:
```
eventtype=windows_successful_login
```

Any event matching the search criteria gets the event type attached automatically.

---

# 2️⃣ Why Event Types Matter

Event types provide:
- Normalization  
- Consistency across dashboards  
- Easy tagging  
- Better management of complex datasets  
- Input to correlation searches  
- Improved CIM compliance (used heavily in Splunk ES)

Used for:
- SOC operations  
- Threat detection  
- Incident response  
- App dashboards  
- Report generation  

---

# 3️⃣ Event Types vs Tags

| Feature | Event Types | Tags |
|---------|-------------|------|
| Search logic | Yes | No |
| Human-friendly names | Yes | Yes |
| Used for CIM | Yes | Yes |
| Used for dashboards | Yes | Yes |
| Attached to fields | No | Yes |

Event type = logic  
Tag = label attached to fields  

They often work together.

---

# 4️⃣ Creating Event Types

### 📌 Via Splunk UI
Navigate:
```
Settings → Event types → New
```

Specify:
- Search expression  
- Priority (1–10)  
- Tags  
- Description  

### 📌 Via Configuration Files  
In:
```
eventtypes.conf
```

Example:
```
[windows_failed_login]
search = index=windows EventCode=4625
priority = 1
tags = authentication, failure
```

---

# 5️⃣ Priority System (1–10)

Lower number = higher priority.

Why priority matters:
- Controls which event type overrides another  
- Defines event classification order  
- Avoids conflicts  

Example:
- `priority=1` → critical security events  
- `priority=10` → general informational categories  

---

# 6️⃣ Best Practices for Event Type Naming

Use consistent naming:

### Recommended Format:
```
<platform>_<category>_<action>
```

Examples:
```
linux_auth_failed
windows_process_creation
network_dns_query
web_access_success
```

---

# 7️⃣ Recommended Event Type Categories

Below is a full list you can use for your SOC / detection project.

---

## 🟦 Authentication
- `auth_success`
- `auth_failed`
- `multi_factor_auth`
- `password_change`
- `account_lockout`

---

## 🟧 Privilege & User Activity
- `privilege_change`
- `user_creation`
- `user_deletion`
- `sudo_usage`
- `role_assignment`

---

## 🟨 System Activity
- `system_boot`
- `system_shutdown`
- `service_start`
- `service_stop`
- `software_install`

---

## 🟥 Network Activity
- `dns_query`
- `dhcp_lease`
- `vpn_login`
- `proxy_access`
- `firewall_denied`

---

## 🟩 Security Alerts
- `malware_detected`
- `ransomware_signal`
- `phishing_event`
- `IDS_alert`
- `antivirus_event`

---

## 🟫 Application Activity
- `app_error`
- `app_warning`
- `db_query`
- `web_access`
- `api_request`

---

## 🟪 File & Process Events
- `file_access`
- `file_delete`
- `process_start`
- `process_stop`
- `suspicious_process`

---

## 🟫 Cloud Events
- `aws_auth`
- `azure_resource_change`
- `gcp_logs`
- `iam_policy_change`

---

# 8️⃣ Tags for Event Types

Event types often include tags so Splunk ES and dashboards can classify them easily.

Examples:
```
authentication
access
endpoint
network
security
malware
privilege
file
web
```

Attached in `tags.conf`:
```
[eventtype=auth_failed]
authentication = enabled
failure = enabled
```

---

# 9️⃣ Event Types in SPL

Search for event type:
```spl
eventtype=windows_process_creation
```

List events and their event types:
```spl
| stats count by eventtype
```

List event types assigned to your events:
```spl
| metadata type=eventtypes
```

---

# 🔟 Best Practices

- Keep search patterns simple  
- Avoid overly broad event types  
- Standardize naming across all apps  
- Assign priorities correctly  
- Use tags for CIM & Splunk ES compatibility  
- Document each event type in README files  
- Combine with macros for reusability  

---

# ✅ Summary

Event types help you:
- Classify logs consistently  
- Build dashboards faster  
- Improve detection rules  
- Standardize SOC workflows  
- Map data to CIM for Splunk ES  

They are foundational for **enterprise-level Splunk deployments** and should be carefully designed.

This file is ready to use as `event-types.md` in your GitHub documentation.
