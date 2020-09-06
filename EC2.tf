data "aws_availability_zones" "available" {}
data "aws_ami" "latest_version" {  # Use latest version Ubuntu 18.04
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}
resource "aws_instance" "server" {
  key_name               = "EC2"
  ami                    = data.aws_ami.latest_version.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.server.id]
  user_data              = file("Autoinstalling Docker.sh") # User data from autoinstalling Docker
  tags = merge(var.main_tags, {
    Name = "Server for ${var.main_tags["Environment"]}"
  })

}
