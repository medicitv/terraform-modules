variable "name" {}
variable "region" {}
variable "cpu" {
    type        = number
    default     = 256
}
variable "memory" {
    type        = number
    default     = 512
}
variable "container_image" {}
variable "container_name" {}
variable "cluster_id" {}
variable "environment" {
    type        = list(object({
        name  = string
        value  = string
    }))
}
variable "execution_role_name" {}
variable "ecs_cloudwatch_log_group_name" {}
variable "secrets" {
    type        = list(object({
        name  = string
        valueFrom  = string
    }))
}
variable "log_stream_prefix" {
    type        = string
}
variable "desired_count" {
    type        = string
    default     = 1
}
variable "subnets" {
    type        = list(string)
}
variable "security_groups" {
    type        = list(string)
}

variable "TAGS" {}