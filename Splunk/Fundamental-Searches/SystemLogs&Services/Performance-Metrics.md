# 📊 Performance Metrics (Windows & Linux)
Fundamental Searches for System and Application Performance

This file focuses on **monitoring performance metrics** across **Windows and Linux systems**, using **basic searches** suitable for the *Fundamental Searches* level.  
Performance metrics are critical for **detecting resource bottlenecks, system degradation, and potential security issues**.

---

## 🎯 Purpose
- Monitor **CPU, memory, disk, and network usage**
- Detect **resource spikes and anomalies**
- Track **application and service performance**
- Support SOC and IT operations investigations
- Serve as a baseline for advanced performance analysis

---

## 🖥️ Platforms Covered
- 🪟 Windows Servers & Workstations
- 🐧 Linux Servers & Endpoints
- ☁️ Cloud VMs and Containers

---

## 📂 Common Log Sources

### 🪟 Windows
- Performance Counters (PerfMon)
- Windows Event Logs
- WMI logs
- Task Manager / Resource Monitor exports

### 🐧 Linux
- `/proc` metrics (`/proc/stat`, `/proc/meminfo`, `/proc/diskstats`)
- `top`, `vmstat`, `iostat`, `sar`
- Node exporter / agent logs
- `/var/log/syslog` for performance-related messages

---

## 🧾 Sample Logs

### 🪟 Windows – CPU Usage
```
2025-02-12 14:01:22 WIN-SRV01 CPU=85% Memory=68% DiskC=72%
```

### 🪟 Windows – Memory Spike
```
2025-02-12 14:05:44 WIN-SRV01 Process=sqlservr.exe CPU=95% Memory=78%
```

### 🐧 Linux – CPU & Memory
```
Feb 12 14:10:33 server01 top: PID=1234 USER=root CPU=92% MEM=70% COMMAND=apache2
```

### 🐧 Linux – Disk I/O
```
Feb 12 14:12:11 server01 iostat: Device=sda Read=150MB/s Write=120MB/s
```

### 🐧 Linux – Network
```
Feb 12 14:15:22 server01 ifstat: eth0 TX=20MB RX=25MB
```

---

## 🔍 Fundamental Search Examples

### 💻 CPU Usage > 80%
```spl
index=windows_logs OR index=linux_logs
| where CPU>80
| table _time host CPU Process
```

### 🧠 High Memory Consumption
```spl
index=windows_logs OR index=linux_logs
| where Memory>75
| table _time host Memory Process
```

### 💽 Disk Usage / I/O
```spl
index=windows_logs OR index=linux_logs
| table _time host Disk Read Write
| where Read>100MB OR Write>100MB
```

### 🌐 Network Usage
```spl
index=windows_logs OR index=linux_logs
| table _time host Interface TX RX
| where TX>50MB OR RX>50MB
```

---

## 🚨 Detection Scenarios

### 🔁 Resource Spikes
- CPU, memory, disk, or network usage exceeding thresholds
```spl
| stats max(CPU) as MaxCPU max(Memory) as MaxMem by host
| where MaxCPU>90 OR MaxMem>85
```

### 🧨 Unusual Process Resource Consumption
```spl
| stats sum(CPU) as CPUsum by Process host
| where CPUsum > 80
```

### ⚡ Performance Degradation
```spl
| timechart avg(CPU) as AvgCPU avg(Memory) as AvgMem by host
```

---

## 🛡️ Mitigation & Response
- Investigate resource-heavy processes
- Optimize application performance
- Expand CPU, memory, or disk resources
- Review network traffic anomalies
- Set alerts for threshold breaches

---

## 📌 Summary
This file provides **fundamental performance metric monitoring** for:
- CPU, memory, disk, and network usage
- Application and service performance
- Windows and Linux operating systems

