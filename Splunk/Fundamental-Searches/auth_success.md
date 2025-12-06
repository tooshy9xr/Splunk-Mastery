# 🌟 Easy Authentication Searches — Splunk

A clean, structured, and beginner-friendly list of simple Splunk searches for successful authentication events.  
Each search includes a short explanation, purpose, and the SPL query.

---

## 🔹 1. Basic Successful Logins  
**Description:** Displays all successful login events with timestamp, username, and source IP.  
**Purpose:** Provides a quick view of who logged in, when, and from where.

🔍 [spl](Basic-Successful-Logins.spl)

---
## 🔹 2. Count Successful Logins by User

Description: Counts how many successful logins each user has.
Purpose: Helps identify the most active accounts or unusual login spikes.

🔍 SPL Query

index=auth action=success
| stats count by user

🔹 3. Count Successful Logins by Source IP

Description: Shows how many logins came from each IP address.
Purpose: Useful for spotting repeated logins from a single IP or unfamiliar sources.

🔍 SPL Query

index=auth action=success
| stats count by src

🔹 4. Last Successful Login Per User

Description: Returns the latest (most recent) successful login time for each user.
Purpose: Good for tracking user activity and verifying expected login behavior.

🔍 SPL Query

index=auth action=success
| stats latest(_time) as last_login by user

🔹 5. Successful Logins per Hour

Description: Simple time-based chart showing hourly successful logins.
Purpose: Helps visualize login activity peaks or unusual patterns.

🔍 SPL Query
