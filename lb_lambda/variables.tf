variable "name" {}
variable "function_name" {
    type = string
    default = ""
}
variable "description" {}
variable "package_path" {
    type = string
    default = ""
}
variable "package_type" {
    type = string
    default = "Zip"
}
variable "handler" {}
variable "attach_policy_json" {
    type = bool
    default = true
}
variable "policy_document" {
    type = string
    default = null
}
variable "runtime" {
    type = string
    default = "python3.12"
}
variable "memory_size" {
    type        = number
    default     = 2048
}
variable "timeout" {
    type        = number
    default     = 600
}
variable "image_uri" {
    type = string
    default = null
}
variable "reserved_concurrent_executions" {
    type        = number
    default     = -1
}
variable "layers" {
    type        = list(string)
    default     = []
}
variable "environment_variables" {
    type        = map(string)
}
variable "vpc_security_group_ids" {
    type        = list(string)
}
variable "vpc_subnet_ids" {}
variable "ignore_source_code_hash" {
    type = bool
    default = false
}
variable "cloudwatch_log_group_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in log group for Lambda."
  type        = number
  default     = 0
}
variable "cloudwatch_log_group_tags" {
  description = "Additional tags for the Cloudwatch log group"
  type        = map(string)
  default     = {}
}
variable "TAGS" {
    type        = map(string)
}

variable "lb_listener_arn" {}
variable "lb_listener_priority" {}
variable "lb_listener_path_pattern" {
    type        = list(string)
}
variable "lb_listener_host_header" {
    type        = list(string)
}
