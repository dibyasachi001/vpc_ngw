variable "ec2_key_name" {
  description = "The name of key-pair to access the instance"
  type = string
}

variable "ami_id" {
  description = "ID of machine image"
  type = string
} 
 
variable "instance_type" {
  description = "The EC2 instance type"
  type = string
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
}

variable "ec2_sg_id" {
  description = "Security group id"
  type = list(string)
}

variable "ec2_subnet_id" {
  description = "The id of subnets"
  type = string
}

variable "ec2_name" {
  description = "Instance name"
  type = string
}