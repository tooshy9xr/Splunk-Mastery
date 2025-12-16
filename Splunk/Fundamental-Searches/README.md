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
- ⚪ [Ransomware Detection](Security&Privilege-Monitoring/Ransomware-Detection.md)
- ⚪ [IOC Monitoring](Security&Privilege-Monitoring/IOC-Monitoring.md)
- ⚪ [Policy Violations](Security&Privilege-Monitoring/Policy-Violations.md)
- ⚪ [Security Groups Changes](Security&Privilege-Monitoring/Security-Groups-Changes.md)
- ⚪ [Audit Failures](Security&Privilege-Monitoring/Audit-Failures.md)

### 🌐 Network & Remote Access
- ⚪ [Firewall Monitoring](Network&Remote-Access/Firewall-Monitoring.md)  
- ⚪ [Network Connections](Network&Remote-Access/Network-Connections.md)  
- ⚪ [Remote Login Detection](Network&Remote-Access/RemoteLoginDetection.md)  
- ⚪ [DNS Queries Monitoring](Network&Remote-Access/DNS-QueriesMonitoring.md)  
- ⚪ [VPN Connections](Network&Remote-Access/VPN-Connections.md)
- ⚪ [SSH Sessions](Network&Remote-Access/SSH-Sessions.md)
- ⚪ [Proxy Logs](Network&Remote-Access/Proxy-Logs.md)
- ⚪ [Suspicious IP Detection](Network&Remote-Access/Suspicious-IP-Detection.md)
- ⚪ [GeoIP Analysis](Network&Remote-Access/GeoIP-Analysis.md)
- ⚪ [Port Scanning Detection](Network&Remote-Access/Port-Scanning-Detection.md) 
- ⚪ [Network Anomaly Detection](Network&Remote-Access/Network-Anomaly-Detection.md)

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
- ⚪ [AWS Logs](Cloud-Monitoring/AWS-Logs.md)
- ⚪ [Azure Logs](Cloud-Monitoring/Azure-Logs.md)
- ⚪ [GCP Logs](Cloud-Monitoring/GCP-Logs.md) 
- ⚪ [Cloud Storage Access](Cloud-Monitoring/Cloud-Storage-Access.md) 
- ⚪ [Cloud IAM Changes](Cloud-Monitoring/Cloud-IAM-Changes.md) 
- ⚪ [Cloud Network Traffic](Cloud-Monitoring/Cloud-Network-Traffic.md)

### 🗄️ Database Monitoring](
- ⚪ [SQL Queries Monitoring](Database-Monitoring/SQL-Queries-Monitoring.md) 
- ⚪ [Failed DB Connections](Database-Monitoring/Failed-DB-Connections.md)
- ⚪ [DB Schema Changes](Database-Monitoring/DB-Schema-Changes.md)
- ⚪ [Slow Queries](Database-Monitoring/Slow-Queries.md) 

### 💻 Endpoint & Device Monitoring
- ⚪ Laptop & Workstation Logs  
- ⚪ Peripheral Device Monitoring  
- ⚪ Software Install/Uninstall  
- ⚪ Endpoint Threat Detection  
- ⚪ System Configuration Changes  

---
