

locals {
  base_container_definition = jsondecode(nonsensitive(var.task_definition.container_definitions))[0]
}

locals {
  log_configuration_options = merge(
    local.base_container_definition.logConfiguration.options,
    {
      "awslogs-stream-prefix" = "cron-${var.name}"
    }
  )
}

resource "aws_ecs_task_definition" "cronjob" {
  family = "${var.task_definition.family}-cron-${var.name}"

  network_mode          = var.task_definition.network_mode
  container_definitions = jsonencode([merge(local.base_container_definition,
    {
      command = var.command,
      logConfiguration = merge(
        local.base_container_definition.logConfiguration,
        {
          options = local.log_configuration_options
        }
      ),
      #prevent buggy provider issue
      dependsOn = []
      systemControls = []  # Explicitly specify an empty array for prevent buggy provider issue
    }
  )])

  requires_compatibilities = var.task_definition.requires_compatibilities
  execution_role_arn       = var.task_definition.execution_role_arn
  task_role_arn            = var.task_definition.task_role_arn
  cpu                      = var.task_definition.cpu
  memory                   = var.task_definition.memory

  tags = merge(
    var.tags,
    {
      "Name" = "${var.task_definition.tags.Name}-cron-${var.name}"
    },
  )
}
