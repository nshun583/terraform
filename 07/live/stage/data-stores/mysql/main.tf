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
  alias  = "primary"
}

module "mysql_primary" {
  source = "../../../../modules/data-stores/mysql"

  providers = {
    aws = aws.primary
  }

  db_name     = "prod_db"
  db_username = var.db_username
  db_password = var.db_password

  db_engine         = "mysql"
  instance_class    = "db.t2.micro"
  allocated_storage = 10
}