

variable "app" {
  type        = string
  description = "app"
}

variable "name" {
  type        = string
  description = "name"
}

variable "schedule_expression" {
  type        = string
  description = "crontab like schedule"
}

variable "command" {
  type        = list(string)
  description = "command"
}

variable "event_role_arn" {
  type        = string
  description = "event role arn"
}

variable "task_definition" {
  type        = any
  description = "base task definition"
}

variable "service" {
  type        = any
  description = "base service"
}

variable "tags" {
  type        = map(string)
  description = "a map of tag to set for module resources"
}
