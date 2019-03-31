resource "aws_vpc" "glnetwork" {
  cidr_block = "${var.vpc_cidr}"

  tags = {
    Name = "${var.network_name}"
  }
}

resource "aws_subnet" "glnetwork_subnet" {
  count                   = "${length(var.subnet_cidr)}" 
  vpc_id                  = "${aws_vpc.glnetwork.id}"
  cidr_block              = "${element(var.subnet_cidr, count.index)}"
  availability_zone       = "${element(var.av_zone, count.index)}"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.network_name}-${count.index +1}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.glnetwork.id}"

  tags = {
    Name = "${var.network_name}-gw"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id       = "${aws_vpc.glnetwork.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  tags = {
    Name = "route_table"
  }
}

resource "aws_route_table_association" "rt_a" {
  count          = "${length(var.subnet_cidr)}"
  subnet_id      = "${element(aws_subnet.glnetwork_subnet.*.id,count.index)}"
  route_table_id = "${aws_route_table.route_table.id}"
}

