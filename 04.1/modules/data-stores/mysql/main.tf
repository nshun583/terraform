resource "aws_db_instance" "example" {
  username            = var.db_username
  password            = var.db_password
  identifier_prefix   = "terraform-up-and-running"
  engine              = var.db_engine
  allocated_storage   = var.allocated_storage
  instance_class      = var.instance_class
  skip_final_snapshot = true
  db_name             = var.db_name
}
