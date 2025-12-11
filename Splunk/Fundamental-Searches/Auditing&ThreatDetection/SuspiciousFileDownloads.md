# 📥 Suspicious File Downloads — Windows & Linux

Detection queries for identifying risky, unusual, or unauthorized file downloads across Windows and Linux systems.

---

# 🪟 Windows — Suspicious File Downloads

## 🔹 1. Downloads from PowerShell (Invoke-WebRequest / wget / curl)
**Description:** Detects file downloads executed via PowerShell cmdlets.  
**Purpose:** Often used in malware delivery and lateral movement.

**🔍 SPL**
```
index=windows EventCode=4104 ("Invoke-WebRequest" OR "wget" OR "curl")
| stats count by Account_Name, Computer, ScriptBlockText, _time
```

---

## 🔹 2. Suspicious File Downloads via Browser
**Description:** Captures downloads from popular browsers.  
**Purpose:** Useful for detecting user-initiated risky downloads.

**🔍 SPL**
```
index=windows (Process_Name="chrome.exe" OR Process_Name="msedge.exe" OR Process_Name="firefox.exe")
"|download" OR ".exe" OR ".ps1" OR ".bat"
| stats count by Account_Name, Process_Name, File_Name, CommandLine, _time
```

---

## 🔹 3. Download of Executable or Script File
**Description:** Identifies when EXE, PS1, BAT, or VBS files are saved to disk.  
**Purpose:** Detects malware payload drops.

**🔍 SPL**
```
index=windows EventCode=4663 (Object_Name="*.exe" OR Object_Name="*.ps1" OR Object_Name="*.bat" OR Object_Name="*.vbs")
| stats count by Account_Name, Object_Name, Process_Name, Accesses, _time
```

---

## 🔹 4. BITSAdmin File Download
**Description:** Detects usage of BITSadmin for background downloads.  
**Purpose:** Attackers use BITSAdmin to download tools silently.

**🔍 SPL**
```
index=windows (Process_Name="bitsadmin.exe")
| stats count by Account_Name, CommandLine, Computer, _time
```

---

# 🐧 Linux — Suspicious File Downloads

## 🔹 5. curl / wget Download Attempts  
**Description:** Detects file downloads using common command-line tools.  
**Purpose:** Useful for spotting malware download scripts.

**🔍 SPL**
```
index=linux (COMMAND="wget*" OR COMMAND="curl*")
| stats count by user, src_ip, host, COMMAND, _time
```

---

## 🔹 6. Download of Suspicious Binary Files  
**Description:** Monitors creation of EXE, ELF, SH, and similar files.  
**Purpose:** Helps identify malicious payload creation.

**🔍 SPL**
```
index=linux sourcetype=linux_audit (file IN ("*.sh","*.elf","*.exe","*.bin"))
| stats count by file, user, process, host, _time
```

---

## 🔹 7. Browser-Based File Downloads  
**Description:** Tracks downloads made by Linux GUI browsers.  
**Purpose:** Detects user-initiated risky files.

**🔍 SPL**
```
index=linux (process="firefox" OR process="chrome" OR process="chromium")
"download" OR ".exe" OR ".sh" OR ".bin"
| stats count by user, process, file, host, _time
```

---

## 🔹 8. Scripted Downloads Inside Cron Jobs  
**Description:** Detects downloads executed automatically via cron.  
**Purpose:** Attackers hide malicious download jobs in cron.

**🔍 SPL**
```
index=linux sourcetype=cron ("wget" OR "curl")
| stats count by user, COMMAND, host, _time
```
