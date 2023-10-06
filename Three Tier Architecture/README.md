*In Progress*

The purpose of the project is to create a three tier architecture in AWS for a MS Windows environment. Architecture should be highly available and redundant. This will be accomplished with use of load 
balancers and a failover for the SQL Server instances. 

Features-

-Active Directory will be implemented so myself or users can authenticate via RDP.

-A Lambda function (written in Python) that will automate snapshots of EBS volumes for servers on a nightly basis. This lambda function will be triggered by an EventBridge scheduler.

*What has been done so far*

2 Web and 2 App servers have been created. The Web servers were placed in the public subnet in different AZs. The App servers were placed in private subnet in different AZs.


![2023-10-06 16_16_51-Window](https://github.com/jklemens90/Terraform/assets/95970840/c7122a7b-1fe1-492c-a31a-4dfe4fdc7861)

The RDS instance running SQL server has been created, including the DB subnet groups.


![2023-10-06 16_17_50-Window RDS](https://github.com/jklemens90/Terraform/assets/95970840/e0040dc8-ff73-4f04-84d3-b48c6ea95186)
![2023-10-06 16_18_53-Window db subnet](https://github.com/jklemens90/Terraform/assets/95970840/27c1f1aa-e638-48b4-ac08-c587bec0fe75)


The network topology has been created: VPC, public subnets in multi AZ, private subnets in multi AZ, route tables, internet gateway, NAT gateway, security groups. 



![2023-10-06 16_18_20-Window topology](https://github.com/jklemens90/Terraform/assets/95970840/00997971-65d2-4b2b-bd7c-da86f6b3c3b0)





