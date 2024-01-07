provider "aws" {
    region = "us_east-2"
}

resource "aws_instance" "example" {
    ami = "ami-0fb653ca2d3203acl"
    instance_type = "t2.micro"
}