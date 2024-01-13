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
  source = "github.com/nshun583/terraform-modules//modules/landing-zones/iam-user?ref=v0.0.4"

  count = length(var.user_names)
  user_name  = var.user_names[count.index]
}

output "user_arns" {
  value       = module.users[*].user_arn
  description = "The ARNs of the created IAM users"
}
