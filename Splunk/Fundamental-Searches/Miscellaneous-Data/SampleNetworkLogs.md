# 🌐 Sample Network Logs  
This file provides **realistic sample network logs** for Splunk testing, including:  
- Firewall events  
- DNS queries  
- VPN logins  
- Proxy traffic  
- Network connections  
- IDS/IPS alerts  
- Port scans  
- Data exfiltration patterns  

These samples help you test dashboards, anomaly detection, correlation rules, and threat scenarios.

---

# 🔥 Firewall Logs (Cisco, FortiGate, Palo Alto Style)

## 🔓 Allowed Traffic  
```
Feb 12 13:22:15 firewall01 Allow TCP src=192.168.1.20 dst=10.0.0.25 spt=443 dpt=51545 action=allow
```

## ❌ Blocked Traffic  
```
Feb 12 13:23:51 firewall01 Deny TCP src=203.0.113.50 dst=192.168.1.10 spt=445 dpt=445 action=deny reason=blocked_by_policy
```

## 🚨 Port Scan Detected  
```
Feb 12 13:25:11 firewall01 alert type=port_scan src=203.0.113.99 dst=192.168.1.80 ports=1-1024 count=512
```

## 🛑 Malware Domain Block  
```
Feb 12 14:11:41 firewall01 blocked url=malicious-domain.xyz category=malware src=192.168.1.45 dst=91.210.55.23
```

---

# 🔍 DNS Logs

## 🔎 Normal DNS Query  
```
Feb 12 13:32:14 dns01 query client=192.168.1.40 name=google.com type=A response=142.250.181.78
```

## 🚨 DNS Query to Suspicious Domain  
```
Feb 12 14:21:44 dns01 query client=192.168.1.55 name=xj90ajp.malware.cc type=A response=185.210.222.90
```

## 🔁 High DNS Query Volume  
```
Feb 12 14:22:05 dns01 query client=192.168.100.22 name=update.service.net type=A repeated=120
```

---

# 🔐 VPN Logs

## 🔑 Successful VPN Login  
```
2025-02-12 13:50:11 vpn01 login success user=john.doe src_ip=203.0.113.10 protocol=SSLVPN
```

## ❌ Failed VPN Login  
```
2025-02-12 13:51:30 vpn01 login failed user=admin src_ip=203.0.113.55 reason=invalid_credentials
```

## 🌍 VPN Geo-Location Anomaly  
```
2025-02-12 13:53:42 vpn01 login success user=mike src_ip=45.120.10.77 country=Russia
```

---

# 🛰 Proxy Web Logs

## 🌐 Normal Web Access  
```
2025-02-12 14:11:09 proxy01 GET http://example.com 200 user=jane.smith src_ip=192.168.1.50 bytes_out=14214
```

## 🚨 Access to Known Malicious URL  
```
2025-02-12 14:15:44 proxy01 GET http://darkweb-market.xyz 403 user=student src_ip=192.168.1.88 category=malware
```

## 💾 Large File Download (Possible Exfiltration)  
```
2025-02-12 14:17:59 proxy01 GET http://fileshare.net/download.bin 200 bytes_out=99999999 user=john.doe
```

---

# 🔗 Network Connection Logs (NetFlow / Zeek Style)

## 🔌 Outbound Connection  
```
2025-02-12 14:32:10 connection src=192.168.1.44 dst=8.8.8.8 proto=udp port=53 bytes=1024
```

## 📥 Suspicious Outbound to Rare Country  
```
2025-02-12 14:33:55 connection src=192.168.1.22 dst=102.14.67.88 proto=tcp port=4443 bytes=124904 country=South Africa
```

## 🔁 Internal Lateral Movement  
```
2025-02-12 14:35:22 connection src=10.0.0.5 dst=10.0.0.12 proto=tcp port=445 bytes=2040
```

---

# ⚠️ IDS / IPS Alerts (Snort / Suricata Style)

## 🦠 Malware Command & Control  
```
02/12/2025 14:41:35 IDS alert signature="CobaltStrike Beacon" src=192.168.1.90 dst=185.22.110.54 severity=high
```

## 🚨 SQL Injection Attempt  
```
02/12/2025 14:41:35 IDS alert signature="SQLi Attempt UNION SELECT" src=203.0.113.70 dst=192.168.1.30 severity=medium
```

## 💥 Exploit Attempt  
```
02/12/2025 14:43:01 IDS alert signature="EternalBlue Exploit" src=203.0.113.222 dst=10.0.0.18 severity=critical
```

---

# 📡 Data Exfiltration Logs

## 📤 High Outbound Transfer  
```
2025-02-12 14:55:21 proxy01 bytes_out=450000000 src_ip=192.168.1.33 user=sara
```

## 📤 Unknown Protocol to External IP  
```
2025-02-12 14:56:51 connection proto=icmp src=192.168.1.45 dst=51.91.23.14 size=9055
```

## 📤 Suspicious Large DNS TXT Query  
```
2025-02-12 14:57:41 dns01 query type=TXT name=bigdatachunk.mydomain.com size=20480
```

---

# 🧪 Attack Simulation Scenarios

## 🔥 Ransomware Lateral Spread  
```
connection src=192.168.1.10 dst=192.168.1.15 port=445 repeated=150
IDS alert signature="SMB ransomware spread"
```

## 🕵️ External C2 Channel  
```
connection src=192.168.1.100 dst=193.10.20.77 proto=tcp port=443 bytes=340000 interval=1s beaconing=true
```

## 🛰 Data Exfil via HTTPS  
```
proxy01 GET https://dropbox-upload.com/upload.bin bytes_out=600000000 user=itadmin
```

---

# 📌 Summary  
This file includes sample logs for:

- Firewall traffic  
- DNS activity  
- VPN authentication  
- Proxy web access  
- NetFlow connections  
- IDS/IPS alerts  
- Exfiltration scenarios  
- Port scans  
- Threat simulations  

Use this file for building:  
- Fundamental searches  
- Dashboards  
- Detection playbooks  
- Correlation rules  
- SOC training labs  


