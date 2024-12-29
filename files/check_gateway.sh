#!/bin/bash

# Check the status of the IPsec connection
ipsec status | grep "gateway-to-server" | grep -E "INSTALLED|CONNECTING" > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "$(date): IPsec connection gateway-to-server is down, attempting to reconnect..." >> /var/log/gateway_check.log
  # Re-establish the specific IPsec connection
  ipsec up gateway-to-server
else
  ipsec status | grep "gateway-to-server" | grep "CONNECTING" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "$(date): IPsec connection gateway-to-server is connecting, no action needed." >> /var/log/gateway_check.log
  else
    echo "$(date): IPsec connection gateway-to-server is up." >> /var/log/gateway_check.log
  fi
fi
