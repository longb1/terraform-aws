#ec2 instance
resource "aws_instance" "longb_ec2" {
  ami                  = "ami-0015a39e4b7c0966f"
  instance_type        = "t2.micro"
  availability_zone    = "eu-west-2a"
  key_name             = "workPC"
  iam_instance_profile = aws_iam_instance_profile.longb_ec2profile.name #assign policy for access to s3

  network_interface {
    network_interface_id = aws_network_interface.longb_ec2NIC.id
    device_index         = 0
  }

  tags = {
    Name = "longb_ec2"
  }

  user_data = file("test-script.sh")
}
