variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true
  default     = null
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
  default     = null
}

variable "db_engine" {
  description = "the engine for the database"
  type        = string
}

variable "allocated_storage" {
  description = "storage allocation size for the database"
  type        = number
}

variable "instance_class" {
  description = "the instance selection for the database"
  type        = string
}

variable "db_name" {
  description = "the name of the database"
  type        = string
  default     = null
}

variable "backup_retention_period" {
  description = "Days to retain backups. Must be > 0 to enable replication."
  type        = number
  default     = null
}

variable "replicate_source_db" {
  description = "If specified, replicate the RDS database at the given ARN."
  type        = string
  default     = null
}
