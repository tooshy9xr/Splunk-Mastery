###############################################
# Search 1: Basic Successful Authentications
###############################################
# Shows simple list of successful logins
index=auth action=success
| table _time user src dest app

###############################################
# Search 2: Successful Logins per User
###############################################
# Counts how many successful logins each user has
index=auth action=success
| stats count by user src app
| sort - count

###############################################
# Search 3: Geo Analysis of Successful Logins
###############################################
# Shows country/city of successful logins
index=auth action=success
| iplocation src
| stats count by user Country City
