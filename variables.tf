variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "cloud-course-prj"
}

variable "ami"{
  default = "ami-0b0af3577fe5e3532"
  type = string
}

variable "instance_type"{
  type = string
  default = "t2.micro"
}
