#!/bin/bash
# Script to parse curl JSON output from stdin

# Read JSON output from stdin
json_output=$(cat)

# Check if JSON output is empty
if [ -z "$json_output" ]; then
    echo "No data received"
    exit 1
fi

# Start of JSON array
echo "["

# Initialize a flag to manage comma placement
first=1

# Extract relevant information using jq and output directly in JSON format
time_namelookup=$(echo "$json_output" | jq -r '.time_namelookup')
time_connect=$(echo "$json_output" | jq -r '.time_connect')
time_appconnect=$(echo "$json_output" | jq -r '.time_appconnect')
time_pretransfer=$(echo "$json_output" | jq -r '.time_pretransfer')
time_redirect=$(echo "$json_output" | jq -r '.time_redirect')
time_starttransfer=$(echo "$json_output" | jq -r '.time_starttransfer')
time_total=$(echo "$json_output" | jq -r '.time_total')
http_code=$(echo "$json_output" | jq -r '.http_code')
size_download=$(echo "$json_output" | jq -r '.size_download')
remote_ip=$(echo "$json_output" | jq -r '.remote_ip')
local_ip=$(echo "$json_output" | jq -r '.local_ip')
speed_download=$(echo "$json_output" | jq -r '.speed_download')
url_host=$(echo "$json_output" | jq -r '.url | split("//")[1] | split("/")[0] | split(":")[0]')
url_port=$(echo "$json_output" | jq -r '.url | split("//")[1] | split("/")[0] | split(":")[1] // "443"')

# Print the extracted information in JSON format to stdout
if [ $first -eq 1 ]; then
    first=0
else
    echo ","  # Print a comma before each JSON object except the first
fi

echo -n "{\"Time Namelookup\": \"$time_namelookup\", \"Time Connect\": \"$time_connect\", \"Time Appconnect\": \"$time_appconnect\", \"Time Pretransfer\": \"$time_pretransfer\", \"Time Redirect\": \"$time_redirect\", \"Time Starttransfer\": \"$time_starttransfer\", \"Time Total\": \"$time_total\", \"HTTP Code\": \"$http_code\", \"Size Download\": \"$size_download\", \"Remote IP\": \"$remote_ip\", \"Local IP\": \"$local_ip\", \"Speed Download\": \"$speed_download\", \"URL Host\": \"$url_host\", \"URL Port\": \"$url_port\"}"

# End of JSON array
echo -e "\n]"
