terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"

  assume_role_policy = <<EOF
{
  "Version": "2021-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "tag-value"
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = "${aws_iam_role.ec2_role.name}"
}

resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2_policy"
  role = "${aws_iam_role.ec2_role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "ec2:*",
            "Effect": "Allow",
            "Resource": "*"
        },
		{
            "Effect": "Allow",
            "Action": [
                "cloudwatch:GetMetricStatistics",
                "ec2:DescribeAccountAttributes",
                "ec2:DescribeAvailabilityZones",
                "ec2:DescribeInstances",
                "ec2:DescribeKeyPairs",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSubnets",
                "ec2:DescribeVpcs",
                "elasticloadbalancing:DescribeInstanceHealth",
                "elasticloadbalancing:DescribeLoadBalancers",
                "iam:GetRolePolicy",
                "iam:ListInstanceProfiles",
                "iam:ListRoles",
                "iam:ListUsers",
                "opsworks:*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:PassRole"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:PassedToService": "opsworks.amazonaws.com"
                }
            }
        },
		{
            "Effect": "Allow",
            "Action": [
                "opsworks:AssignInstance",
                "opsworks:CreateLayer",
                "opsworks:DeregisterInstance",
                "opsworks:DescribeInstances",
                "opsworks:DescribeStackProvisioningParameters",
                "opsworks:DescribeStacks",
                "opsworks:UnassignInstance"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances"
            ],
            "Resource": [
                "*"
            ]
        },
		{
            "Effect": "Allow",
            "Action": [
                "opsworks:DescribeStackProvisioningParameters",
                "opsworks:DescribeStacks",
                "opsworks:RegisterInstance"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": "elasticloadbalancing:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "cloudwatch:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "autoscaling:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": [
                        "autoscaling.amazonaws.com",
                        "ec2scheduled.amazonaws.com",
                        "elasticloadbalancing.amazonaws.com",
                        "spot.amazonaws.com",
                        "spotfleet.amazonaws.com",
                        "transitgateway.amazonaws.com"
                    ]
                }
            }
        }
    ]
}
EOF
}

resource "aws_instance" "app_server" {
  count = var.numOfEC2
  ami           = var.ami
  instance_type = var.instance_type
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
  tags = {
    Name = "${var.instance_name}-${count.index}"
  }
}
