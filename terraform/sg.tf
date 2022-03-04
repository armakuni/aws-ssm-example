# Allows SSM agent on the EC2 instances to talk to the SSM services
resource "aws_security_group" "ssm_egress" {
  vpc_id = aws_vpc.vpc.id
  egress {
    cidr_blocks = ["10.0.1.0/24"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  egress {
    cidr_blocks = ["10.0.1.0/24"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }
}

# grants VPC endpoints access to SSM agent on EC2 instances
resource "aws_security_group" "ssm_ingress" {
  vpc_id = aws_vpc.vpc.id
  ingress {
    cidr_blocks = ["10.0.1.0/24"] # the subnets that we will allow access to
    from_port   = 443             # agent listens on this port
    to_port     = 443
    protocol    = "tcp"
  }
}
