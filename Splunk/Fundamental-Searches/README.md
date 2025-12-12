# 📝 Fundamental Searches (FS)

The **Fundamental Searches (FS)** folder contains **basic Splunk searches** to monitor and analyze core log data. These searches cover common security and operational events, forming the foundation for SOC analysis, incident response, and threat detection.

---

## 🎯 Purpose
- Teach and demonstrate **basic SPL query construction**  
- Monitor **authentication, system, and application logs**  
- Serve as building blocks for **advanced searches, dashboards, and alerts**  

---

## 🔎 Search Details
  
### 🎯 Miscellaneous / Sample Data
  
- ⚪ Sample Authentication Logs  
- ⚪ Sample System Logs  
- ⚪ Sample Network Logs  
- ⚪ Sample Security Logs  
- ⚪ Sample Application Logs  
- ⚪ Sample Cloud Logs  
- ⚪ Sample Database Logs  

### 🔐 Authentication Searches
- ⚪ [Successful Logins](auth_success.md)  
- ⚪ [Windows Authentication](WindowsAuthentication.md)  
- ⚪ [Linux Authentication](LinuxAuthentication.md)  
- ⚪ [Failed Authentication](Failed-Authentication.md)  
- ⚪ SSH Authentication  
- ⚪ VPN Authentication  
- ⚪ MFA Authentication  
- ⚪ LDAP Queries  
- ⚪ RADIUS/TACACS+ Logs  
- ⚪ Brute Force Detection  
- ⚪ Suspicious Logon Locations  

### ⚙️ System Logs & Services
- ⚪ [Service Start/Stop](ServiceStart-Stop.md)  
- ⚪ [Software Installation](SoftwareInstallation.md)  
- ⚪ [System Boot & Shutdown](SystemBoot&Shutdown.md)  
- ⚪ [High CPU & Memory Usage](HighCPU&MemoryUsage.md)  
- ⚪ Disk Usage  
- ⚪ System Errors  
- ⚪ Kernel Logs  
- ⚪ Event Logs  
- ⚪ Performance Metrics  
- ⚪ Resource Monitoring  

### 📁 File & Process Monitoring
- ⚪ [File Access](File-Access.md)  
- ⚪ [Windows Process Creation](WindowsProcessCreation.md)  
- ⚪ [Linux Process Monitoring](LinuxProcessMonitoring.md)  
- ⚪ [Suspicious Process Termination](SuspiciousProcessTermination.md)  
- ⚪ File Deletions  
- ⚪ File Modifications  
- ⚪ Cron Job Monitoring  
- ⚪ Scheduled Task Monitoring  
- ⚪ Script Execution  
- ⚪ Executable Launches  
- ⚪ Sensitive File Tracking  

### 🛡 Security & Privilege Monitoring
- ⚪ [Admin Privilege Changes](AdminPrivilegeChanges.md)  
- ⚪ [User Creation & Deletion](UserCreation&Deletion.md)  
- ⚪ [Account Lockouts](Account-Lockouts.md)  
- ⚪ [Malware Detection](Malware-Detection.md)  
- ⚪ [Privilege Escalation Attempts](PrivilegeEscalationAttempt.md)  
- ⚪ Phishing Detection  
- ⚪ Ransomware Detection  
- ⚪ IOC Monitoring  
- ⚪ Policy Violations  
- ⚪ Security Groups Changes  
- ⚪ Audit Failures  

### 🌐 Network & Remote Access
- ⚪ [Firewall Monitoring](Firewall-Monitoring.md)  
- ⚪ [Network Connections](Network-Connections.md)  
- ⚪ [Remote Login Detection](RemoteLoginDetection.md)  
- ⚪ [DNS Queries Monitoring](DNS-QueriesMonitoring.md)  
- ⚪ VPN Connections  
- ⚪ SSH Sessions  
- ⚪ Proxy Logs  
- ⚪ Suspicious IP Detection  
- ⚪ GeoIP Analysis  
- ⚪ Port Scanning Detection  
- ⚪ Network Anomaly Detection  

### 📝 Auditing & Threat Detection
- ⚪ [Suspicious Command Usage](Auditing&ThreatDetection/SuspiciousCommandUsage.md)  
- ⚪ [Critical File Changes](Auditing&ThreatDetection/Critical-FileChanges.md)  
- ⚪ [Suspicious File Downloads](Auditing&ThreatDetection/SuspiciousFileDownloads.md)  
- ⚪ [USB Device Usage](Auditing&ThreatDetection/USB-Device.md)  
- ⚪ [Log Deletion Attempts](Auditing&ThreatDetection/LogDeletionAttempts.md)  
- ⚪ [Configuration Changes](Auditing&ThreatDetection/ConfigurationChanges.md)  
- ⚪ [Scheduled Task Creation](Auditing&ThreatDetection/ScheduledTaskCreation.md)  
- ⚪ [Application Errors](Auditing&ThreatDetection/Application-Errors.md)  
- ⚪ [Security Event Correlation](Auditing&ThreatDetection/SecuritEventCorrelation.md)
- ⚪ [System Misconfigurations](Auditing&ThreatDetection/SystemMisconfigurations.md)
- ⚪ [Threat Detection Patterns](Auditing&ThreatDetection/ThreatDetection-Patterns.md)
- ⚪ [User Behavior Analytics](Auditing&ThreatDetection/User-Behavior-Analytics.md)

### ☁️ Cloud Monitoring
- ⚪ AWS Logs  
- ⚪ Azure Logs  
- ⚪ GCP Logs  
- ⚪ Cloud Storage Access  
- ⚪ Cloud IAM Changes  
- ⚪ Cloud Network Traffic  

### 🗄️ Database Monitoring
- ⚪ SQL Queries Monitoring  
- ⚪ Failed DB Connections  
- ⚪ DB Schema Changes  
- ⚪ Slow Queries  

### 💻 Endpoint & Device Monitoring
- ⚪ Laptop & Workstation Logs  
- ⚪ Peripheral Device Monitoring  
- ⚪ Software Install/Uninstall  
- ⚪ Endpoint Threat Detection  
- ⚪ System Configuration Changes  

---
