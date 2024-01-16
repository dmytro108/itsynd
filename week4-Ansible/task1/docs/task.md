### Scenario:
As a DevOps engineer tasked to deploy and set up servers for a new application that requires a database. For this, we'll be deploying a [Django sample app from the DigitalOcean team:](https://github.com/digitalocean/sample-django).

### Tasks:
1. Deploying the infrastructure using Terraform, which should consist of a VPC with public and private networks.
1. Creating three EC2 instances - two for the application in the public network and one for the database in the private network.
1. Configuring and installing SSM agent on instances using Terraform.
1. Setting up a Load Balancer to distribute traffic among the application instances.
1. Producing an output file in inventory format for Ansible with Terraform.
1. For Ansible, you need to create three roles - two for setting up the infrastructure and one for deploying the application:
      1. The infrastructure setup role should install Postgres on an instance and create a user and a database.
      1. The role for application instances should be to install the necessary software to run the application and Nginx to proxy requests from the instance's port 80 to the Django application. 
      1. The deployment role should update the code from GitHub, update the configuration with the current DB credentials, and perform DB migrations.
1. Run these roles using the AWS EC2 System Manager.
