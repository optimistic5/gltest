variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "eu-central-1"
}
variable "amis" {
  type = "map"
  default = {
    "eu-central-1" = "ami-04c3cf8dfea7d36eb"
}
}

variable "instance_type" {
  default = "t2.micro"
}

variable "tag_name" {
  default = "Windows_Server_2016"
}

######Network

variable "web_port" {
  default = "8080"
}

variable "rdp_port" {
  default = "3389"
}

variable "count" {
  default = "2"
}

variable "av_zone" {
  default =  [ "eu-central-1a", "eu-central-1b"]
}

variable "network_name" {
  default = "glnetwork"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "private_ip" {
  default = ["10.0.10.100", "10.0.20.100"]
}

variable "lb_listener_protocol" {
  default = "HTTP"
}

#CodeDeploy
variable "deployment_group_name" {
  default = "deployment_group"
}