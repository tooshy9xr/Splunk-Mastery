# 📊 Dashboards Basics — Splunk Overview  
Foundations, Panels, Data Sources, Tokens, and Best Practices

Dashboards in Splunk present data visually using panels, searches, and UI components.  
They allow SOC teams, IT admins, and engineers to monitor systems, analyze trends, and build real-time security views.

---

# 1️⃣ What Are Splunk Dashboards?

A **dashboard** is a collection of visual panels used to display results from saved searches, inline SPL, or data models.

Dashboards help with:
- Monitoring system health, performance, and security  
- Visualizing logs, metrics, and KPIs  
- Creating SOC views (authentication, endpoint, cloud)  
- Building executive and operational reports  
- Creating drilldowns for deep investigation  

Dashboards are defined in:
```
$SPLUNK_HOME/etc/apps/<app_name>/local/data/ui/views/*.xml
```
or created using the GUI.

---

# 2️⃣ Dashboard Structure

A typical Splunk dashboard consists of:

## 🔹 **1. Panels**
Each panel represents one visualization or statistics table.

Types:
- Charts (bar, line, area, scatter)  
- Single value panels  
- Tables  
- Maps  
- Custom visualizations  

---

## 🔹 **2. Searches**
Each panel runs either:
- **Inline searches**  
- **Saved searches**  
- **Data model acceleration (tstats)**  

Example inline search:
```spl
index=auth sourcetype=linux_secure action=failure
| stats count by user
```

---

## 🔹 **3. Visualizations**
Popular chart types:
- Column / Bar  
- Line / Area  
- Pie  
- Single value + trend  
- Timecharts  

Example visualization definition (XML):
```xml
<chart>
  <search>...</search>
  <option name="charting.chart">bar</option>
</chart>
```

---

## 🔹 **4. Tokens**
Tokens allow dynamic dashboards with user input.

Token sources:
- Dropdowns  
- Time pickers  
- Text inputs  
- Drilldowns  

Example token usage:
```xml
<search>
  <query>index=auth user=$selected_user$</query>
</search>
```

---

## 🔹 **5. Inputs**
User-controlled inputs:

- Dropdown
- Multiselect
- Checkbox  
- Radio buttons  
- Time range picker  
- Text field  

Example dropdown input:
```xml
<input type="dropdown" token="country">
  <label>Select Country</label>
  <choice value="US">USA</choice>
  <choice value="UK">United Kingdom</choice>
</input>
```

---

# 3️⃣ Dashboard Types

## ⭐ Classic XML Dashboards
- Defined using Simple XML  
- Easy to create  
- Most common option

## ⭐ Dashboard Studio
- Modern UI  
- Better design and graphics  
- JSON-based  
- Great for SOC wallboards and NOC monitors

## ⭐ Custom HTML Dashboards
- Allows JavaScript, CSS  
- Highly flexible  
- Used for advanced interactions

---

# 4️⃣ Panels Explained

## Example Panel (Simple XML)
```xml
<panel>
  <title>Failed Login Attempts</title>
  <chart>
    <search>
      <query>index=auth action=failure | timechart count by user</query>
    </search>
    <option name="charting.chart">column</option>
  </chart>
</panel>
```

**Components:**
- title  
- search  
- visualization type  
- chart options  

---

# 5️⃣ Drilldowns

Drilldowns allow clicking a datapoint to open:
- another dashboard  
- another panel  
- search window  

Example:
```xml
<option name="charting.click.value">$row.user$</option>
```

Or open Search:
```xml
<drilldown>
  <link>
    /app/search/search?q=index=auth user=$click.value$
  </link>
</drilldown>
```

---

# 6️⃣ Using Data Models in Dashboards

Dashboards often rely on accelerated data models with `tstats`.

Example:
```spl
| tstats count from datamodel=Authentication.Authentication 
  where Authentication.action=failure 
  by Authentication.user, _time span=1h
```

This is much faster than raw searches.

---

# 7️⃣ Dashboard Studio Basics

Dashboard Studio supports:
- Custom colors  
- Shapes/Images  
- Grid layouts  
- Adaptive canvas  
- Dynamic tokens  

Example JSON snippet:
```json
{
  "visualizations": {
    "login_failures": {
      "type": "splunk.area",
      "dataSources": ["ds1"]
    }
  }
}
```

---

# 8️⃣ Best Practices

### ✔ Use **saved searches** for heavy queries  
### ✔ Use **tstats** for CIM/Data Model dashboards  
### ✔ Enable data model acceleration  
### ✔ Avoid long-running, expensive searches  
### ✔ Use tokens to reduce repeated searches  
### ✔ Use scheduled saved searches for real-time KPIs  
### ✔ Always provide time range filtering  
### ✔ Document each panel clearly  

---

# 9️⃣ SOC Dashboard Examples

## Authentication Dashboard
- Failed vs successful logins  
- Top users  
- Suspicious login patterns  
- Geo-based authentication  

## Network Dashboard
- Allowed vs blocked traffic  
- DNS queries  
- Threat prevention logs  

## Endpoint Dashboard
- Process execution  
- Malware alerts  
- File and registry changes  

## Cloud Dashboard
- IAM activity  
- Config changes  
- API calls per region  

---

# 🔟 Summary

Splunk dashboards provide:
- Visual representation of search results  
- Token-based interactivity  
- Customizable UI and panels  
- Fast analytics via data models and tstats  
- Critical insights for SOC, NOC, and IT operations  


