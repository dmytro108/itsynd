
# ********************* EC2 instances
/* resource "aws_instance" "web_server" {
    count                  = 3
    ami                    = "ami-051f7e7f6c2f40dc1"
    instance_type          = "t2.micro"
    subnet_id              = module.vpc[count.index].private_subnets[0]
    vpc_security_group_ids = [module.vpc[count.index].default_security_group_id]

    user_data = <<-EOF
                #!/bin/sh
                apt-get update
                apt-get install -y nginx-light
                echo 'Hello from web server-${count.index}' > /var/www/html/index.html
                EOF

    tags = {
        "Name"        = "web_server-${count.index}"
   }
}
 */
