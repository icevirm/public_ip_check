resource "aws_instance" "no_public_ip_instance" {
  ami           = "${data.aws_ami.amazon2.id}"
  instance_type = "t2.micro"

  associate_public_ip_address = false

  tags = {
    Name = "No public IP"
  }
}
