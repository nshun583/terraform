terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-snakano"
    key    = "stage/services/webserver-cluster/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks-snakano"
    encrypt        = "true"
  }
}

provider "aws" {
  region = "us-east-2"
}

module "webserver-cluster" {
  source = "github.com/nshun583/terraform-modules//modules/services/webserver-cluster"

  ami = "ami-0fb653ca2d3203ac1"
  server_text = "New server text"

  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "terraform-up-and-running-state-snakano"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 2
  enable_autoscaling = false

  custom_tags = {
    Owner      = "team-snakano"
    DeployedBy = "terraform"
  }
}
