# 🏷️ Splunk Tags — Complete Guide  
How Tags Work, Why They Matter, and How to Build a Tagging Strategy

Splunk **tags** allow you to attach meaningful labels to **fields** or **event types** so you can categorize, normalize, and search data more efficiently.  
Tags are essential for **CIM (Common Information Model)**, **Splunk Enterprise Security**, and **SOC operations**.

---

# 1️⃣ What Are Tags in Splunk?

A **tag** is a label assigned to:
- A **field-value pair**, or  
- An **event type**

Tags enable human-friendly, consistent classification across your entire dataset.

Example:
```
tag=authentication  
tag=network  
tag=privilege  
```

These tags make it easier to run broad searches:
```spl
tag=authentication tag=failure
```

---

# 2️⃣ Why Tags Are Important

Tags are used for:

- Normalizing different log types  
- Standardizing how SOC teams classify events  
- Powering Splunk Enterprise Security use cases  
- Reducing complex searches  
- Mapping data to CIM data models  
- Improving detection, dashboards, and correlation rules  

Tags make cross-platform searches simple:
```spl
tag=process tag=create
```
Works for Linux, Windows, cloud, or EDR automatically.

---

# 3️⃣ Where Tags Are Defined

Tags are managed in:

```
tags.conf
```

Example:
```
[host=localhost]
web = enabled
production = enabled
```

Or through the UI:
```
Settings → Tags
```

---

# 4️⃣ Tag Structure

A tag applies to **field=value** pairs.

Example:
```
Field:    action  
Value:    failure  
Tag:      authentication  
```

In tags.conf:
```
[action=failure]
authentication = enabled
failure = enabled
```

---

# 5️⃣ Tags vs Event Types

| Feature | Tags | Event Types |
|---------|------|-------------|
| Applies to field=value | Yes | No |
| Applies to entire event | No | Yes |
| Contains search logic | No | Yes |
| Used in CIM | Yes | Yes |
| Search example | `tag=authentication` | `eventtype=windows_logon` |

Tags = labels  
Event Types = logic + label  

They work *together*.

---

# 6️⃣ CIM Tags (Standard Tags for Normalization)

Splunk CIM relies heavily on TAGS.

### 🔐 Authentication
- `authentication`
- `success`
- `failure`
- `account`
- `access`

### 👤 User & Privilege
- `user`
- `privileged_user`
- `identity`
- `role_change`

### ⚙️ System
- `system`
- `boot`
- `shutdown`
- `process`
- `service`

### 📁 File Activity
- `file`
- `read`
- `write`
- `delete`

### 🌐 Network
- `network`
- `dns`
- `http`
- `email`
- `proxy`
- `connection`

### 🛡 Security
- `security`
- `malware`
- `attack`
- `endpoint`
- `permission_change`

### ☁️ Cloud
- `cloud`
- `iam`
- `api`
- `resource_change`

### 🚨 Alerts
- `alert`
- `critical`
- `warning`

---

# 7️⃣ Tag Examples (tags.conf)

### 🔹 Tagging authentication failures
```
[action=failure]
authentication = enabled
failure = enabled
```

### 🔹 Tagging Windows process creation
```
[EventCode=4688]
process = enabled
create = enabled
endpoint = enabled
```

### 🔹 Tagging DNS queries
```
[sourcetype=dns_logs]
network = enabled
dns = enabled
query = enabled
```

### 🔹 Tagging firewall denials
```
[action=blocked]
network = enabled
firewall = enabled
deny = enabled
```

---

# 8️⃣ Searching with Tags

### 🔹 Search all authentication-related logs:
```spl
tag=authentication
```

### 🔹 Failed login attempts:
```spl
tag=authentication tag=failure
```

### 🔹 All process creation events:
```spl
tag=process tag=create
```

### 🔹 All network connections:
```spl
tag=network tag=connection
```

### 🔹 All malware detections:
```spl
tag=malware
```

---

# 9️⃣ Tagging Strategy for SOC / SIEM Projects

To keep your project organized:

### ✔ Use CIM-compatible tags  
This ensures dashboards, detections, and correlation rules work across all data sources.

### ✔ Use descriptive tags  
Examples:
- `dns`
- `email`
- `proxy`
- `file`
- `process`

### ✔ Avoid duplicate or unclear tags  
Don’t use:
```
tag=temp  
tag=test  
tag=new
```

### ✔ Document your tags  
Create a README.md explaining:
- Each tag  
- Its purpose  
- What fields it applies to  

### ✔ Keep tags short  
Use:
```
process, create, dns, connection
```
Not:
```
windows_process_creation_log_event
```

---

# 🔟 Recommended Tag Taxonomy for Your Project

Here is a complete tag hierarchy you can use.

## Authentication
`authentication, login, success, failure, account, access`

## User / Identity
`user, identity, privilege, role_change`

## System
`system, boot, shutdown, process, service, config_change`

## Application
`app, api, error, database, query`

## Network
`network, dns, http, proxy, firewall, connection, vpn`

## File
`file, read, write, modify, delete`

## Endpoint Security
`endpoint, malware, exploit, detection, quarantine`

## Cloud
`cloud, iam, audit, api, resource`

## Threat / Alerts
`security, alert, attack, command_control, critical, suspicious`

---

# ✅ Summary

Tags provide:
- Data normalization  
- Search shortcuts  
- CIM compatibility  
- Better dashboards  
- Improved threat hunting  
- Stronger correlation rules  

Tags work best **with event types and CIM field models** to create a powerful, organized Splunk environment.

.
