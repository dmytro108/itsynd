resource "aws_cloudwatch_metric_alarm" "cpu_20" {
  alarm_name        = "asg-cpu-20"
  alarm_description = "Monitoring the 20% threshold of the average CPU utilization of the ASG"

  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  statistic           = "Average"
  threshold           = 20
  period              = 60
  evaluation_periods  = 1
  alarm_actions       = [module.webserver_asg.autoscaling_policy_arns["cpu20up"]]
  ok_actions          = [module.webserver_asg.autoscaling_policy_arns["cpu20down"]]

  dimensions = {
    AutoScalingGroupName = module.webserver_asg.autoscaling_group_name
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_30" {
  alarm_name        = "asg-cpu-30"
  alarm_description = "Monitoring the 30% threshold of the average CPU utilization of the ASG"

  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  statistic           = "Average"
  threshold           = 30
  period              = 60
  evaluation_periods  = 1
  alarm_actions       = [module.webserver_asg.autoscaling_policy_arns["cpu30up"]]
  ok_actions          = [module.webserver_asg.autoscaling_policy_arns["cpu30down"]]

  dimensions = {
    AutoScalingGroupName = module.webserver_asg.autoscaling_group_name
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_40" {
  alarm_name        = "asg-cpu-40"
  alarm_description = "Monitoring the 40% threshold of the average CPU utilization of the ASG"

  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  statistic           = "Average"
  threshold           = 40
  period              = 60
  evaluation_periods  = 1
  alarm_actions       = [module.webserver_asg.autoscaling_policy_arns["cpu40up"]]
  ok_actions          = [module.webserver_asg.autoscaling_policy_arns["cpu40down"]]

  dimensions = {
    AutoScalingGroupName = module.webserver_asg.autoscaling_group_name
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_50" {
  alarm_name        = "asg-cpu-50"
  alarm_description = "Monitoring the 50% threshold of the average CPU utilization of the ASG"

  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  statistic           = "Average"
  threshold           = 50
  period              = 60
  evaluation_periods  = 1
  alarm_actions       = [module.webserver_asg.autoscaling_policy_arns["cpu50up"]]
  ok_actions          = [module.webserver_asg.autoscaling_policy_arns["cpu50down"]]

  dimensions = {
    AutoScalingGroupName = module.webserver_asg.autoscaling_group_name
  }
}
