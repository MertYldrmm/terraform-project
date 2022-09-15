resource "aws_lambda_function" "get-request-time-function" {
    function_name = "get-request-date"
    description = "Get Request Date"
    handler = "getRequestTime.handler"
    runtime = "nodejs14.x"
    memory_size = 128
    timeout = 5
    role = aws_iam_role.lambda-time-role.arn
    s3_bucket = aws_s3_bucket.get-request-time-function.id
    s3_key = aws_s3_bucket_object.request-time-v1.key
}

resource "aws_iam_role" "lambda-time-role" {
    name = "lambda-time-role"
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