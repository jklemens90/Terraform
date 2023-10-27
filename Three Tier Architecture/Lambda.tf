


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

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "SnapshotSchedulerFunction.py"
  output_path = "snapshot_lambda_function_payload.zip"
}

resource "aws_lambda_function" "SnapshotScheduler" {  
  filename      = "snapshot_lambda_function_payload.zip"
  function_name = "SnapshotScheduler"
  role          = aws_iam_role.Lambda-Role.arn
  handler       = "SnapshotScheduler"  

    runtime = "python3.9"
}
  
    

