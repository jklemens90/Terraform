#create a private and public subnet in us-east-1a and us-east-1b for high availability


resource "aws_subnet" "private-us-east-1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "private-us-east-1a"
  }
}


resource "aws_subnet" "private-us-east-1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "private-us-east-1b"
  }
}

resource "aws_subnet" "public-us-east-1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true 

  tags = {
    "Name" = "public-us-east-1a"
  }
}

resource "aws_subnet" "public-us-east-1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public-us-east-1b"
  }
}



#shared services subnets

resource "aws_subnet" "shared-private-us-east-1a" {
  vpc_id            = aws_vpc.shared-services.id
  cidr_block        = "172.31.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "shared=private-us-east-1a"
  }
}


resource "aws_subnet" "shared-private-us-east-1b" {
  vpc_id            = aws_vpc.shared-services.id
  cidr_block        = "172.31.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "shared-private-us-east-1b"
  }
}

resource "aws_subnet" "shared-public-us-east-1a" {
  vpc_id                  = aws_vpc.shared-services.id
  cidr_block              = "172.31.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true 

  tags = {
    "Name" = "shared-public-us-east-1a"
  }
}

resource "aws_subnet" "shared-public-us-east-1b" {
  vpc_id                  = aws_vpc.shared-services.id
  cidr_block              = "172.31.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "shared-public-us-east-1b"
  }
}


#example of subnet build out for a future region
/*
resource "aws_subnet" "shared-public-us-east-2b" {
  provider = aws.shared-services
  vpc_id                  = aws_vpc.shared-services.id
  cidr_block              = "172.31.4.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "shared-public-us-east-2b"
  }
}
*/
