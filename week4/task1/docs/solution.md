#### AWS infrastructure
The requested infrastructure was built on top of the basic ifrastructure which already had been created. I utilized Terraform remote state to get access to the basic infrastructure.
The infrastructure includes AWS service endpoints which are neccesery for connecting instances without public IP addreses but placed in public subnets to the SSM service.
The following diagram represents the resulted infrastructure:
![infrastructre](docs/infra.png)

Fierwall diagram:
![fierwall](docs/fw.png)

#### Setup SSM
In order to enable SSM for each instance I had to make the infrastructure complind to the following conditions:
 - The instances must be able to connect to SSM servers via HTTPS
 - The latest version of SSM agent should be installed and run on instances
 - A role with SSM policies should be assumed to every instanve
To achieve the first condition [AWS service endpoints](ssm.tf) which connect instances directly, avoiding the Internet, to the SSM services had been created. As well [sucurity group's rules](security_groups.tf) allowing HTTPS outbound traffic had been created.
The second condition was achieved with launching instances with AMI including the latest SMM agent. And the third condition was satisfied with [creating an instance profile](main.tf) containig a role with appropriate policies attached.
```hcl
# The role for instances which satisfies SSM conditions
resource "aws_iam_role_policy_attachment" "ssm_mamaged_core" {
  role       = aws_iam_role.ssm_managed.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
resource "aws_iam_role_policy_attachment" "ssm_mamaged_default" {
  role       = aws_iam_role.ssm_managed.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedEC2InstanceDefaultPolicy"
}
resource "aws_iam_role_policy_attachment" "ssm_mamaged_ec24ssm" {
  role       = aws_iam_role.ssm_managed.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}
```
![ssm](docs/2023-09-23_23h49_59.png)

#### Ansible inventory
Ansible [inventory file](ansible/inventory) is generating automaticaly from the [Terraform configuration](inventory.tf) utilizing Terraform resource local_file and processing a [template file](inventory.tftpl).

Template file:
```
[app_servers]
%{ for app_ip in app_servers ~}
${app_ip}
%{ endfor ~}

[db_servers]
%{ for db_ip in db_servers ~}
${db_ip}
%{ endfor ~}

[all:vars]
ansible_ssh_user = ec2-user
```
Terraform configuration:
```hcl
resource "local_file" "ansible_inventory" {
  content = templatefile("${var.inventory_template}",
    {
      app_servers = aws_instance.app_servers[*].private_ip,
      db_servers  = [aws_instance.db.private_ip]
    }
  )

  filename = var.inventory_file
}
```
