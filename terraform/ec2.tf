resource "aws_instance" "private_box" {
  instance_type          = "t3.micro"
  ami                    = data.aws_ami.amazonlinux.id
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.ssm_egress.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.id

  tags = {
    Name = "${local.prefix}-box"
  }
}

resource "aws_instance" "unmanaged_box" {
  instance_type          = "t3.micro"
  ami                    = data.aws_ami.debian.id
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.ssm_egress.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.id

  user_data = file("static/install-ssm-agent-dpkg.sh")

  tags = {
    Name = "${local.prefix}-unmanaged-box"
  }
}

