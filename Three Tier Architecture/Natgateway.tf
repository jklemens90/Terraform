
#eip is the elastic IP. 

resource "aws_eip" "nat" {
  vpc = "true"

  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-us-east-1a.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.igw]
}



#shared services nat gateway

resource "aws_eip" "eip-shared" {
  vpc = true

  tags = {
    Name = "eip-shared"
  }
}

resource "aws_nat_gateway" "nat-shared" {
  allocation_id = aws_eip.eip-shared.id
  subnet_id     = aws_subnet.shared-public-us-east-1a.id

  tags = {
    Name = "nat-shared"
  }

  depends_on = [aws_internet_gateway.shared-igw]
}
