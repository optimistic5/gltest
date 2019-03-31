resource "aws_lb_target_group" "app" {
  name     = "app"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.glnetwork.id}"
}

resource "aws_lb_target_group_attachment" "winservers" {
  count            = "${var.count}" 
  target_group_arn = "${aws_lb_target_group.app.arn}"
  target_id        = "${element(split(",", join(",", aws_instance.winserver.*.id)), count.index)}"
  port             = 80
}

resource "aws_lb" "applb" {
  name               = "applb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.winserver.id}"]
  subnets            = ["${aws_subnet.glnetwork_subnet.*.id}"]

  tags = {
    Name = "applb"
  }
}

resource "aws_lb_listener" "lb_listener" {  
  load_balancer_arn = "${aws_lb.applb.arn}"  
  port              = "80"  
  protocol          = "${var.lb_listener_protocol}"
  
  default_action {    
    target_group_arn = "${aws_lb_target_group.app.arn}"
    type             = "forward"  
  }
}

output "lb-dns-name" {
  value = "${aws_lb.applb.dns_name}"
}