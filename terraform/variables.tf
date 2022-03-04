variable "aws_region" {
  default = "eu-west-1"
}

variable "owner" {
  default = "armakuni"
}

variable "environment" {
  default = "testing"
}

variable "ami_id" {
  default = "ami-080af029940804103" # amazonlinux
}

locals {
  prefix = var.owner
  ami_id = var.ami_id
  # ubuntu_ami_id = "ami-0258eeb71ddf238b3"
  ubuntu_ami_id = "ami-0874dad5025ca362c"
}
