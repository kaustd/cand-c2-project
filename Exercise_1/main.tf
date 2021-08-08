# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
access_key = "AKIAXCZPJJJF3HOGOS5O"
secret_key = "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"
region = "us-east-1"
}


# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2

resource "aws_instance" "Udacity_T2" {
  count = "4"
  ami = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  tags = {
    name = "Udacity T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity_M4" {
  count = "2"
  ami = "ami-0c94855ba95c71c99"
  instance_type = "m4.large"
  tags = {
    name = "Udacity M4"
  }
}