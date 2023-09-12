### Solution
This solution utilizes a range of terraform modules from A. Babenko:
 - [vpc](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
 - [autoscaling](https://registry.terraform.io/modules/terraform-aws-modules/autoscaling/aws/latest)
 - [security-group](https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest)
 - [autoscaling](https://registry.terraform.io/modules/terraform-aws-modules/autoscaling/aws/latest)
 - [alb](https://registry.terraform.io/modules/terraform-aws-modules/alb/aws/latest)

The infrastructure scheme remains the same as in [Week2/task1 solution description](../../week2/task1/docs/solution.md).

![](../../week2/task1/docs/EC2_ASG.png)
