#created a key pair using ssh keygen and saved the public key to a directory


resource "aws_key_pair" "threetier_auth" {
  key_name   = "3tierkey"
  public_key = file("~/.ssh/3tierkey.pub")
}



