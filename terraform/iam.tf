resource "aws_iam_role" "ssm_role" {
  name               = "${local.prefix}-ssm-ec2"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "AssumeRolePolicyForSSM"
    }
  ]
}
EOF

  tags = {
    Name = "${local.prefix}-ssm-ec2"
  }
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "${local.prefix}-ssm-ec2"
  role = aws_iam_role.ssm_role.id
}

resource "aws_iam_policy_attachment" "ssm_managed_instance" {
  name       = "${local.prefix}-ssm-managed-instance"
  roles      = [aws_iam_role.ssm_role.id]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
