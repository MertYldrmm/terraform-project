resource "aws_apigatewayv2_api" "get-request-time-api" {
    name = "get-request-date-api"
    protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "get-request-date-stage" {
    name = "$default"
    api_id = aws_apigatewayv2_api.get-request-time-api.id
    auto_deploy = true
}

resource "aws_apigatewayv2_integration" "get-request-date-integration" {
    api_id = aws_apigatewayv2_api.get-request-time-api.id
    integration_type = "AWS_PROXY"
    integration_method = "POST"
    integration_uri = aws_lambda_function.get-request-time-function.invoke_arn
    passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "get-request-date-route" {
    api_id = aws_apigatewayv2_api.get-request-time-api.id
    route_key = "GET /{proxy+}"
    target = "integrations/${aws_apigatewayv2_integration.get-request-date-integration.id}"
}

resource "aws_lambda_permission" "api-gateway-lambda-permission" {
    statement_id = "AllowExecutionFromApiGateway"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.get-request-time-function.arn
    principal = "apigateway.amazonaws.com"
    source_arn = "${aws_apigatewayv2_api.get-request-time-api.execution_arn}/*/*/*"  
}