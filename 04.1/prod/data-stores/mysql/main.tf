terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-snakano"
    key    = "prod/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks-snakano"
    encrypt        = "true"
  }
}

provider "aws" {
  region = "us-east-2"
}

module "mysql" {
  source = "../../../modules/data-stores/mysql"

  db_username       = var.db_username
  db_password       = var.db_password
  db_engine         = "mysql"
  allocated_storage = 12
  instance_class    = "db.t2.micro"
  db_name           = "production_database"
}
