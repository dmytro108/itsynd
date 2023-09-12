<!-- BEGIN_TF_DOCS -->
# IT Syndicate Boot Camp
## Week 3. Task 1
### Implement Infrastructure using Terraform
##### Scenario:
Imagine you're a DevOps engineer at a growing startup. The company has recently developed a
new application and wants to leverage AWS for hosting the application. They need to set up and
manage the infrastructure Your task involves:
 1. Using Terraform, describe the infrastructure for the application from the previous task
https://github.com/benc-uk/nodejs-demoapp
 2. Set up and configure an EC2 Auto Scaling group, where the application will be run using
Docker configured through EC2 user data. The infrastructure should include:
 - Network and security groups
 - EC2 Auto Scaling group (you can use this module for reference or implementation: erraform-aws-modules/autoscaling/aws)
 - Load balancer and target group

**Bonus Task**: For those who complete the task quickly, use Terraform to set up email notifications for scaling events using CloudWatch and SNS.
### Solution
This solution utilizes a range of terraform modules from A. Babenko:
 - [vpc](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
 - [autoscaling](https://registry.terraform.io/modules/terraform-aws-modules/autoscaling/aws/latest)
 - [security-group](https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest)
 - [autoscaling](https://registry.terraform.io/modules/terraform-aws-modules/autoscaling/aws/latest)
 - [alb](https://registry.terraform.io/modules/terraform-aws-modules/alb/aws/latest)

The infrastructure scheme remains the same as in [Week2/task1 solution description](../../week2/task1/docs/solution.md).

![](../../week2/task1/docs/EC2_ASG.png)
### Reference
#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |
#### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.16.1 |
#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_desire"></a> [asg\_desire](#input\_asg\_desire) | Desire number of EC2 instances in Autoscaling Group | `number` | `0` | no |
| <a name="input_asg_max"></a> [asg\_max](#input\_asg\_max) | Maximal number of EC2 instances in Autoscaling Group | `number` | `0` | no |
| <a name="input_asg_min"></a> [asg\_min](#input\_asg\_min) | Minimal number of EC2 instances in Autoscaling Group | `number` | `0` | no |
| <a name="input_asg_name"></a> [asg\_name](#input\_asg\_name) | Autoscaling group name | `string` | `"my-asg"` | no |
| <a name="input_azs"></a> [azs](#input\_azs) | AWS availability zones | `list(string)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b",<br>  "us-east-1c"<br>]</pre> | no |
| <a name="input_bastion_pub_key"></a> [bastion\_pub\_key](#input\_bastion\_pub\_key) | SSH publick key for access to bastion host | `string` | `""` | no |
| <a name="input_ec2_ami_id"></a> [ec2\_ami\_id](#input\_ec2\_ami\_id) | AWS AMI id for EC2 instances | `string` | `"ami-0e1c5be2aa956338b"` | no |
| <a name="input_ec2_type"></a> [ec2\_type](#input\_ec2\_type) | AWS EC2 instance type | `string` | `"t3.micro"` | no |
| <a name="input_elb_name"></a> [elb\_name](#input\_elb\_name) | Load Balancer name | `string` | `"elb"` | no |
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | Environment tag | `string` | `"Unknown"` | no |
| <a name="input_launch_templ_descr"></a> [launch\_templ\_descr](#input\_launch\_templ\_descr) | Launch template description | `string` | `"Launch Template for an ASG"` | no |
| <a name="input_launch_templ_name"></a> [launch\_templ\_name](#input\_launch\_templ\_name) | Launch template Name | `string` | `"my-template"` | no |
| <a name="input_private_subnet_num"></a> [private\_subnet\_num](#input\_private\_subnet\_num) | Number of private subnets in each VPC | `number` | `1` | no |
| <a name="input_public_subnet_num"></a> [public\_subnet\_num](#input\_public\_subnet\_num) | Number of public subnets in each VPC | `number` | `0` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region for all recources and providers | `string` | `"us-east-1"` | no |
| <a name="input_vpc_cidr_prefix"></a> [vpc\_cidr\_prefix](#input\_vpc\_cidr\_prefix) | VPC CIDR base for calculating real VPC CIDRs | `string` | `"10.0.0.0/0"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC name tag | `string` | `"Noname"` | no |
| <a name="input_vpc_num"></a> [vpc\_num](#input\_vpc\_num) | Number of VPCs | `number` | `1` | no |
#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_public_ip"></a> [bastion\_public\_ip](#output\_bastion\_public\_ip) | Bastion node publick IP address |
| <a name="output_elb_dns"></a> [elb\_dns](#output\_elb\_dns) | DNS name of the Web service |
#### Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.cpu_20](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu_30](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu_40](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu_50](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_eip.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
### Results
### Screenshots
![Alt text](docs/2023-09-12_20h25_15.png)
![Alt text](docs/2023-09-12_20h26_57.png)
![Alt text](docs/2023-09-12_20h28_09.png)
![Alt text](docs/2023-09-12_20h28_36.png)
![Alt text](docs/2023-09-12_20h29_04.png)
![Alt text](docs/2023-09-12_20h29_18.png)
![Alt text](docs/2023-09-12_20h30_42.png)
![Alt text](docs/2023-09-12_20h31_31.png)
![Alt text](docs/2023-09-12_20h32_08.png)
![Alt text](docs/2023-09-12_20h32_13.png)
![Alt text](docs/2023-09-12_20h33_52.png)
![Alt text](docs/2023-09-12_20h35_25.png)
![Alt text](docs/2023-09-12_20h36_48.png)
![Alt text](docs/2023-09-12_20h37_23.png)
<!-- END_TF_DOCS -->