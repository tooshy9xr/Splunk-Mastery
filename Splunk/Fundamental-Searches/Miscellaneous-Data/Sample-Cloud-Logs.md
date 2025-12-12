# ☁️ Sample Cloud Logs  
This file provides **sample cloud service logs** to test Splunk searches, dashboards, and monitoring for cloud environments.  
Includes AWS, Azure, and GCP logs for authentication, resource usage, API calls, network activity, and security events.

---

# 1. AWS CloudTrail Logs

## ✅ Successful API Call  
```
2025-02-12 10:15:21 aws-cloudtrail EventName=DescribeInstances User=alice SourceIP=203.0.113.12 Status=Success
```

## ❌ Unauthorized API Call  
```
2025-02-12 10:17:45 aws-cloudtrail EventName=DeleteBucket User=guest SourceIP=203.0.113.50 Status=Unauthorized
```

## 🔄 Resource Creation  
```
2025-02-12 10:22:12 aws-cloudtrail EventName=RunInstances User=bob SourceIP=192.168.1.55 Status=Success
```

## ⚠️ IAM Role Change  
```
2025-02-12 10:25:30 aws-cloudtrail EventName=AttachRolePolicy User=itadmin SourceIP=192.168.1.45 Status=Success
```

---

# 2. AWS VPC / Network Logs

## 🔌 Network Connection Allowed  
```
2025-02-12 11:05:11 vpcflow log AWSAccount=123456789012 SrcIP=192.168.1.50 DstIP=10.0.1.25 Protocol=TCP Action=ACCEPT Bytes=2048
```

## ❌ Network Connection Denied  
```
2025-02-12 11:07:21 vpcflow log AWSAccount=123456789012 SrcIP=203.0.113.77 DstIP=10.0.1.25 Protocol=TCP Action=REJECT
```

## 🚨 Suspicious Port Scan  
```
2025-02-12 11:10:33 vpcflow log SrcIP=203.0.113.99 DstIP=10.0.0.12 PortRange=1-1024 Action=REJECT Count=512
```

---

# 3. Azure Activity Logs

## ✅ Successful VM Start  
```
2025-02-12 11:30:11 azure Activity=Start VirtualMachine=VM-Prod01 User=admin Result=Success
```

## ❌ Failed Login Attempt  
```
2025-02-12 11:32:45 azure Activity=LoginFailure User=guest SourceIP=198.51.100.25
```

## ⚠️ Role Assignment Change  
```
2025-02-12 11:35:21 azure Activity=AssignRole User=alice Role=Contributor TargetUser=bob
```

## 🔄 Storage Blob Upload  
```
2025-02-12 11:40:33 azure Activity=BlobUpload Container=Finance File=report.pdf User=john.doe
```

---

# 4. GCP Audit Logs

## ✅ Successful API Request  
```
2025-02-12 12:05:11 gcp LogName=activity Event=ComputeInstanceStart User=alice Status=Success
```

## ❌ Unauthorized API Request  
```
2025-02-12 12:07:33 gcp LogName=activity Event=DeleteBucket User=guest Status=PermissionDenied
```

## 🔄 Resource Modification  
```
2025-02-12 12:10:22 gcp LogName=activity Event=UpdateFirewall User=itadmin SrcIP=192.168.1.45 Status=Success
```

## ⚠️ Security Policy Violation  
```
2025-02-12 12:12:55 gcp LogName=policy Event=IAMPolicyChange User=bob Status=Warning
```

---

# 5. Cloud Security / Threat Detection

## 🚨 Compromised Credentials Detected  
```
2025-02-12 12:20:11 aws-cloudtrail EventName=ConsoleLogin User=john Status=Failure Reason=PasswordGuess
```

## 🌍 Login From Unusual Location  
```
2025-02-12 12:22:33 azure Activity=Login User=alice Location=Russia Result=Success
```

## 🔐 Privilege Escalation  
```
2025-02-12 12:25:45 gcp Event=IAMRoleGrant User=guest Role=Admin Status=Success
```

## 💾 Large Data Transfer  
```
2025-02-12 12:30:21 aws-s3 Event=GetObject User=john File=backup.tar.gz Size=950MB
```

---

# 6. Cloud Resource Monitoring

## High CPU Usage Alert  
```
2025-02-12 12:45:11 aws-cloudwatch Metric=CPUUtilization Instance=i-123456 Threshold=90% Status=Alarm
```

## Low Disk Space  
```
2025-02-12 12:47:22 azure Monitor=DiskUsage VM=VM-Prod01 FreeSpace=5% Status=Warning
```

## Network Traffic Spike  
```
2025-02-12 12:50:33 gcp Metric=NetworkBytes Instance=web-prod01 Value=150GB Threshold=100GB Status=Alert
```

---

# Summary

This file includes sample logs for:

- AWS CloudTrail and VPC Flow Logs  
- Azure Activity and Storage Logs  
- GCP Audit and Resource Logs  
- Cloud security events (unauthorized access, privilege escalation)  
- Resource monitoring and performance alerts  


