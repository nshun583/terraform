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

  user_names = var.user_names
  give_neo_cloudwatch_full_access = false
}
