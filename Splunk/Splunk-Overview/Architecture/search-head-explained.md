# 🧠 Splunk Search Heads — Full Technical Explanation  
A Complete Guide to How Search Heads Execute, Distribute, and Manage Searches in Splunk

The **Search Head (SH)** is the *brain* of the Splunk ecosystem.  
It is responsible for search execution, dashboards, alerts, knowledge objects, and user interaction.  
While Indexers handle data storage and parsing, **Search Heads run all SPL logic** and coordinate distributed searches across indexer tiers.

---

# 1️⃣ What Is a Splunk Search Head?

A **Search Head** is a Splunk server that:

- Executes SPL searches  
- Distributes search jobs to indexers  
- Merges results from multiple indexers  
- Hosts dashboards, alerts, and reports  
- Manages knowledge objects (fields, lookups, eventtypes, tags, etc.)  
- Handles authentication, RBAC, and user access  
- Provides the Splunk Web UI  

It does **not** store data or perform indexing (unless configured as a standalone instance).

---

# 2️⃣ Main Responsibilities of a Search Head

## 📌 Central roles:
- Handling **user search requests**  
- Coordinating with indexers to pull event data  
- Running SPL functions:  
  - `eval`, `stats`, `rex`, `lookup`, `table`, etc.  
- Rendering dashboards & visualizations  
- Managing apps, add-ons, and knowledge packs  
- Running scheduled searches, alerts, and reports  
- Managing saved searches and data models  

---

# 3️⃣ How A Search Head Executes a Search

A search goes through **multiple stages** inside the Search Head.

## 🛠️ A. Search Parsing (SPL Interpreter)
The SH interprets the user’s SPL and determines:

- Which indexers contain the data  
- Which commands run at indexer-level  
- Which commands run locally on SH  
- Whether acceleration or summaries exist  
- How to split and distribute tasks  

---

## 📡 B. Dispatch & Distribution
The SH sends search requests to:

- All indexers (distributed search)  
- Specific indexers (timeline optimized)  
- Summary indexes  
- Data model accelerations  
- Saved search artifacts  

The SH also opens **search pipelines** on each peer.

---

## 🔄 C. Results Merging
Once indexers return partial results:

- SH merges them  
- Applies remaining SPL functions  
- Removes duplicates  
- Builds final event set  
- Produces statistics & visualizations  

This is called **search reduction and merging**.

---

# 4️⃣ Search Head Architecture Components

### 🧠 1. Search Head Web UI  
User interface where dashboards, alerts, and searches are managed.

### 📂 2. Knowledge Manager  
Controls all knowledge objects:

- Field extractions  
- CIM mappings  
- Lookups  
- Eventtypes & tags  
- Eval-based fields  
- Dashboard panels  

### ⏱️ 3. Scheduler  
Responsible for:

- Running scheduled searches  
- Managing alerts  
- Handling throttling  
- Prioritizing job queues  

### 📡 4. Distributed Search Controller  
Dispatches tasks to indexers, merges results, and manages search pipelines.

### 🔐 5. Authentication & RBAC  
Provides user login, roles, capabilities, and access control.

---

# 5️⃣ Search Head Clustering (SHC)

A **Search Head Cluster** provides:

- High availability  
- Knowledge object replication  
- Workload balancing  
- Search consistency across multiple SH nodes  

### SHC Roles:
| Component | Purpose |
|----------|---------|
| **Cluster Captain** | Coordinates searches & scheduling |
| **Cluster Members** | Search Heads sharing configurations |
| **Deployer** | Pushes apps/configs to all SHC members |

### Key Features:
- Replicated KV store  
- Replicated search configurations  
- Automatic captain elections  
- Failover & recovery  

---

# 6️⃣ Search Head Workload Roles

Search Heads can be assigned to specialized roles:

### 🎨 1. GUI / User Search Head
Hosts dashboards and user searches.

### ⚙️ 2. SH for Scheduled Searches
Dedicated for cron-based workloads.

### 📊 3. Data Model Acceleration (DDAA) SH
Used for data model & summary acceleration.

### 🔍 4. Investigation SH
Used only for live analyst queries.

This helps balance workloads in large environments.

---

# 7️⃣ Search-Time Processing (What Happens on Search Head)

Search Heads perform **all search-time field extractions**, such as:

- `rex`  
- `eval`  
- Lookups  
- JSON/XML parsing  
- CIM normalization  
- Field aliases  
- Eventtypes & tags  
- Calculated fields  

This is why SH performance is critical.

---

# 8️⃣ Search Head Performance Metrics

Key metrics to monitor:

- CPU usage (heavy SPL → heavy CPU)  
- Memory usage  
- Scheduler delays  
- SH-to-indexer RTT (latency)  
- KV store health  
- Bundle replication delays  
- Disk space under `/opt/splunk/var`  

---

# 9️⃣ When to Scale Search Heads

Scale your SH tier when:

- Dashboard rendering slows down  
- High number of concurrent users  
- Thousands of scheduled searches  
- Heavy use of data model acceleration  
- SHC bundle replication is slow  
- Search latency is high even with healthy indexers  

---

# 🔟 Best Practices for Deploying Search Heads

- Use SHC for production environments  
- Keep Search Heads **separate** from Indexers  
- Always deploy a **Deployer** for SHC  
- Monitor KV store (critical component)  
- Use load balancers for SHC access  
- Store apps in `/etc/shcluster/apps`  
- Maintain clear app boundaries  
- Protect SH from unnecessary addons  

---

# 📘 Final Summary

The Splunk Search Head is the central intelligence layer of Splunk.  
It handles:

1. **Search processing**  
2. **Dashboard rendering**  
3. **Knowledge object management**  
4. **Scheduling**  
5. **Authentication & RBAC**  
6. **Distributed search coordination**  

Without a properly tuned Search Head tier, even the strongest indexer cluster will feel slow.

A strong SH architecture ensures:

- Fast SPL execution  
- Stable dashboards  
- Reliable alerts  
- Consistent results across all users  

