#### Deploy and Configure Infrastructure Using Terraform and Ansible
##### Scenario:
Imagine you're a DevOps engineer tasked to deploy and set up servers for a new application
that requires a database. For this, we'll be deploying a [Django sample app from the
DigitalOcean team:](https://github.com/digitalocean/sample-django).
Your responsibilities will include:
1. Deploying the infrastructure using Terraform, which should consist of a VPC with public and private networks.
2. Creating three EC2 instances - two for the application in the public network and one for the database in the private network.
3. Configuring and installing SSM agent on instances using Terraform.

> Note: SSM is preinstalled on these AMIs:` Amazon Linux 2 Base / ECS-Optimized Base AMIs / 2023 (AL2023), Ubuntu Server 16.04, 18.04, and 20.04`.

4. Setting up a Load Balancer to distribute traffic among the application instances.
5. Producing an output file in inventory format for Ansible with Terraform.
For Ansible, you need to create three roles - two for setting up the infrastructure and one for deploying the application. The infrastructure setup role should install Postgres on an instance and create a user and a database. The role for application instances should be to install the necessary software to run the application and Nginx to proxy requests from the instance's port 80 to the Django application. The deployment role should update the code from GitHub, update the configuration with the current DB credentials, and perform DB migrations.

Run these roles using the AWS EC2 System Manager. [Here, you can check how](https://aws.amazon.com/blogs/mt/running-ansible-playbooks-using-ec2-systems-manager-run-command-and-state-manager/).
