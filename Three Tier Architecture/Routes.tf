
#private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.nat.id
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      gateway_id                 = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    },
  ]

  tags = {
    Name = "private"
  }
}


resource "aws_route_table_association" "three-private_assoc-1a" {
  subnet_id      = aws_subnet.private-us-east-1a.id
  route_table_id = aws_route_table.private.id
}


resource "aws_route_table_association" "three-private_assoc-1b" {
  subnet_id      = aws_subnet.private-us-east-1b.id
  route_table_id = aws_route_table.private.id
}




#public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.igw.id
      nat_gateway_id             = ""
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    },
  ]

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "three-public_assoc-1a" {
  subnet_id      = aws_subnet.public-us-east-1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "three-public_assoc-1b" {
  subnet_id      = aws_subnet.public-us-east-1b.id
  route_table_id = aws_route_table.public.id
}


/*
#shared services

#private route table
resource "aws_route_table" "private-shared" {
  vpc_id = aws_vpc.shared-services.id
  provider = aws.shared-services

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.nat-shared.id
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      gateway_id                 = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    },
  ]

  tags = {
    Name = "private-shared"
  }
}


resource "aws_route_table_association" "shared-private_assoc-2a" {
  provider = aws.shared-services
  subnet_id      = aws_subnet.private-us-east-2a.id
  route_table_id = aws_route_table.private-shared.id
}


resource "aws_route_table_association" "shared-private_assoc-2b" {
  provider = aws.shared-services
  subnet_id      = aws_subnet.private-us-east-2b.id
  route_table_id = aws_route_table.private-shared.id
}


#shared public
resource "aws_route_table" "shared-public" {
  vpc_id = aws_vpc.shared-services.id
  provider = aws.shared-services

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.shared-igw.id
      nat_gateway_id             = ""
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    },
  ]

  tags = {
    Name = "shared-public"
  }
}

resource "aws_route_table_association" "shared-public_assoc-2a" {
  provider = aws.shared-services
  subnet_id      = aws_subnet.public-us-east-2a.id
  route_table_id = aws_route_table.shared-public.id
}

resource "aws_route_table_association" "shared-public_assoc-2b" {
  provider = aws.shared-services
  subnet_id      = aws_subnet.public-us-east-2b.id
  route_table_id = aws_route_table.shared-public.id
}

*/