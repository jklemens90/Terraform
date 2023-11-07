#create an internet gateway and attach it to the VPC so it can connect to the public internet

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
  }
}



#shared internet gateway

resource "aws_internet_gateway" "shared-igw" {
  vpc_id = aws_vpc.shared-services.id

  tags = {
    Name = "shared-igw"
  }
}

