variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "cloud-course-prj"
}

variable "public_key"{
  default = ""
  type = string
}

variable "ami"{
  default = "ami-04902260ca3d33422"
  type = string
}

variable "instance_type"{
  type = string
  default = "t2.micro"
}

variable "numOfEC2"{
  type = number
  default = 3
}
