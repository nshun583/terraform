terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  allocated_storage   = var.allocated_storage
  instance_class      = var.instance_class
  skip_final_snapshot = true

  # バックアップを有効化
  backup_retention_period = var.backup_retention_period

  # 設定されている時はこのデータベースはレプリカ
  replicate_source_db = var.replicate_source_db

  # replicate_source_db が設定されていない時だけこれらのパラメータを設定
  engine  = var.replicate_source_db == null ? var.db_engine : null
  db_name = var.replicate_source_db == null ? var.db_name : null
  username = var.replicate_source_db == null ? var.db_username : null
  password = var.replicate_source_db == null ? var.db_password : null
}
