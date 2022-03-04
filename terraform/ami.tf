data "aws_ami" "amazonlinux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64*"]
  }
}

data "aws_ami" "debian" {
  owners      = ["136693071363"]
  most_recent = true
  filter {
    name   = "name"
    values = ["debian-10-amd64-*"]
  }
}
