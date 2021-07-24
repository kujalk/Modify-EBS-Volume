resource "aws_ebs_volume" "vol1" {
  availability_zone = "ap-southeast-1a"
  size              = 1
  type              = "gp2"

  tags = {
    Name = "TestVol-1"
  }
}

resource "aws_ebs_volume" "vol2" {
  availability_zone = "ap-southeast-1b"
  size              = 1
  type              = "gp2"

  tags = {
    Name = "TestVol-2"
  }
}

resource "aws_ebs_volume" "vol3" {
  availability_zone = "ap-southeast-1c"
  size              = 1
  type              = "gp3"

  tags = {
    Name = "TestVol-3"
  }
}

resource "aws_ebs_volume" "vol4" {
  availability_zone = "ap-southeast-1b"
  size              = 1
  type              = "gp2"

  tags = {
    Name = "TestVol-4"
  }
}

#Security Group
resource "aws_security_group" "main" {
  name        = "Demo-Security-Group-EC2-Volume-Check"
  description = "To allow HTTP and SSH Traffic"

  tags = {
    Name = "Demo-Security-Group-EC2-Volume-Check"
  }

  ingress {
    description = "SSH Traffic Allow"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outside"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#EC2 instance creation
resource "aws_instance" "Prod" {
  ami                  = "ami-015a6758451df3cb9"
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  key_name             = "aws_connect"
  #vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name = "Volume-Test-EC2"
  }
}

//For EC2
resource "aws_iam_role" "ec2-demo" {
  name = "DemoEC2_Artifact"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2-policy-attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = aws_iam_role.ec2-demo.name
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_demo_profile"
  role = aws_iam_role.ec2-demo.name
}

output "ec2-ip"{
    value = aws_instance.Prod.public_ip
}