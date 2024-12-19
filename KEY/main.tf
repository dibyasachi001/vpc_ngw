resource "aws_key_pair" "EC2_keypair" {
  key_name   = var.ec2_key_name
  public_key = var.publickey

  provisioner "local-exec" {
    command = "echo 'Key Pair Created: ${self.key_name}'"
  } 

}  