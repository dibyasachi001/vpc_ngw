# SECURITY GROUP ID
output "sg_id" {
  description = "The ID of security group"
  value = aws_security_group.SG.id
}