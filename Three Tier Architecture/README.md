*In Progress*

The purpose of the project is to create a three tier architecture in AWS for a Microsoft Windows Environment. Architecture should be highly available and redundant. This will be accomplished with use of load balancers and a failover for the SQL Server instances. 

Features-

-Active Directory will be implemented so I can authenticate via RDP. (in progress)


-A Lambda function (written in Python) that will automate snapshots of EBS volumes for servers on a nightly basis. This lambda function will be triggered by an EventBridge scheduler. (in progress)


*What has been done so far*

2 Web, 2 App servers, and 2 DB have been created. The Web servers were placed in the public subnet in different AZs. The App servers were placed in private subnet in different AZs. DB servers have been placed in the private subnet in different AZs. 

AMIs: Windows 2019 for the Web and App Servers
      Windows 2019/SQL Server 2019 for the DB Servers

![EC2 instances](https://github.com/jklemens90/Terraform/assets/95970840/28cd2568-543c-4e58-a59c-de640a45d359)




The network topology has been created: VPC, public subnets in multi AZ, private subnets in multi AZ, route tables, internet gateway, NAT gateway, security groups. 


![2023-10-06 16_18_20-Window topology](https://github.com/jklemens90/Terraform/assets/95970840/00997971-65d2-4b2b-bd7c-da86f6b3c3b0)





