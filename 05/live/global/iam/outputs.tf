output "first_arn" {
  value       = module.users.first_arn
  description = "The ARN for the first user"
}

output "all_arns" {
  value       = module.users.all_arns
  description = "The ARNs for all users"
}

output "neo_cloudwatch_policy_arn_ternary" {
  value = module.users.neo_cloudwatch_policy_arn_ternary
}

output "neo_cloudwatch_policy_arn" {
  value = module.users.neo_cloudwatch_policy_arn
}
