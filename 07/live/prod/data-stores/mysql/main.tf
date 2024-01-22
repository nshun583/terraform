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

provider "aws" {
  region = "us-west-1"
  alias  = "replica"
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

  # レプリケーションをサポートするため有効にする必要あり
  backup_retention_period = 1
}

module "mysql_replica" {
  source = "../../../../modules/data-stores/mysql"

  providers = {
    aws = aws.replica
  }

  db_engine         = "mysql"
  instance_class    = "db.t2.micro"
  allocated_storage = 10

  # プライマリのレプリカとして設定
  replicate_source_db = module.mysql_primary.arn
}