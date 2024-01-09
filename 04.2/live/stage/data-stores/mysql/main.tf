terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-snakano"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks-snakano"
    encrypt        = "true"
  }
}

provider "aws" {
  region = "us-east-2"
}

module "mysql" {
  source = "github.com/nshun583/terraform-modules//modules/data-stores/mysql?ref=v0.0.2"

  db_username       = var.db_username
  db_password       = var.db_password
  db_engine         = "mysql"
  allocated_storage = 10
  instance_class    = "db.t2.micro"
  db_name           = "staging_database"
}
