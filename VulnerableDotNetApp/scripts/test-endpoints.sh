#!/bin/bash

# Test Health endpoint
echo "Testing Health endpoint:"
curl -s "http://localhost:5000/api/vulnerable/health"

# Test SQL Injection endpoint
echo -e "\nTesting SQL Injection endpoint:"
sql_query="query=SELECT+*+FROM+users+WHERE+username+=+'admin'+OR+1=1--"
curl -s "http://localhost:5000/api/vulnerable/sqlinjection?$sql_query"

# Test Command Injection endpoint
echo -e "\nTesting Command Injection endpoint:"
command="cmd=ls"
curl -s "http://localhost:5000/api/vulnerable/commandinjection?$command"

# Dangerous Command Injection test (Warning: Do not run on production)
# echo -e "\nDangerous Command Injection Test:"
# dangerous_command="cmd=rm+-rf+/"
# curl -s "http://localhost:5000/api/vulnerable/commandinjection?$dangerous_command"
