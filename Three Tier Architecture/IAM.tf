
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
























