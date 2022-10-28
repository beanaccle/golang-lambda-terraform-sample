terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda"

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

locals {
  function_name = "my_lambda_function"
}

resource "aws_lambda_function" "lambda_function" {
  function_name = local.function_name
  handler       = "main"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "go1.x"

  filename         = data.archive_file.lambda_source.output_path
  source_code_hash = data.archive_file.lambda_source.output_base64sha256

  environment {
    variables = {
      foo = "bar"
    }
  }
}

data "archive_file" "lambda_source" {
  type        = "zip"
  source_dir  = "../lambda/app"
  output_path = "../lambda/function.zip"
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name = "/aws/lambda/${local.function_name}"
}
