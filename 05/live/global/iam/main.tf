terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-snakano"
    key    = "global/iam/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks-snakano"
    encrypt        = "true"
  }
}

provider "aws" {
  region = "us-east-2"
}

module "users" {
  source = "github.com/nshun583/terraform-modules//modules/landing-zones/iam-user?ref=v0.0.8"

  for_each  = toset(var.user_names)
  user_name = each.value
}

output "user_arns" {
  value       = values(module.users)[*].user_arn
  description = "The ARNs of the created IAM users"
}
