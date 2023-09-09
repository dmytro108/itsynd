### Deployment Node.JS applicatin container to EC2 in Auto Scaling Group
#### Schema
![EC2 container schema](docs/EC2_ASG.png)
#### AWS console screenshots
**VPC and subnets with routing**
![VPC and subnets with routing](docs/vpc.png "VPC and subnets with routing")
---
**Launch template**
![Launch template](docs/launch_template.png)
---
**Launch template with detailed CloudWatch monitoring ON**
![Launch template](docs/launch_template3.png)
---
**Launch template user data**
![Launch template](docs/launch_template_ud.png)
---
**Network Load Balancer and listener of port 80**
![Network Load Balancer](docs/LB1.png)
---
**Network Load Balancer networking**
![Network Load Balancer](docs/LB2.png)
---
**Network Load Balancer security groups**
![Network Load Balancer](docs/LB3.png)
---
**Network Load Balancer cross zone balancing off**
![Network Load Balancer](docs/LB4.png)
---
**Auto Scaling group**
*Desired instances: 2, Min: 2, Max: 10*
![Auto Scaling Group](docs/ASG.png)
---
**Auto Scaling group - Scaling out simple scaling policies**
![Auto Scaling Group](docs/ASG_actionsUP.png)
---
**Auto Scaling group - Scaling in simple scaling policies**
![Auto Scaling Group](docs/ASG_actions.png)
---
**CloudWatch alarms**
![CloudWatch alarms](docs/alarms.png)
---
