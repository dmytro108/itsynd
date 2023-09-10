
#### Solution 1. Deployment app container to EC2
In this solution, I deploy containers with the test application on EC2 instances in an autoscaling group placed into two private subnets across two availability zones. A network balancer is used to balance requests. I didn't use the application balancer because of the test application is a monolith and there is no way to effectively distribute the load along different routes. I decided that using an application balancer would not provide any benefit. The design also includes a bastion host for secure access to instances running containers.
Automatic scaling out/in of the group occurs in stages when four CloudWatch alarms are triggered - the average CPU utilization of the group reaches 20%, 30%, 40% and 50%.
Alarms are configured with a minimum response period - one threshold value per 1 minute. To do this, I had to create my own dynamic policies in the autoscaling group and also to enable detailed CloudWatch monitoring in the EC2 instance launch template.
Please see [the solution schema and console screenshots](docs/ec2_asg.md)

#### Solution 2. Deployment app container to ECS Fargate
The Fargate solution is similar to the Solution #1 - I created an ECS cluster in into two private subnets across two availability zones. I used the same Network Balancer and Security groups from previous solution. Fargate service also has from 2 to 10 tasks with similar policies to run - CloudWatch alarms trigger spawning new tasks. The container image I placed into a private ECR.
Please see [the solution screenshots](docs/fargate.md)
