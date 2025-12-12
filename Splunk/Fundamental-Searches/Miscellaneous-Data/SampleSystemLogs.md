# 🖥️ Sample System Logs  
This file provides **Windows + Linux sample system logs** used for testing Splunk searches related to:  
- System performance  
- Services  
- Processes  
- Hardware issues  
- Boot/shutdown  
- Software installation  
- OS errors  
- Configuration changes  

These samples are realistic and suitable for dashboards, alerts, or SOC lab environments.

---

# 🟦 Windows Sample System Logs

Below are **Event ID–based samples** covering system operations.

---

## 🔄 System Boot (EventCode 6005)
```
02/12/2025 08:00:41
EventCode=6005
Source=EventLog
Message=The Event log service was started.
Host=WIN-SRV01
```

## 🔌 System Shutdown (EventCode 6006)
```
02/12/2025 17:55:03
EventCode=6006
Source=EventLog
Message=The Event log service was stopped.
Host=WIN-SRV01
```

## ⚙️ Service Start (EventCode 7036)
```
02/12/2025 13:22:18
EventCode=7036
ServiceName=Windows Update
State=Running
Host=WS-021
```

## ⚠️ Service Crash (EventCode 7031)
```
02/12/2025 13:23:14
EventCode=7031
ServiceName=Print Spooler
Termination=Unexpected
RestartAttempt=True
Host=WS-021
```

## 🧰 New Software Installation (EventCode 11707)
```
02/12/2025 11:14:09
EventCode=11707
ProductName=Google Chrome
Status=Success
User=CORP\jane.smith
Host=WS-014
```

## 🔄 Process Creation (EventCode 4688)
```
02/12/2025 14:03:51
EventCode=4688
NewProcessName=C:\Windows\System32\cmd.exe
ParentProcessName=explorer.exe
User=CORP\john.doe
Host=WS-001
```

## 💾 Disk Error (EventCode 7)
```
02/12/2025 12:41:12
EventCode=7
Source=disk
Message=The device \Device\Harddisk0 has a bad block.
Host=SRV-FILES01
```

## 🧩 Driver Error (EventCode 1001)
```
02/12/2025 10:15:27
EventCode=1001
Source=BugCheck
Message=The computer has rebooted from a bugcheck.
Host=SRV-API02
```

---

# 🟩 Linux Sample System Logs

Collected from `/var/log/syslog`, `/var/log/auth.log`, `/var/log/kern.log`.

---

## 🔄 System Boot
```
Feb 12 08:02:14 ubuntu systemd[1]: Started Daily apt download activities.
```

## 🔌 System Shutdown  
```
Feb 12 17:56:30 ubuntu systemd[1]: Stopped User Manager for UID 1000.
```

## ⚙️ Service Start  
```
Feb 12 13:22:45 ubuntu systemd[1]: Started Docker Application Container Engine.
```

## ⚠️ Service Failure  
```
Feb 12 13:27:12 ubuntu systemd[1]: nginx.service: Failed with result 'exit-code'.
```

## 🧰 Package Installation  
```
Feb 12 11:14:22 ubuntu apt[2745]: Installed: openssh-server (1:9.6p1-3ubuntu1)
```

## 💻 Process Execution  
```
Feb 12 14:05:33 ubuntu systemd[2121]: Started Process: /usr/bin/python3 script.py
```

## 🧬 Kernel Error  
```
Feb 12 12:48:41 ubuntu kernel: [ 1144.223112 ] ata1.00: status: { DRDY ERR }
```

## 📦 Disk Full Warning  
```
Feb 12 16:21:07 ubuntu kernel: EXT4-fs warning (device sda2): ext4_da_writepages: Disk full
```

## 🔐 System Configuration Change  
```
Feb 12 14:33:55 ubuntu systemd[1]: Reloaded OpenSSH Daemon.
```

---

# 🧪 Additional SOC Testing Scenarios

## 🔥 High CPU
```
Feb 12 14:51:30 ubuntu systemd[1]: CPU usage for process java exceeded 95%
```

## 📉 Low Memory
```
02/12/2025 14:53:11
Host=SRV-WEB01
Source=MemoryDiagnostics
Message=Available memory below 10%
```

## 🌐 Network Service Restart
```
Feb 12 15:00:21 ubuntu systemd-networkd[632]: Restarting network interface eth0
```

## ⚠️ System Time Change (Suspicious)
```
02/12/2025 12:25:04
EventCode=4616
Message=System time was changed.
User=SYSTEM
OldTime=12:24:01
NewTime=11:24:01
```

---

# 📌 Summary  
This file includes sample logs for:

- Boot / shutdown  
- Services  
- Processes  
- Software changes  
- Disk/hardware errors  
- Kernel warnings  
- System anomalies  

Use this for search testing, dashboards, simulations, and SOC training.

