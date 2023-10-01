resource "aws_key_pair" "us-east-kp" {
  key_name = "us-east-kp"
  public_key = file("us-east-kp.pem")
}