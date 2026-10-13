resource "aws_instance" "preproduction" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.preproduction.id
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  associate_public_ip_address = false

  credit_specification {
    cpu_credits = "standard"
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size_gb
    delete_on_termination = true
    encrypted             = true
  }

  tags = {
    Name        = "ec2-github-oidc-preproduction"
    Environment = "preproduction"
    Project     = "project1_pre"
  }
}
