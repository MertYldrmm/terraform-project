resource "aws_s3_bucket" "get-request-time-function" {
    bucket = "get-request-time-function"
}

resource "aws_s3_bucket_object" "request-time-v1" {
    bucket = aws_s3_bucket.get-request-time-function.id
    key = "1.0.0"
    source = "lambda.zip"
}
