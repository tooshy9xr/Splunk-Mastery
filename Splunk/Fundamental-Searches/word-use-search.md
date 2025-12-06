# 🌟 Splunk Search Keywords Reference

---

## 🔍 Core Search Commands

* **search** — The primary command to search events in Splunk 🔎
* **index=** — Specifies which index to search 📁
* **host=** — Filters events by the machine generating them 🖥️
* **source=** — Filters events by the log file or data source 📄
* **sourcetype=** — Indicates the format/type of the incoming data (e.g., syslog, JSON) 🧩
* **eventtype=** — Named event patterns for easier reuse 🔖
* **tag=** — Labels events with categories for better grouping 🏷️
* **type=** — Classifies event type or purpose 📌

---

## ⏱️ Time Controls

* **earliest=** — Start time for the search ⏳
* **latest=** — End time for the search 🕒
* **date_mday** — Day of the month 📆
* **date_wday** — Day of the week 📅
* **date_hour** — Hour of the day 🕐

---

## 📊 Statistical Commands

* **stats** — Calculates numeric stats from events 📊
* **eventstats** — Adds stats to each event without changing the number of events 🪄
* **streamstats** — Creates running totals and rolling stats 🌊
* **chart** — Generates charts by specific fields 📈
* **timechart** — Time-based charting for trends ⏱️📉
* **top** — Shows most frequent values 🥇
* **rare** — Shows least frequent values 🥈
* **count** — Counts number of events 🔢
* **sum()** — Adds numeric field values ➕
* **avg()** — Computes average ➗
* **min() / max()** — Finds the minimum or maximum values 📉📈
* **dc()** — Counts distinct values 🔐

---

## 🧮 Eval & Field Functions

* **eval** — Creates or modifies fields using expressions 🧠
* **if()** — Conditional logic for field values ⚖️
* **case()** — Multiple conditional checks 🧩
* **coalesce()** — Replaces null values with first non-null 🔧
* **len()** — Returns the length of a string 📏
* **lower()/upper()** — Converts text to lowercase/uppercase 🔠🔡
* **replace()** — Replace text using regex or strings 🔄
* **split()** — Splits a string into a list ✂️
* **substr()** — Extracts a substring from a string 🔍
* **round()** — Rounds numeric values 🔵
* **isnull()** — Checks if a value is null ❔

---

## 🔁 Event & Field Manipulation

* **fields** — Includes or removes specific fields from results 📋
* **table** — Displays results as a table 🧱
* **dedup** — Removes duplicate events 🚮
* **sort** — Sorts results by a field 📚
* **reverse** — Reverses the order of results ↩️
* **rename** — Renames fields for readability ✏️
* **fillnull** — Fills null values with a default value 🧴
* **transaction** — Groups related events into a single transaction 🔗
* **append / appendcols** — Combines results from multiple searches ➕

---

## 🧵 Extraction & Regex

* **rex** — Extract fields using regular expressions 🧵
* **regex** — Filters results based on regex patterns 🔍
* **spath** — Extracts fields from JSON or XML data 🧩
* **extract** — Automatic field extraction 🤖
* **kv** — Extracts key-value pairs from events 🔑

---

## 🔗 Lookups & Joins

* **lookup** — Enriches events with external data from a table 🗂️
* **inputlookup** — Reads data from a lookup table 📘
* **outputlookup** — Writes results to a lookup table 📤
* **join** — Combines events from two datasets 🔗
* **map** — Runs subsearch for each result 🧭
* **subsearch** — A nested search used within another search 🔁

---

## 🛠️ Advanced & Internal

* **tstats** — Fast, accelerated searches ⚡
* **mstats** — Searches metrics indexes 📡
* **metadata** — Retrieves internal index metadata 🛠️
* **mcatalog** — Shows field/value summary of indexed data 📚
* **accelerate** — Improves performance of saved searches 🚀

---

## 📡 Network Analysis

* **src_ip / dest_ip** — Source and destination IPs 🌐🎯
* **src_port / dest_port** — Source and destination ports 🔌
* **protocol** — TCP/UDP/ICMP ⚙️
* **bytes_in / bytes_out** — Network traffic volume 📦
* **dns** — DNS lookup events 🌍
* **http_method** — HTTP method like GET/POST 🌐
* **uri_path** — URL path requested 📄
* **user_agent** — Browser or OS identity 🧭
* **http_status** — HTTP status code 🚦
* **tcp_flags** — TCP packet flags 🏴

---

## 🕵️ Threat Hunting & Security

* **failed login / successful login** — Authentication results ❌✔️
* **sudo / privilege escalation** — Checks for admin actions 🐧
* **powershell / wmic** — Windows command execution ⚡🧰
* **process start / parent_process** — Monitor process creation 🌳
* **commandline** — Captures executed commands 🖥️
* **file create / delete** — File operations 📁
* **hash** — File hash identification 🧬
* **network beaconing** — Command & Control (C2) activity 🛰️
* **malware / ransomware / phishing** — Malicious activity indicators 🦠🔒🎣

---

## 🔥 Incident Response

* **alert** — Triggered detection 🚨
* **severity** — Threat criticality level 🔥
* **signature_id** — Intrusion detection signature ID 🆔
* **IOC** — Indicators of Compromise ⚠️
* **MITRE ATT&CK** — Framework for Tactics, Techniques, and Procedures 🧩
* **endpoint** — Monitored device 🖥️
* **baseline deviation** — Detect abnormal activity 📉
* **lateral movement** — Attacker moving across systems 🧱➡️🧱
---
