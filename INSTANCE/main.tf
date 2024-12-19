resource "aws_instance" "EC2-instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = var.ec2_sg_id
  subnet_id = var.ec2_subnet_id
  count = var.instance_count
  key_name = var.ec2_key_name 

  tags = {
    Name = "${var.ec2_name}"
  }

} 

