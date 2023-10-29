

data "aws_iam_policy_document" "lambda-assume-role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "Lambda-Role" {
  name               = "Lambda-Role"
  assume_role_policy = data.aws_iam_policy_document.lambda-assume-role.json
}

#IAM policies so Lambda can execute the function on the EC2 instances
resource "aws_iam_policy_attachment" "lambda_attach1" {
  name       = "lambda_attach1"
  roles      = [aws_iam_role.Lambda-Role.id]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
resource "aws_iam_policy_attachment" "lambda_attach2" {
  name       = "lambda_attach2"
  roles      = [aws_iam_role.Lambda-Role.id]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}



data "archive_file" "lambda" {
  type        = "zip"
  source_file = "SnapshotScheduler/SnapshotSchedulerFunction.py"
  output_path = "SnapshotScheduler/snapshot_lambda_function_payload.zip"
}

resource "aws_lambda_function" "SnapshotScheduler" {  
  filename      = "SnapshotScheduler/snapshot_lambda_function_payload.zip"
  function_name = "SnapshotScheduler"
  role          = aws_iam_role.Lambda-Role.arn
  handler       = "SnapshotSchedulerFunction.py"  

    runtime = "python3.9"
}
  
    
#logging


resource "aws_cloudwatch_log_group" "Lambda-CloudWatch-Log" {
  name              = "/aws/lambda/${var.SnapshotScheduler}"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_stream" "SnapshotScheduler" {
  name           = "SnapshotScheduler"
  log_group_name = aws_cloudwatch_log_group.Lambda-CloudWatch-Log.name
}



