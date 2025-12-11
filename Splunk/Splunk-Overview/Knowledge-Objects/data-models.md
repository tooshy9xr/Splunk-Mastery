# 🧩 Splunk Data Models — Complete Guide  
Understanding CIM, Accelerations, Object Structures, and How SOC Teams Use Data Models

Splunk **Data Models** provide a structured, normalized layer of data built on top of raw logs.  
They allow fast, consistent, CIM-compliant searches for dashboards, analytics, and SIEM detections.

Data Models are the backbone of:
- Splunk Enterprise Security (ES)  
- Splunk ITSI  
- Threat hunting frameworks  
- Accelerated dashboards  
- Normalized queries  

---

# 1️⃣ What Are Data Models?

A **data model** is a **hierarchical, structured collection of datasets** that represent normalized event categories such as:

- Authentication  
- Network traffic  
- Email activity  
- Process execution  
- Web activity  
- Malware detections  
- Cloud audit logs  

They allow Splunk to use the same schema across different sources like:
- Windows  
- Linux  
- Firewalls  
- Proxies  
- Cloud providers  
- EDR tools  

This standardization = powerful correlations + universal searches.

---

# 2️⃣ Why Data Models Matter

Data Models provide:

### ✔ Normalized fields  
All logs follow the same naming convention (CIM fields like `src`, `dest`, `user`).

### ✔ Faster searches with acceleration  
Up to 100x faster dashboards and correlations.

### ✔ Cross-platform compatibility  
Same query works for Windows, Linux, Palo Alto, Cisco, AWS, etc.

### ✔ Object-based analytics  
Events, nodes, fields, and constraints are organized logically.

### ✔ Foundation for SIEM use cases  
Splunk ES depends almost entirely on Data Models.

---

# 3️⃣ Core Concepts of Data Models

A Splunk Data Model contains:

## 🔹 **1. Datasets**
A dataset is a structured subset of events with shared meaning.

Types:
- **Event datasets** → raw event collections  
- **Search datasets** → saved SPL  
- **Transaction datasets** → session-based groupings  

---

## 🔹 **2. Fields**
Each dataset contains standardized fields:

- Required fields (ex: `src`, `dest`, `action`)  
- Optional fields  
- Auto-extracted fields  
- Calculated fields  

---

## 🔹 **3. Hierarchy**
Data models use parent-child relationships:

```
Traffic
 ├── Web Traffic
 ├── DNS Queries
 └── Firewall Actions
```

Child datasets inherit fields from parents.

---

## 🔹 **4. Constraints**
Each dataset includes search logic that defines which events belong to it.

Example:
```
tag=authentication
tag=success
```

These constraints help Splunk automatically categorize your logs.

---

# 4️⃣ Data Model Acceleration (DMA)

Acceleration preprocesses data and stores it in specialized summaries.

Benefits:
- Extremely fast search performance  
- Efficient dashboards  
- Quick historical analysis  

Used by:
- Splunk ES  
- ITSI  
- Custom security dashboards  

### Enable acceleration:
- Via Pivot UI  
- Or in `datamodels.conf`

Example:
```
acceleration = true
acceleration.max_time = 168h
```

---

# 5️⃣ Splunk CIM (Common Information Model)

CIM provides standardized **field names**, **tags**, and **data structure** across all technologies.

Data Models = CIM + structure + acceleration.

Popular CIM Data Models include:

## Authentication
Tracks login attempts across all platforms.

## Change Analysis
Tracks system and config changes.

## Endpoint
Covers process creation, file activity, registry edits.

## Network Traffic
Covers proxy, firewall, DNS, VPN, routing.

## Email
SMTP, IMAP, spam detection, phishing.

## Web
Web access, errors, user agents.

## Intrusion Detection
IDS signatures, alerts, prevention actions.

## Cloud (AWS, Azure, GCP)
Audit logs, IAM changes, resource operations.

---

# 6️⃣ Examples of CIM Data Model Fields

### Example: Authentication DM
```
src
dest
user
action (success/failure)
app
signature
```

### Example: Network Traffic DM
```
src_ip
dest_ip
dest_port
transport
bytes_in
bytes_out
```

### Example: Endpoint DM
```
process
process_id
parent_process
file_hash
registry_path
```

This lets you write one SPL query that works globally:
```spl
| datamodel Authentication Authentication search
```

---

# 7️⃣ Searching Data Models

## 🔹 Using `tstats` (fastest method)
```spl
| tstats count from datamodel=Authentication.Authentication
```

## 🔹 Search with fields
```spl
| tstats count values(Authentication.user) by Authentication.action
```

## 🔹 Fit Data Models into dashboards
Used heavily inside ES Correlation Searches.

---

# 8️⃣ Building Your Own Data Model

Data models live inside:
```
/default/datamodels.conf
/local/datamodels.conf
```

Example structure:
```
[CustomSecurity]
acceleration = true

[CustomSecurity.AttackEvents]
constraint = tag=attack
fields = action, user, src, dest
```

Steps:
1. Identify dataset  
2. Define constraints  
3. Add CIM-compatible fields  
4. Enable acceleration  
5. Test with tstats  
6. Document structure in README.md  

---

# 9️⃣ Best Practices

- Use CIM field conventions  
- Keep dataset constraints simple  
- Don’t overload datasets with unnecessary fields  
- Use tags in constraints (`tag=process`)  
- Enable acceleration for production  
- Add documentation inside the data model file  
- Test coverage with:  
  ```
  | datamodel <name> <dataset> search
  ```
- Validate using `Pivot`  

---

# 🔟 Real-World Use Cases

## SOC Operations
- Unified login monitoring  
- Brute-force detection  
- Endpoint behavior baselining  
- Malware event mapping  
- DNS exfiltration detection  

## Threat Hunting
- Cross-platform process correlation  
- Network anomalies  
- User behavior deviations  

## Executive Dashboards
- Failures/success logins  
- Cloud audit logs  
- Network traffic volume  
- Endpoint process trends  

---

# ✅ Summary

Splunk Data Models provide:
- A unified structure for all logs  
- CIM-normalized fields  
- Extremely fast analytics with acceleration  
- Essential functionality for Splunk ES and threat hunting  
- Architecture for scalable dashboards and correlation rules  

Understanding Data Models is critical for large-scale Splunk deployments and SOC environments.

This file is ready to use as **data-models.md** in your GitHub documentation.
