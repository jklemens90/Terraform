/*
Use event bridge scheduler to trigger the EBS Snapshot lambda function
The lambda function should execute a snapshot on all EBS volumes every night at 11 PM
create the eventbridge schedule and then create an IAM Role with an assume role policy so it can execute
the actions.
*/


resource "aws_scheduler_schedule" "EC2SnapshotScheduler" {
  name       = "EC2SnapshotScheduler"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }
  
  schedule_expression = "cron(50 10 * * ? *)"
  schedule_expression_timezone = "America/New_York"

  target {
    arn      = aws_lambda_function.SnapshotScheduler.arn
    role_arn = aws_iam_role.EventBridgeRole.arn
  }
}



data "aws_iam_policy_document" "EventBridge-Assume-Role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["scheduler.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "EventBridgeRole" {
  name               = "EventBridgeRole"
  assume_role_policy = data.aws_iam_policy_document.EventBridge-Assume-Role.json
}