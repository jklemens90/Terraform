#Use Secrets Manager to store AD credentials securely




data "aws_secretsmanager_secret_version" "ad-creds2" {
  # Fill in the name you gave to your secret
  secret_id = "ad-creds2"
}

#Use jsondecode to parse in the secret
locals {
  ad-creds2 = jsondecode(
    data.aws_secretsmanager_secret_version.ad-creds2.secret_string
  )
}



/*add a resource block to rotate ad-creds2 credentials

resource "aws_secretsmanager_secret_rotation" "ad-creds2-rotation" {
  secret_id           = aws_secretsmanager_secret.ad-creds2.id
  rotation_lambda_arn = aws_lambda_function.example.arn

  rotation_rules {
    automatically_after_days = 30
  }
}

*/