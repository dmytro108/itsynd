#!/bin/bash

while true; do
  echo "Polling the cluster for an external IP address..."
  IP=$(kubectl get svc ingress-nginx-controller -n ingress-nginx -o jsonpath={.status.loadBalancer.ingress[0].ip})
  
  # If IP is not empty, break the loop
  if [ -n "$IP" ]; then
    echo "Got IP: $IP"
    break
  fi
  # Wait for one second
  sleep 2
done

# Writing the IP to a file
echo "lb_ip: $IP" > lb-ip.yaml
