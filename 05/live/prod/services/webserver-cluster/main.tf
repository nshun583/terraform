provider "aws" {
  region = "us-east-2"
}

module "webserver-cluster" {
  source = "github.com/nshun583/terraform-modules//modules/services/webserver-cluster?ref=v0.0.12"

  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "terraform-up-and-running-state-snakano"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 10

  custom_tags = {
    Owner      = "team-snakano"
    DeployedBy = "terraform"
  }
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 3
  recurrence            = "0 9 * * *" # UTC

  autoscaling_group_name = module.webserver-cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-at-night"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 2
  recurrence            = "0 17 * * *" # UTC

  autoscaling_group_name = module.webserver-cluster.asg_name
}
