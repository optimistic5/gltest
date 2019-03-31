resource "aws_security_group" "winserver" {
  name = "winserver"
  vpc_id      = "${aws_vpc.glnetwork.id}"
  description = "Winserver Security Group"
  ingress {
    from_port   = "${var.web_port}"
    to_port     = "${var.web_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #RDP port for administrative use
  ingress {
    from_port   = "${var.rdp_port}"
    to_port     = "${var.rdp_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #For test. DELETE IT
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}