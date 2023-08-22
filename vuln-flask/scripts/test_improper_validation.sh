#!/bin/bash

# URL of your vulnerable Flask application's endpoint
URL="http://localhost:5000/improper-validation"

# Test with a valid multiplier
echo "Testing with valid multiplier:"
curl -X POST \
    -H "Content-Type: application/json" \
    -d '{"command":"echo test","multiplier":"5"}' \
    $URL
echo -e "\n"

# Test with an invalid multiplier (e.g., string instead of a number)
echo "Testing with invalid multiplier (string):"
curl -X POST \
    -H "Content-Type: application/json" \
    -d '{"command":"whoami;ls -latr","multiplier":"invalid_multiplier"}' \
    $URL
echo -e "\n"

# Test with other unexpected values (e.g., a negative number)
echo "Testing with unexpected value (negative number):"
curl -X POST \
    -H "Content-Type: application/json" \
    -d '{"command":"id;whoami;ls -latr","multiplier":"-10"}' \
    $URL
echo -e "\n"
