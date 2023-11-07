

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main"
  }
}


/*VPC for shared services such as AD, Appstream. Best practices is to also deploy shared services in a shared services
account
*/

resource "aws_vpc" "shared-services" {  
  cidr_block           = "172.31.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "shared-services"
  }
}


/*
#Establish connection between both VPCs with a transit gateway
Each VPC has an entry for a route in their route table to the other VPC. 
The transit gateway has an attachment for each VPC
The transit gateway route table has routes propagated in the table to each VPC.
*/


#A transit hub that can be used to interconnect multiple VPCs 
resource "aws_ec2_transit_gateway" "three-tier-transit" {
  amazon_side_asn = "64513"
  description     = "Used to connect VPCs"  

tags = {
    Name = "three-tier-transit"
  }


}


#VPC attachments on the transit gateway. One for each VPC

resource "aws_ec2_transit_gateway_vpc_attachment" "three-tier-attach" {
  subnet_ids         = [aws_subnet.public-us-east-1a.id, aws_subnet.public-us-east-1b.id]
  transit_gateway_id = aws_ec2_transit_gateway.three-tier-transit.id
  vpc_id             = aws_vpc.main.id

tags = {
    Name = "three-tier-attach"
  }

}



resource "aws_ec2_transit_gateway_vpc_attachment" "shared-services-attach" {
  subnet_ids         = [aws_subnet.shared-private-us-east-1a.id, aws_subnet.shared-private-us-east-1b.id] 
  transit_gateway_id = aws_ec2_transit_gateway.three-tier-transit.id
  vpc_id             = aws_vpc.shared-services.id

tags = {
    Name = "shared-services-attach"
  }

}







