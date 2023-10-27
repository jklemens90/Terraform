


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


resource "aws_lambda_function" "SnapshotScheduler" {  
  filename      = "SnapshotScheduler.zip"
  function_name = "SnapshotScheduler"
  role          = aws_iam_role.Lambda-Role.arn
  handler       = "SnapshotSchedulerFunction.py"  

    runtime = "python3.9"
}
  
    

