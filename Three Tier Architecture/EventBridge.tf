#Use event bridge scheduler to trigger the EBS Snapshot lambda function
#The target should be the lambda function and it should execute every night at 11 PM



resource "aws_scheduler_schedule" "EC2SnapshotScheduler" {
  name       = "EC2SnapshotScheduler"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }
  
  schedule_expression = "cron(00 23 * * ? *"
  schedule_expression_timezone = "America/New_York"

  target {
    arn      = aws_lambda_function.SnapshotScheduler.arn
    role_arn = aws_iam_role.Lambda-Role.arn
  }
}



