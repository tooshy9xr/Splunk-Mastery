# 🌟 Scheduled Task Creation — Windows & Linux

A beginner-friendly collection of Splunk searches to monitor scheduled task creation events on Windows and Linux systems. Each search includes a short description, purpose, and SPL query.

## Windows Scheduled Task Creation
 Detect newly created scheduled tasks
```spl

index=windows sourcetype=WinEventLog:Security EventCode=4698
```

## Linux Scheduled Task Creation
 Detect new cron jobs or scheduled tasks
```spl

index=linux sourcetype=linux_secure command="*cron*" OR command="*at*"
```
