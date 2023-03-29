output "rds_asg_id" {
  value = aws_security_group.RDS_allow_rule.id
}

output "ec2_asg_id" {
  value = aws_security_group.ec2_allow_rule.id
}