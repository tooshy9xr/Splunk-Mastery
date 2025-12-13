# 🖥️ Resource Monitoring (Windows & Linux)
Fundamental Searches for System Resources

This file focuses on **monitoring system resources** across **Windows and Linux systems**, using **basic searches** suitable for the *Fundamental Searches* level.  
Resource monitoring ensures **system stability, performance optimization, and early detection of anomalies**.

---

## 🎯 Purpose
- Track **CPU, memory, disk, and network usage**
- Monitor **processes and service resource consumption**
- Detect **resource exhaustion and bottlenecks**
- Support SOC and IT operations monitoring
- Enable proactive alerting

---

## 🖥️ Platforms Covered
- 🪟 Windows Servers & Workstations
- 🐧 Linux Servers & Endpoints
- ☁️ Cloud VMs

---

## 📂 Common Log Sources

### 🪟 Windows
- Performance Counters (PerfMon)
- Event Viewer (System & Application)
- WMI logs
- Resource Monitor snapshots

### 🐧 Linux
- `/proc/stat`, `/proc/meminfo`, `/proc/diskstats`
- `top`, `vmstat`, `iostat`, `sar`
- Node exporter / agent logs
- `/var/log/syslog` for resource-related events

---

## 🧾 Sample Logs

### 🪟 Windows – CPU & Memory
```
2025-02-12 15:01:22 WIN-SRV01 CPU=78% Memory=65% DiskC=70%
```

### 🪟 Windows – Process Resource Usage
```
2025-02-12 15:05:44 WIN-SRV01 Process=sqlservr.exe CPU=90% Memory=80%
```

### 🐧 Linux – CPU & Memory
```
Feb 12 15:10:33 server01 top: PID=1234 USER=root CPU=85% MEM=70% COMMAND=apache2
```

### 🐧 Linux – Disk & I/O
```
Feb 12 15:12:11 server01 iostat: Device=sda Read=120MB/s Write=100MB/s
```

### 🐧 Linux – Network Usage
```
Feb 12 15:15:22 server01 ifstat: eth0 TX=15MB RX=20MB
```

---

## 🔍 Fundamental Search Examples

### 💻 High CPU Usage
```spl
index=windows_logs OR index=linux_logs
| where CPU>80
| table _time host Process CPU
```

### 🧠 High Memory Usage
```spl
index=windows_logs OR index=linux_logs
| where Memory>75
| table _time host Process Memory
```

### 💽 Disk & I/O Monitoring
```spl
index=windows_logs OR index=linux_logs
| table _time host Disk Read Write
| where Read>100MB OR Write>100MB
```

### 🌐 Network Traffic Monitoring
```spl
index=windows_logs OR index=linux_logs
| table _time host Interface TX RX
| where TX>50MB OR RX>50MB
```

---

## 🚨 Detection Scenarios

### 🔁 Resource Spikes
- Sudden CPU, memory, or disk usage
```spl
| stats max(CPU) as MaxCPU max(Memory) as MaxMem by host
| where MaxCPU>90 OR MaxMem>85
```

### 🧨 Process Resource Overuse
```spl
| stats sum(CPU) as CPUtotal by Process host
| where CPUtotal>80
```

### ⚡ Network Saturation
```spl
| stats max(TX) as MaxTX max(RX) as MaxRX by host
| where MaxTX>100MB OR MaxRX>100MB
```

---

## 🛡️ Mitigation & Response
- Optimize or restart resource-heavy processes
- Expand system resources (CPU, memory, disk)
- Review network traffic for anomalies
- Set alerts for threshold breaches
- Perform capacity planning

---

## 📌 Summary
This file provides **fundamental resource monitoring** for:
- CPU, memory, disk, and network
- Process and service resource consumption
- Windows and Linux systems

