#!/bin/bash

URL="http://localhost:5000"

# Test Command Injection
echo "Testing Command Injection:"
command_to_execute="ls -la"
curl -X POST -d "command=$command_to_execute" $URL/command
echo -e "\n"

# Test SQL Injection
echo "Testing SQL Injection:"
sql_query="SELECT * FROM users;" # Modify this query as per your database schema
curl -G -d "query=$sql_query" $URL/sql
echo -e "\n"

