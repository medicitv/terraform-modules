
data "terraform_remote_state" "api" {
  backend = "s3"

  config = {
    bucket   = var.state_ci_bucket
    key      = "medicitv-api-develop.tfstate"
    region   = var.region
  }
}

