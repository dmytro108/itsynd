### Deployment Node.JS applicatin container to EC2 in Auto Scaling Group
#### Schema
![EC2 container schema](EC2_ASG.png)
#### AWS console screenshots
**VPC and subnets with routing**
![VPC and subnets with routing](vpc.png "VPC and subnets with routing")
---
**Launch template**
![Launch template](launch_template.png)
---
**Launch template with detailed CloudWatch monitoring ON**
![Launch template](launch_template3.png)
---
**Launch template user data**
![Launch template](launch_template_ud.png)
---
**Network Load Balancer and listener of port 80**
![Network Load Balancer](LB1.png)
---
**Network Load Balancer networking**
![Network Load Balancer](LB2.png)
---
**Network Load Balancer security groups**
![Network Load Balancer](LB3.png)
---
**Network Load Balancer cross zone balancing off**
![Network Load Balancer](LB4.png)
---
**Auto Scaling group**
*Desired instances: 2, Min: 2, Max: 10*
![Auto Scaling Group](ASG.png)
---
**Auto Scaling group - Scaling out simple scaling policies**
![Auto Scaling Group](ASG_actionsUP.png)
---
**Auto Scaling group - Scaling in simple scaling policies**
![Auto Scaling Group](ASG_actions.png)
---
**CloudWatch alarms**
![CloudWatch alarms](alarms.png)
---
