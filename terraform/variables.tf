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