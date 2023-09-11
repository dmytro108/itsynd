module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = var.elb_name

  load_balancer_type = "network"

  vpc_id                = module.vpc.vpc_id
  subnets               = module.vpc.public_subnets
  create_security_group = false
  security_groups       = [module.sg_nlb.security_group_id]

  target_groups = [
    {
      name             = "${var.elb_name}-tg"
      backend_protocol = "TCP"
      backend_port     = 80
      target_type      = "instance"
      health_check = {
        path                = "/"
        matcher             = "200"
        healthy_threshold   = 2
        interval            = 10
        timeout             = 3
        unhealthy_threshold = 3
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "TCP"
      target_group_index = 0
    }
  ]

  /*   access_logs = {
    bucket = "my-nlb-logs"
  } */
}
