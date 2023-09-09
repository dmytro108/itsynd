#### Deployment app container to EC2
In this solution, I deploy containers with the test application on EC2 instances in an autoscaling group. A network balancer is used to balance requests. I didn't use the application balancer because of the test application is a monolith and there is no way to effectively distribute the load along different routes. I decided that using an application balancer would not provide any benefit.
The design also includes a bastion host for secure access to instances running containers.
Automatic scaling out/in of the group occurs in stages when four CloudWatch alarms are triggered - the average CPU utilization of the group reaches 20%, 30%, 40% and 50%.
Alarms are configured with a minimum response period - one threshold value per 1 minute. To do this, I had to create my own dynamic policies in the autoscaling group and also to enable detailed CloudWatch monitoring in the EC2 instance launch template.
#### Schema
![EC2 container schema](docs/EC2_ASG.png)
#### AWS console screenshots
VPC and subnets with routing
![VPC and subnets with routing](docs/vpc.png "VPC and subnets with routing")

Launch template
![Launch template](docs/launch_template.png)

Launch template with detailed CloudWatch monitoring ON
![Launch template](docs/launch_template3.png)

Launch template user data
![Launch template](docs/launch_template_ud.png)

Network Load Balancer and listener of port 80
![Network Load Balancer](docs/LB1.png)

Network Load Balancer networking
![Network Load Balancer](docs/LB2.png)

Network Load Balancer securiyu groups
![Network Load Balancer](docs/LB3.png)

Network Load Balancer cross zone balancing off
![Network Load Balancer](docs/LB4.png)

Auto Scaling group
Desired instances: 2, Min: 2, Max: 10
![Auto Scaling Group](docs/ASG.png)

Auto Scaling group - Scaling out simple scaling policies
![Auto Scaling Group](docs/ASG_actionsUP.png)

Auto Scaling group - Scaling in simple scaling policies
![Auto Scaling Group](docs/ASG_actions.png)

CloudWatch alarms
![CloudWatch alarms](docs/alarms.png)