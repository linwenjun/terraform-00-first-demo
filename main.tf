provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "cn-northwest-1"
}

resource "aws_instance" "example" {
  ami           = "ami-a1ccd8c3"
  instance_type = "t2.micro"

  tags = {
    Name = "example"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

terraform {
  backend "s3" {
    bucket = "kubernetes-cluster-info-for-terraform"
    key    = "demo"
    region = "cn-northwest-1"
  }
}

output "ip" {
  value = "${aws_instance.example.public_ip}"
}