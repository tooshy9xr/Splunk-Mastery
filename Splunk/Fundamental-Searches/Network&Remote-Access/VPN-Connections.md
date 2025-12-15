# 🔐 VPN Connections Monitoring
Fundamental Searches for VPN Authentication & Session Activity

This file focuses on **monitoring VPN connections** across **Windows, Linux, and network VPN devices**, using **basic searches** suitable for the *Fundamental Searches* level.  
VPN monitoring is critical for detecting **unauthorized remote access, compromised credentials, and suspicious login behavior**.

---

## 🎯 Purpose
- Track **VPN logins and logouts**
- Detect **failed VPN authentication attempts**
- Monitor **remote user activity**
- Identify **suspicious locations and IP addresses**
- Support SOC investigations and incident response

---

## 🖥️ Platforms & Devices Covered
- 🌐 VPN Gateways (Cisco, FortiGate, Palo Alto, OpenVPN)
- 🪟 Windows VPN Clients
- 🐧 Linux VPN Clients
- ☁️ Cloud VPN Services

---

## 📂 Common VPN Event Types

### 🔑 Authentication Events
- Successful VPN login
- Failed VPN login
- MFA challenges and failures

### 🔄 Session Events
- VPN session start
- VPN session termination
- Session timeout

### 🌍 Network Details
- Source IP address
- Assigned internal IP
- User location / country

---

## 📂 Common Log Sources

### 🌐 VPN Devices
- VPN appliance logs
- Firewall VPN logs
- RADIUS / TACACS+ logs

### 🪟 Windows
- Security Event Log
- VPN client logs
- RAS logs

### 🐧 Linux
- OpenVPN logs
- `/var/log/syslog`
- Authentication logs

---

## 🧾 Sample Logs

### 🌐 VPN – Successful Connection
```
2025-02-19 18:01:22 VPN-GW User=john.doe SrcIP=8.8.8.8 AssignedIP=10.10.10.55 Status=Connected
```

### 🌐 VPN – Failed Authentication
```
2025-02-19 18:03:10 VPN-GW User=alice SrcIP=185.220.101.1 Status=Failed Reason=BadPassword
```

### 🐧 Linux – OpenVPN Connection
```
Feb 19 18:05:33 vpn01 openvpn[1234]: alice/8.8.4.4 Peer Connection Initiated
```

### 🪟 Windows – VPN Client Disconnect
```
2025-02-19 18:07:11 WIN-WS01 User=john.doe VPN=Disconnected Duration=02:15:22
```

---

## 🔍 Fundamental Search Examples

### 🔐 Successful VPN Connections
```spl
Status=Connected
```

### ❌ Failed VPN Logins
```spl
Status=Failed OR "authentication failed"
```

### 🌍 VPN Connections from Suspicious IPs
```spl
| search SrcIP IN ("185.220.101.1","45.153.160.98")
```

---

## 🚨 Detection Scenarios

### 🔁 Multiple Failed VPN Attempts
```spl
| stats count by user
| where count > 5
```

### 🌍 VPN Access from New or Unusual Location
```spl
| stats dc(country) by user
| where dc(country) > 1
```

### ⚠️ VPN Access Outside Business Hours
```spl
| search hour < 7 OR hour > 19
```

---

## 🛡️ Mitigation & Response
- Enforce MFA for VPN access
- Block suspicious IP addresses
- Disable compromised accounts
- Review VPN access policies
- Alert on abnormal login patterns

---

## 📌 Summary
This file provides **fundamental VPN connection monitoring** for:
- Authentication and session activity
- Windows, Linux, and network VPN logs
- Detection of unauthorized remote access


