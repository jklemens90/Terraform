
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


/*
#shared services nat gateway

resource "aws_eip" "eip-shared" {
  provider = aws.shared-services
  vpc = true

  tags = {
    Name = "eip-shared"
  }
}

resource "aws_nat_gateway" "nat-shared" {
  provider = aws.shared-services
  allocation_id = aws_eip.eip-shared.id
  subnet_id     = aws_subnet.public-us-east-2a.id

  tags = {
    Name = "nat-shared"
  }

  depends_on = [aws_internet_gateway.igw]
}
*/