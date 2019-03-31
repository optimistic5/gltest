provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "winserver" {
  count           = "${var.count}"
  vpc_security_group_ids = ["${aws_security_group.winserver.id}"]
  subnet_id       = "${element(aws_subnet.glnetwork_subnet.*.id, count.index)}"
  ami             = "${lookup(var.amis, var.region)}"
  instance_type   = "${var.instance_type}"
  key_name        = "bogdana-Frankfurt"  
  #user_data = "${file("xxx")}"
  tags = {
    Name = "${var.tag_name}-${count.index + 1}"
  }
}

