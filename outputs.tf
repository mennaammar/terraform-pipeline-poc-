
output "t2_instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2_with_t2.id[0]
}


output "credit_specification_t2_unlimited" {
  description = "Credit specification of t2-type EC2 instance"
  value       = module.ec2_with_t2.credit_specification
}
