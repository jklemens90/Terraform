
/*
Create Role named "EC2-Active-Directory-Role" 
Create EC2 instance profile so instances can communicate with Directory Services and be added to the Directory
upon launch
Apply following permissions: #AmazonSSMManagedInstanceCore , AmazonEC2RoleforSSM to IAM Role
*/


#the below code works and all instances join AD upon applying the terraform plan

# IAM EC2 Policy with Assume Role 
 data "aws_iam_policy_document" "ec2_assume_role" {
   statement {
     actions = ["sts:AssumeRole"]
     principals {
       type        = "Service"
       identifiers = ["ec2.amazonaws.com"]
     }
   }
 }
# Create EC2 IAM Role
resource "aws_iam_role" "ec2-ad-role" {
   name                = "ec2-ad-role"
   path                = "/"
   assume_role_policy  = data.aws_iam_policy_document.ec2_assume_role.json
 }
# Create EC2 IAM Instance Profile
resource "aws_iam_instance_profile" "EC2-Active-Directory" {
  name = "EC2-Active-Directory"
  role = aws_iam_role.ec2-ad-role.name
}
# Attach Policies to Instance Role
resource "aws_iam_policy_attachment" "ec2_attach1" {
  name       = "ec2-iam-attachment"
  roles      = [aws_iam_role.ec2-ad-role.id]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
resource "aws_iam_policy_attachment" "ec2_attach2" {
  name       = "ec2-iam-attachment"
  roles      = [aws_iam_role.ec2-ad-role.id]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}





















#below is my first attempt at writing the code to join the instances to AD.


/*

resource "aws_iam_role" "EC2-Active-Directory-Role" {
  name = "EC2-Active-Directory-Role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "EC2-Active-Directory-Role"
  }
}


resource "aws_iam_instance_profile" "EC2-Active-Directory" {
  name = "EC2-Active-Directory"
  role = aws_iam_role.EC2-Active-Directory-Role.name
}



#IAM policy for AmazonSSMManagedInstanceCore
resource "aws_iam_role_policy" "AmazonSSMManagedInstanceCore" {
  name = "AmazonSSMManagedInstanceCore"
  role = aws_iam_role.EC2-Active-Directory-Role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeAssociation",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:GetDocument",
                "ssm:DescribeDocument",
                "ssm:GetManifest",
                "ssm:GetParameter",
                "ssm:GetParameters",
                "ssm:ListAssociations",
                "ssm:ListInstanceAssociations",
                "ssm:PutInventory",
                "ssm:PutComplianceItems",
                "ssm:PutConfigurePackageResult",
                "ssm:UpdateAssociationStatus",
                "ssm:UpdateInstanceAssociationStatus",
                "ssm:UpdateInstanceInformation"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2messages:AcknowledgeMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:FailMessage",
                "ec2messages:GetEndpoint",
                "ec2messages:GetMessages",
                "ec2messages:SendReply"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}


#IAM policy for AmazonSSMDirectoryServiceAccess
resource "aws_iam_role_policy" "AmazonSSMDirectoryServiceAccess" {
  name = "AmazonSSMDirectoryServiceAccess"
  role = aws_iam_role.EC2-Active-Directory-Role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ds:CreateComputer",
                "ds:DescribeDirectories"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

*/