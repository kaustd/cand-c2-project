terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

data "archive_file" "lambda-archive" {
  type = "zip"
  source_file = "greet_lambda.py"
  output_path = "greet_lambda.zip"
}

provider "aws" {
   region = "us-east-1"
   access_key = "Hidden"
   secret_key = "Hidden"
}
resource "aws_iam_role" "lambda_role" {
    name = "lambda_role"
    managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_lambda_function" "test_lambda" {
  filename = "greet_lambda.zip"
   function_name = "greet_lambda"
   handler = "greet_lambda.lambda_handler"
   source_code_hash = data.archive_file.lambda-archive.output_base64sha256
   runtime = "python3.7"
   role = aws_iam_role.lambda_role.arn
   environment {
    variables = {
      greeting = "Hello Lambda+Terraform"
    }
  }
}
