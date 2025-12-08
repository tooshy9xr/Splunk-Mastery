# 🛠️ Configuration Changes — Windows & Linux

Detection queries for identifying system, security, and application configuration changes that may indicate administrative activity or malicious tampering.

---

# 🪟 Windows — Configuration Changes

## 🔹 1. Security Policy Modification  
**Description:** Detects changes to security settings (audit policy, password policy, etc.).  
**Purpose:** High-risk indicator of privilege escalation or persistence activity.

**🔍 SPL**
```
index=windows EventCode=4739 OR EventCode=4719
| stats count by Account_Name, Computer, Changed_Policy, _time
```

---

## 🔹 2. Group Policy Changes  
**Description:** Detects edits, updates, or reloads of Group Policy Objects (GPOs).  
**Purpose:** GPO tampering is commonly used for lateral movement or disabling security settings.

**🔍 SPL**
```
index=windows EventCode=5136
| stats count by Account_Name, Object_Name, Operation_Type, Computer, _time
```

---

## 🔹 3. Firewall Configuration Changes  
**Description:** Triggered when firewall rules are modified.  
**Purpose:** Attackers may disable firewall or open ports for persistence.

**🔍 SPL**
```
index=windows EventCode=2004
| stats count by Account_Name, Computer, NewSetting, _time
```

---

## 🔹 4. Service Configuration Modified  
**Description:** Detects changes in Windows service settings (startup type, executable path, etc.).  
**Purpose:** Useful for detecting malicious persistence.

**🔍 SPL**
```
index=windows EventCode=7040 OR EventCode=7045
| stats count by Service_Name, Account_Name, Start_Type, Image_Path, Computer, _time
```

---

# 🐧 Linux — Configuration Changes

## 🔹 5. Changes to Critical Config Files (/etc/)  
**Description:** Detects modifications to system configuration files.  
**Purpose:** Key indicator of privilege escalation or backdoor installation.

**🔍 SPL**
```
index=linux sourcetype=linux_audit file="/etc/*" action=modified
| stats count by user, file, process, host, _time
```

---

## 🔹 6. SSH Configuration Changes  
**Description:** Detects edits to `/etc/ssh/sshd_config` or related files.  
**Purpose:** Attackers often weaken authentication or enable root login.

**🔍 SPL**
```
index=linux sourcetype=linux_audit file="/etc/ssh/sshd_config"
| stats count by user, file, process, host, _time
```

---

## 🔹 7. Sudoers File Modification  
**Description:** Tracks changes to `/etc/sudoers` or sudoers.d files.  
**Purpose:** High-risk modification that grants elevated privileges.

**🔍 SPL**
```
index=linux sourcetype=linux_audit file="/etc/sudoers*" action=modified
| stats count by user, file, process, host, _time
```

---

## 🔹 8. Kernel Parameter Changes (sysctl)  
**Description:** Detects changes to kernel parameters via sysctl.  
**Purpose:** Can indicate security weakening or system manipulation.

**🔍 SPL**
```
index=linux COMMAND="sysctl*" 
| stats count by user, COMMAND, host, _time
```
