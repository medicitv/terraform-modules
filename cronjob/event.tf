
resource "aws_cloudwatch_event_rule" "cronjob" {
  name                = "cwr-${var.app}-cron-${var.name}"
  description         = "Fires cron job ${var.name}"
  schedule_expression = var.schedule_expression

  tags = merge(
    var.tags,
    {
      "Name" = "cwr-${var.app}-cron-${var.name}"
    },
  )
}


resource "aws_cloudwatch_event_target" "cronjob" {
  target_id = "cwt-${var.app}-cron-${var.name}"
  rule      = aws_cloudwatch_event_rule.cronjob.name
  arn       = var.service.cluster
  role_arn  = var.event_role_arn

  ecs_target {
    task_count          = 1
    task_definition_arn = aws_ecs_task_definition.cronjob.arn
    launch_type         = var.service.launch_type
    network_configuration {
      subnets         = var.service.network_configuration[0].subnets
      security_groups = var.service.network_configuration[0].security_groups
    }
  }
}
