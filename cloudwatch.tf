##Cloudwatch ALB
resource "aws_cloudwatch_metric_alarm" "cwa_alb_unhealthyhostcount" {
  alarm_name          = "${aws_lb.alb.name}-UnHealthyHostCount"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  statistic           = "Average"
  period              = 300
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  treat_missing_data  = "missing"
  actions_enabled     = var.cwa_actions
  alarm_actions       = [aws_sns_topic.sns_topic.arn]
  ok_actions          = [aws_sns_topic.sns_topic.arn]
  dimensions = {
    TargetGroup  = aws_lb_target_group.tg.arn_suffix
    LoadBalancer = aws_lb.alb.arn_suffix
  }
}

##Cloudwatch RDS
resource "aws_cloudwatch_metric_alarm" "cwa_rds_cpuutilization" {
  alarm_name          = "${aws_db_instance.rds_db_instance.identifier}-CPUUtilization"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  statistic           = "Average"
  period              = 300
  threshold           = 80
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  treat_missing_data  = "missing"
  actions_enabled     = var.cwa_actions
  alarm_actions       = [aws_sns_topic.sns_topic.arn]
  ok_actions          = [aws_sns_topic.sns_topic.arn]
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.rds_db_instance.identifier
  }
}

resource "aws_cloudwatch_metric_alarm" "cwa_rds_freeablememory" {
  alarm_name          = "${aws_db_instance.rds_db_instance.identifier}-FreeableMemory"
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  statistic           = "Average"
  period              = 300
  threshold           = var.cwa_threshold_rds_freeablememory
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  treat_missing_data  = "missing"
  actions_enabled     = var.cwa_actions
  alarm_actions       = [aws_sns_topic.sns_topic.arn]
  ok_actions          = [aws_sns_topic.sns_topic.arn]
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.rds_db_instance.identifier
  }
}

resource "aws_cloudwatch_metric_alarm" "cwa_rds_freeablestorage" {
  alarm_name          = "${aws_db_instance.rds_db_instance.identifier}-FreeableStorage"
  metric_name         = "FreeableStorage"
  namespace           = "AWS/RDS"
  statistic           = "Average"
  period              = 300
  threshold           = var.cwa_threshold_rds_freeablestorage
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  treat_missing_data  = "missing"
  actions_enabled     = var.cwa_actions
  alarm_actions       = [aws_sns_topic.sns_topic.arn]
  ok_actions          = [aws_sns_topic.sns_topic.arn]
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.rds_db_instance.identifier
  }
}