provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "winserver1" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
}