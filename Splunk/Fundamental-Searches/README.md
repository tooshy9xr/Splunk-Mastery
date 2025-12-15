# 📝 Fundamental Searches (FS)

The **Fundamental Searches (FS)** folder contains **basic Splunk searches** to monitor and analyze core log data. These searches cover common security and operational events, forming the foundation for SOC analysis, incident response, and threat detection.

---

## 🎯 Purpose
- Teach and demonstrate **basic SPL query construction**  
- Monitor **authentication, system, and application logs**  
- Serve as building blocks for **advanced searches, dashboards, and alerts**  

---

## 🔎 Search Details
  
### 🎯 Miscellaneous Data
  
- ⚪ [Sample Authentication Logs](Miscellaneous-Data/SampleAuthenticationLogs.md)
- ⚪ [Sample System Logs](Miscellaneous-Data/SampleSystemLogs.md)
- ⚪ [Sample Network Logs](Miscellaneous-Data/SampleNetworkLogs.md)
- ⚪ [Sample Security Logs](Miscellaneous-Data/SampleSecurityLogs.md)
- ⚪ [Sample Application Logs](Miscellaneous-Data/SampleApplicationLogs.md)
- ⚪ [Sample Cloud Logs](Miscellaneous-Data/Sample-Cloud-Logs.md)
- ⚪ [Sample Database Logs](Miscellaneous-Data/Sample-Database-Logs)

### 🔐 Authentication Searches
- ⚪ [Successful Logins](Authentication-Searches/auth_success.md)  
- ⚪ [Windows Authentication](Authentication-Searches/WindowsAuthentication.md)  
- ⚪ [Linux Authentication](Authentication-Searches/LinuxAuthentication.md)  
- ⚪ [Failed Authentication](Authentication-Searches/Failed-Authentication.md)  
- ⚪ [SSH Authentication](Authentication-Searches/SSH-Authentication.md)
- ⚪ [VPN Authentication](Authentication-Searches/VPN-Authentication.md)
- ⚪ [MFA Authentication](Authentication-Searches/MFA-Authentication.md)
- ⚪ [LDAP Queries](Authentication-Searches/LDAP-Queries.md)
- ⚪ [RADIUS/TACACS+ Logs](Authentication-Searches/RADIUS-TACACS+Logs.md)
- ⚪ [Brute Force Detection](Authentication-Searches/BruteForce-Detection.md)
- ⚪ [Suspicious Logon Locations](Authentication-Searches/Suspicious-Logon-Locations.md)

### ⚙️ System Logs & Services
- ⚪ [Service Start/Stop](SystemLogs&Services/ServiceStart-Stop.md)  
- ⚪ [Software Installation](SystemLogs&Services/SoftwareInstallation.md)  
- ⚪ [System Boot & Shutdown](SystemLogs&Services/SystemBoot&Shutdown.md)  
- ⚪ [High CPU & Memory Usage](SystemLogs&Services/HighCPU&MemoryUsage.md)  
- ⚪ [Disk Usage](SystemLogs&Services/Disk-Usage.md)
- ⚪ [System Errors](SystemLogs&Services/System-Errors.md)
- ⚪ [Kernel Logs](SystemLogs&Services/KernelLogs.md)
- ⚪ [Event Logs](SystemLogs&Services/Event-Logs.md)
- ⚪ [Performance Metrics ](SystemLogs&Services/Performance-Metrics.md)
- ⚪ [Resource Monitoring](SystemLogs&Services/Performance-Metrics.md)

### 📁 File & Process Monitoring
- ⚪ [File Access](File&Process-Monitoring/File-Access.md)  
- ⚪ [Windows Process Creation](File&Process-Monitoring/WindowsProcessCreation.md)  
- ⚪ [Linux Process Monitoring](File&Process-Monitoring/LinuxProcessMonitoring.md)  
- ⚪ [Suspicious Process Termination](File&Process-Monitoring/SuspiciousProcessTermination.md)  
- ⚪ [File Deletion](File&Process-Monitoring/File-Deletion.md)
- ⚪ [File Modifications](File&Process-Monitoring/File-Modifications.md)
- ⚪ [Cron Job Monitoring](File&Process-Monitoring/Cron-Job-Monitoring.md)
- ⚪ [Script Execution](File&Process-Monitoring/Script-Execution.md)
- ⚪ [Executable Launches](File&Process-Monitoring/Executable-Launches.md)
- ⚪ [Sensitive File Tracking](File&Process-Monitoring/Sensitive-File-Tracking.md)

### 🛡 Security & Privilege Monitoring
- ⚪ [Admin Privilege Changes](Security&Privilege-Monitoring/AdminPrivilegeChanges.md)  
- ⚪ [User Creation & Deletion](Security&Privilege-Monitoring/UserCreation&Deletion.md)  
- ⚪ [Account Lockouts](Security&Privilege-Monitoring/Account-Lockouts.md)  
- ⚪ [Malware Detection](Security&Privilege-Monitoring/Malware-Detection.md)  
- ⚪ [Privilege Escalation Attempts](Security&Privilege-Monitoring/PrivilegeEscalationAttempt.md)  
- ⚪ [Phishing Detection](Security&Privilege-Monitoring/Phishing-Detection.md)
- ⚪ [Ransomware Detection](Security&Privilege-Monitoring/
- ⚪ [IOC Monitoring](Security&Privilege-Monitoring/  
- ⚪ [Policy Violations](Security&Privilege-Monitoring/  
- ⚪ [Security Groups Changes](Security&Privilege-Monitoring/  
- ⚪ [Audit Failures](Security&Privilege-Monitoring/  

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
