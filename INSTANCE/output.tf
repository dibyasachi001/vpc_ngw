# output "instance_id" {
#   description = "The ID of the instances"
#   value = aws_instance.EC2-instance[*].id
# } 

output "instance_pubip" {
  description = "Public ip of instances"
  value = aws_instance.EC2-instance[*].public_ip
}

output "instance_pvtip" {
  description = "Private ip of instances"
  value = aws_instance.EC2-instance[*].private_dns
}

