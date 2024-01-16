### Scenario
As a newly onboarded DevOps engineer at our tech company, we've received a request from our client that requires careful attention. They need to set up one EC2 instance in each of the three different VPCs. The twist is that these instances need to communicate with each other, necessitating a VPC Peering setup. In addition, the client wants a web server  Nginx installed on these instances via the user-data feature. 
### Tasks
1. Set up one EC2 instance in each of the three different VPCs.
1. Configure VPC Peering between these VPCs so that the instances can communicate with each other. 
1. Using the user-data feature of EC2 instances, install a web server Nginx on each instance. Configure it to serve a simple HTML page on port 80.
