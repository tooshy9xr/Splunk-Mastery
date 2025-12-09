# 🚚 Splunk Forwarders — Full Technical Explanation  
A Complete Guide to How Splunk Collects & Sends Data Into the Indexing Pipeline

Splunk **Forwarders** are lightweight or heavy agents responsible for **collecting, packaging, and sending data** from thousands of endpoints into Splunk Indexers.  
They form the **data acquisition layer** of the entire Splunk ecosystem.

There are two major types:

- **Universal Forwarder (UF)** — lightweight, fast, most common  
- **Heavy Forwarder (HF)** — parses, filters, and routes data  

---

# 1️⃣ What Are Splunk Forwarders?

A **Forwarder** is a Splunk agent installed on servers, endpoints, or network devices.  
Its job is to:

- Monitor files, logs, metrics, and endpoints  
- Collect data in real time  
- Add metadata (`host`, `source`, `sourcetype`)  
- Send data to Indexers or Heavy Forwarders  
- Ensure reliable delivery with queues & acknowledgments  

Forwarders do **not** perform indexing.

---

# 2️⃣ Universal Forwarder (UF)

The **Universal Forwarder** is:

- Smallest Splunk agent  
- Fastest version of Splunk  
- Optimized for minimal CPU/RAM usage  
- Used on 95% of Splunk deployments  

## 🔧 UF Capabilities:
- Real-time file monitoring  
- Registry monitoring (Windows)  
- Event Log collection  
- Scripted inputs  
- Metrics collection  
- SSL forwarding  
- Load-balanced forwarding  
- Reliable event delivery  

## ❌ UF Limitations:
- No parsing  
- No indexing  
- No UI  
- No SPL execution  
- Cannot run heavy add-ons  

The UF is strictly for **transporting raw data**.

---

# 3️⃣ Heavy Forwarder (HF)

The **Heavy Forwarder** is a full Splunk Enterprise instance with indexing **disabled**.

## ⚙️ HF Capabilities:
- Parsing (line breaking, timestamping, field extraction)  
- Data filtering (`regex`, `TRANSFORMS`)  
- Routing events to specific indexers  
- Using props.conf & transforms.conf  
- Running modular inputs & add-ons  
- Converting data formats (XML, JSON)  

## 📌 Typical HF Use Cases:
- Ingesting high-volume syslog  
- Filtering unwanted data  
- Splitting traffic by index or sourcetype  
- Running API collectors or heavy apps  

## ⚠️ HF Disadvantages:
- Higher CPU & RAM usage  
- More complex administration  
- Needs full Splunk Enterprise license  

Most modern architectures are moving toward **indexer-side parsing**, reducing HF usage.

---

# 4️⃣ Forwarder Data Flow

Forwarders use **TCP**, **SSL**, and **queues** to ensure reliable delivery.

Data flow inside a Forwarder:

```
[Inputs] → [Parsing Queue (HF only)] → [Typing Queue] → [Aggregators] → [Output Queue] → Indexers
```

Universal Forwarder skips parsing queues entirely.

---

# 5️⃣ Forwarder Queues

Forwarders use multiple queues to ensure reliability:

| Queue | Purpose |
|-------|---------|
| **Input Queue** | Collects new events |
| **Parsing Queue (HF only)** | Breaks events |
| **Aggregation Queue** | Prepares event blocks |
| **Output Queue** | Sends data to indexers |
| **Ack Queue** | Stores events awaiting acknowledgment |

If an indexer becomes unreachable → queues expand → no data is lost.

---

# 6️⃣ Forwarder Types Summary

| Type | Parsing | Add-ons | Filtering | CPU Usage | Best Use |
|------|---------|---------|-----------|------------|----------|
| **Universal Forwarder** | ❌ None | Limited | No | Low | Servers, endpoints |
| **Heavy Forwarder** | ✔️ Yes | Full | Yes | High | Syslog, routing |
| **Intermediate Forwarder** | ❌ None | None | No | Medium | Traffic balancing |

---

# 7️⃣ Intermediate Forwarders (IF)

These forwarders:

- Do not parse  
- Do not index  
- Simply relay data upstream  

Used for large-scale, high-volume environments.

---

# 8️⃣ Forwarder Management (Deployment Server)

Forwarders can be centrally managed using **Deployment Server**:

- Push apps & configs to thousands of UFs  
- Auto-update inputs, routing, SSL, and metadata  
- Monitor client health & connected forwarders  

---

# 9️⃣ Monitoring Forwarder Health

Use **Monitoring Console** + **Forwarder Management** to track:

- Active vs inactive forwarders  
- Connection latency  
- Missing or delayed data  
- Queue fill levels  
- SSL handshake issues  
- Deployment server app versions  

---

# 🔟 When to Use UF vs HF

### ✔️ Use **Universal Forwarder** for:
- Linux servers  
- Windows servers  
- Applications  
- Local log file monitoring  
- Sysmon  
- General-purpose ingestion  

### ✔️ Use **Heavy Forwarder** for:
- Heavy add-ons requiring Python  
- Syslog transformations  
- Data routing at scale  
- API data collection  

### ✔️ Avoid Heavy Forwarders When:
- Indexers can perform parsing  
- Environment needs simplicity  
- You want maximum ingestion performance  

---

# 📘 Final Summary

Splunk Forwarders are the **data collection backbone** of Splunk.

**Universal Forwarders** provide lightweight, high-speed, stable data ingestion.  
**Heavy Forwarders** offer advanced parsing, routing, and filtering capabilities.

A strong Forwarder architecture ensures:

- Reliable data delivery  
- Clean metadata  
- Balanced indexer load  
- Minimal data loss  
- Accurate parsing & sourcetype management  

Forwarders → feed data into → Indexers → serve data to → Search Heads.

They are the first and most critical step of the **Splunk data pipeline**.

