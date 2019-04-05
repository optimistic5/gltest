resource "aws_security_group" "winserver" {
  name = "winserver"
  vpc_id      = "${aws_vpc.glnetwork.id}"
  description = "Winserver Security Group"
  ingress {
    from_port   = "${var.lb_target_group_port}"
    to_port     = "${var.lb_target_group_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }  
  #RDP port for administrative use
  ingress {
    from_port   = "${var.rdp_port}"
    to_port     = "${var.rdp_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.public_cidr}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.public_cidr}"]
  }
}

resource "aws_security_group" "lb_sg" {
  name = "lb_sg"
  vpc_id      = "${aws_vpc.glnetwork.id}"
  description = "LoadBalancer Security Group"
  ingress {
    from_port   = "${var.lb_listener_port}"
    to_port     = "${var.lb_listener_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.public_cidr}"]
  }  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.public_cidr}"]
  }
}