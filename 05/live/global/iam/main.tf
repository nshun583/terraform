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
  source = "github.com/nshun583/terraform-modules//modules/landing-zones/iam-user"

  for_each  = toset(var.user_names)
  user_name = each.value
}

output "user_arns" {
  value       = values(module.users)[*].user_arn
  description = "The ARNs of the created IAM users"
}

output "upper_names" {
  value = [for name in var.user_names : upper(name)]
}

output "short_upper_names" {
  value = [for name in var.user_names : upper(name) if length(name) < 5]
}

output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}

output "upper_roles" {
  value = {for name, role in var.hero_thousand_faces : upper(name) => upper(role)}
}

output "for_directive" {
  value = "%{ for name in var.user_names }${name}, %{ endfor }"
}

output "for_directive_index" {
  value = "%{ for i, name in var.user_names }(${i}) ${name}, %{ endfor }"
}