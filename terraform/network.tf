resource "aws_vpc" "glnetwork" {
  cidr_block = "${var.vpc_cidr}"

  tags = {
    Name = "${var.network_name}"
  }
}

resource "aws_subnet" "glnetwork_subnet" {
  count             = "${var.count}" 
  vpc_id            = "${aws_vpc.glnetwork.id}"
   cidr_block        = "${element(var.subnet_cidr, count.index)}"
   availability_zone = "${element(var.av_zone, count.index)}"

  tags = {
    Name = "${var.network_name}-${count.index +1}"
  }
}