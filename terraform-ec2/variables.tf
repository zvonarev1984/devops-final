variable "vpc_cidr_block" {
  default = "10.10.0.0/16"
}
variable "subnet_cidr_block" {
  default = "10.10.1.0/24"
}
variable "dst_cidr_block" {
  default = "0.0.0.0/0"
}

variable "env" {
  default = " "
}
