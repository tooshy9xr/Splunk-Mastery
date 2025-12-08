# 🔌 USB Device Usage — Windows & Linux

Detection queries for identifying USB storage activity, device insert/remove actions, and potential data exfiltration indicators.

---

# 🪟 Windows — USB Device Usage

## 🔹 1. USB Device Inserted  
**Description:** Detects when a USB device is plugged into the system.  
**Purpose:** Useful for monitoring unauthorized removable media.

**🔍 SPL**
```
index=windows EventCode=20001 OR EventCode=2100 OR EventCode=2102
| stats count by Computer, Vendor_Name, Product_Name, Serial_Number, _time
```

---

## 🔹 2. USB Device Removed  
**Description:** Triggered when a USB device is removed.  
**Purpose:** Tracks the full lifecycle of USB insert/remove events.

**🔍 SPL**
```
index=windows EventCode=2101 OR EventCode=2103
| stats count by Computer, Vendor_Name, Product_Name, Serial_Number, _time
```

---

## 🔹 3. Files Copied to USB  
**Description:** Detects file writes to USB storage.  
**Purpose:** Helps identify possible data exfiltration.

**🔍 SPL**
```
index=windows EventCode=4663 Object_Name="*USB*" Accesses="WriteData"
| stats count by Account_Name, Object_Name, Process_Name, Computer, _time
```

---

## 🔹 4. USB Device ID & Serial Enumeration  
**Description:** Lists all USB devices currently used.  
**Purpose:** Builds an inventory of removable devices.

**🔍 SPL**
```
index=windows EventCode=20003
| stats values(Serial_Number) by Computer, Vendor_Name, Product_Name
```

---

# 🐧 Linux — USB Device Usage

## 🔹 5. USB Insert Events  
**Description:** Detects when a USB device is connected.  
**Purpose:** Tracks unauthorized device usage.

**🔍 SPL**
```
index=linux (MESSAGE="usb" AND MESSAGE="New USB device found")
| stats count by host, vendor_id, product_id, bus, device, _time
```

---

## 🔹 6. USB Remove Events  
**Description:** Triggered when a USB device is disconnected.  
**Purpose:** Helps identify unexpected device removal.

**🔍 SPL**
```
index=linux MESSAGE="USB disconnect"
| stats count by host, bus, device, _time
```

---

## 🔹 7. Files Written to USB (Mounted Media)  
**Description:** Detects file creation inside `/media/` or `/mnt/`.  
**Purpose:** Useful for identifying data exfiltration.

**🔍 SPL**
```
index=linux sourcetype=linux_audit file="/media/*" OR file="/mnt/*"
| stats count by user, file, process, host, _time
```

---

## 🔹 8. USB Device Enumeration  
**Description:** Lists all USB devices detected by the OS.  
**Purpose:** Creates a forensic inventory.

**🔍 SPL**
```
index=linux sourcetype=linux_messages "usb" "device"
| stats values(message) by host, _time
```
