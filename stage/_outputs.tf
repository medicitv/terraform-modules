
output "tagging" {
  value = {
    "ApiDomain"   = var.domain
    "ApiVersion"  = var.app
    "ApiVariable" = var.variable
    "ApiDefault"  = var.default
  }
}

output "rest_execution_arn" {
  value = data.terraform_remote_state.api.outputs.rest_execution_arn
}