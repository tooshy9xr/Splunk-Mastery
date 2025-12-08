# 🗂️ Critical File Changes — Windows & Linux

A collection of Splunk searches designed to detect modification, deletion, or creation of sensitive system files.  
Useful for identifying tampering, malware activity, or unauthorized system configuration changes.

---

# 🪟 Windows — Critical File Change Detection

## 🔹 1. Changes to System32 Files  
**Description:** Detects modifications in the Windows System32 directory.  
**Purpose:** Critical files here should rarely change; modification may indicate malware.

**🔍 SPL**
```
index=windows (Object_Name="C:\\Windows\\System32\\*" AND (EventCode=4656 OR EventCode=4663))
| stats count by Object_Name, AccessMask, Process_Name, User, Computer, _time
```

---

## 🔹 2. Registry Changes to Security/Startup Keys  
**Description:** Flags modifications to sensitive registry paths.  
**Purpose:** Malware often edits these keys for persistence or privilege escalation.

**🔍 SPL**
```
index=windows EventCode=4657 
| search (Object_Name="*\\Run" OR Object_Name="*\\Policies\\System" OR Object_Name="*\\Services")
| stats count by Object_Name, NewValue, User, Computer, _time
```

---

## 🔹 3. Modification of Executable Files  
**Description:** Detects when `.exe` or `.dll` files are changed.  
**Purpose:** Useful for spotting file tampering or trojan replacement.

**🔍 SPL**
```
index=windows EventCode=4663 Object_Name="*.exe" OR Object_Name="*.dll"
| stats count by Object_Name, User, Computer, _time
```

---

## 🔹 4. Security Policy File Changes  
**Description:** Alerts on edits to audit policy configuration.  
**Purpose:** Attackers modify policy files to hide activity.

**🔍 SPL**
```
index=windows EventCode=4719
| stats count by Account_Name, Computer, CategoryId, _time
```

---

# 🐧 Linux — Critical File Change Detection

## 🔹 5. Changes to /etc/passwd or /etc/shadow  
**Description:** Detects creation, deletion, or modification of authentication files.  
**Purpose:** One of the strongest indicators of compromise.

**🔍 SPL**
```
index=linux (file="/etc/passwd" OR file="/etc/shadow")
| stats count by file, user, host, action, _time
```

---

## 🔹 6. Modification of SSH Authorized Keys  
**Description:** Detects changes to SSH public keys.  
**Purpose:** Attackers add their own keys for persistent backdoor access.

**🔍 SPL**
```
index=linux file="*/.ssh/authorized_keys"
| stats count by user, host, action, _time
```

---

## 🔹 7. Changes to Critical System Binaries  
**Description:** Monitors modifications to `/bin`, `/sbin`, `/usr/bin`.  
**Purpose:** Legitimate changes here are rare and highly suspicious.

**🔍 SPL**
```
index=linux (file="/bin/*" OR file="/sbin/*" OR file="/usr/bin/*")
| stats count by file, user, host, action, _time
```

---

## 🔹 8. SUID/SGID File Permission Changes  
**Description:** Detects when a file gains SUID or SGID permissions.  
**Purpose:** Attackers use SUID binaries for privilege escalation.

**🔍 SPL**
```
index=linux cmdline="chmod *s*"
| stats count by user, host, cmdline, _time
```

---

## 🔹 9. Web Server Directory Tampering  
**Description:** Detects changes to `/var/www` or other web directories.  
**Purpose:** Useful for spotting web shells or website defacement.

**🔍 SPL**
```
index=linux file="/var/www/*"
| stats count by file, user, host, action, _time
```
