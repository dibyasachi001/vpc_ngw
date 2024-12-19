# SECURITY GROUP
variable "sg_name" {
  description = "Security group tags"
  type = string
}

variable "vpc_id" {
  description = "ID of vpc"
  type = string
}

variable "ingress_port" {
  description = "Ingress port values"
  type = list(number)
}