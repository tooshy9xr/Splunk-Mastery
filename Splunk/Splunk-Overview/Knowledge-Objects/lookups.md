# 🔍 Splunk Lookups — Complete Guide  
Understanding Lookup Types, How They Work, and When to Use Them

Lookups allow Splunk to **enrich events** with external data.  
They add additional fields to events at **search time**, making your data more meaningful for dashboards, detections, and correlations.

---

# 1️⃣ What Are Lookups?

A **lookup** maps fields in your events to fields in an external file, KV store, or external system to enrich or normalize data.

Example:
```
IP address → Country  
Username → Department  
Error code → Human-readable description  
```

A lookup takes this:
```
src_ip = 8.8.8.8
```

And turns it into this:
```
src_ip = 8.8.8.8
country = United States
city = Ashburn
```

---

# 2️⃣ Lookup Types

## 🟦 1. **CSV Lookups (Most Common)**
Stored as CSV files inside your Splunk app.

Example structure:
```
ip,country,city
8.8.8.8,USA,Ashburn
```

---

## 🟧 2. **KV Store Lookups**
Use Splunk’s MongoDB-like KV store for:
- Dynamic data
- Large data sets
- Persistent storage
- Fast query performance

---

## 🟨 3. **External Lookups**
Run a script to return lookup values.

Use cases:
- IP reputation APIs  
- Geo-location microservices  
- Custom Python/Perl logic  

---

## 🟥 4. **Geospatial Lookups**
Used to enrich events with **latitude/longitude**, region, or mapping information.

---

# 3️⃣ How Lookups Work

Lookups use matching fields between your event and lookup table.

Example lookup table:
```
username,department
john,IT
sara,Finance
```

Search:
```spl
index=auth
| lookup user_dept username OUTPUT department
```

Result:
```
username=john   → department=IT
```

---

# 4️⃣ Lookup Syntax (SPL)

## 🔹 Basic Lookup
```spl
| lookup lookup_name key_field OUTPUT field1 field2
```

## 🔹 Lookup With Different Field Names
```spl
| lookup hosts_lookup hostname AS src_host OUTPUT ip
```

## 🔹 Output ALL Fields
```spl
| lookup lookup_name field OUTPUTNEW *
```

`OUTPUTNEW` avoids overwriting existing fields.

---

# 5️⃣ Creating Lookups

## 🟦 1. **Upload CSV Lookup**
Navigate:
```
Settings → Lookups → Lookup table files → Add new
```

Place result CSV inside your Splunk app:
```
/SplunkApp/lookups/filename.csv
```

---

## 🟧 2. **Define Lookup Using transforms.conf**

Example:
```
[my_lookup]
filename = users.csv
match_type = WILDCARD(username)
```

---

## 🟨 3. **Map Lookup to Sourcetype or Event Type**

In `props.conf`:
```
LOOKUP-add_hostname = add_host_lookup ip OUTPUT hostname
```

This adds fields **automatically** at search time.

---

# 6️⃣ Lookup Commands

### 🔹 Check lookup contents
```spl
| inputlookup lookup_name
```

### 🔹 Add new rows to lookup (KV store)
```spl
| inputlookup ip_reputation
| append [ | makeresults | eval ip="1.1.1.1", status="malicious" ]
| outputlookup ip_reputation
```

### 🔹 Export lookup to CSV
```spl
| inputlookup lookup_name
| outputlookup new_file.csv
```

---

# 7️⃣ Common Lookup Use Cases

## 🟦 🔍 **1. IP Intelligence**
- IP reputation  
- Geo-location  
- TOR exit node detection  

Example:
```spl
| lookup ip_reputation ip OUTPUT reputation, category
```

---

## 🟧 🛂 **2. User Identity Enrichment**
- Department  
- Role  
- Device owner  
- AD group  

---

## 🟨 🧩 **3. Asset Intelligence (Servers / Endpoints)**
- Criticality rating  
- System owner  
- Business function  

---

## 🟥 📦 **4. DNS Enrichment**
- Domain categorization  
- Known malicious domains  
- Whitelist/blacklist checking  

---

## 🟩 ⚙️ **5. Application Error Normalization**
Map codes to descriptions:
```
500 → Server Error  
404 → Not Found  
403 → Forbidden  
```

---

## 🟫 📡 **6. Network and Firewall Lookups**
- Port to application mapping  
- Protocol names  
- NAT mappings  

---

# 8️⃣ Automatic Lookups

You can configure Splunk to automatically enrich events without requiring `| lookup`.

Example in `props.conf`:
```
LOOKUP-add_dept = user_lookup username OUTPUT department
```

Now every event with `username` gets `department`.

---

# 9️⃣ Lookup Matching Rules

- Exact match (`username=john`)
- Wildcard (`web*`)
- CIDR matching (for IP ranges)
- Case-sensitive or insensitive matching
- Multi-field matching (`hostname` + `site`)

---

# 🔟 Best Practices

- Keep lookup names simple (`ip_lookup`, `host_info`)  
- Avoid overwriting fields — use `OUTPUTNEW`  
- Split large lookups into multiple files  
- Normalize case using `lower(field)`  
- Document all lookups in README.md  
- Use KV store for large or dynamic datasets  
- Validate lookup with `inputlookup` before using it  

---

# ✅ Summary

Lookups allow Splunk to:
- Enrich data  
- Normalize fields  
- Add context to events  
- Make detection rules stronger  
- Improve dashboards  
- Connect logs with external sources  

Understanding lookups is essential for:
- SOC operations  
- Threat hunting  
- Correlation rules  
- Compliance dashboards  
- Splunk Enterprise Security  

