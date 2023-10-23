*In Progress*

The purpose of the project is to create a highly available three-tier architecture in AWS for a Microsoft Windows Environment. This will be accomplished by implementing a Multi-AZ architecture, use of load balancers, and a failover for the SQL Server instances. 

-------------------------------------------------------------------------------------

Features yet to be implemented-



A Lambda function (written in Python) that will automate snapshots of EBS volumes for servers on a nightly basis. This lambda function will be triggered by an EventBridge scheduler. 



Apply SSL cert to ELB to facilitate HTTPS connections over the internet. 
    a. Change ELB to an ALB and create target group for the 2 web servers.



Add secret rotation for AD credentials stored in AWS Secrets Manager.



Finish creating shared services VPC for domain controllers. Create VPN connection between the two VPCs.


Powershell user data script to install RSAT tools on domain controllers

Powershell user data script to install Apache on Web servers. 

Powershell user data script to initialize volumes on disk drives in OS. 



Add a S3 log bucket with private access for centralized logging. Including a bucket policy to move less commonly accessed files to IA and Glacier after "X" amount of days. Implement versioning.


----------------------------------------------------------------------------


*What has been done so far*

2 Web, 2 App servers, 2 DB, and 2 Domain management servers have been created. The Web servers were placed in the public subnet in different AZs. The App servers were placed in private subnet in different AZs. DB servers have been placed in the private subnet in different AZs. Domain management servers were each placed in the private subnet in different AZs.

AMIs: Windows 2019 for the Web and App Servers. Windows 2019/SQL Server 2019 for the DB Servers

![EC2 instances](https://github.com/jklemens90/Terraform/assets/95970840/28cd2568-543c-4e58-a59c-de640a45d359)

--------------------------------------------------

Used block device mapping to specify additional EBS volumes to attach to the instances when they're launched. Added D drive for application servers. Added F, L, and G drives for database servers to facilitate SQL server. Encrypted all EBS volumes. 
 
-----------------------------------------------



Elastic Load Balancer for the Public facing web servers. 

![load balancer](https://github.com/jklemens90/Terraform/assets/95970840/7f65ac19-497d-4977-9e92-6d8c0e29e5a6)

--------------------------

Internal network load balancer for application servers.


Created AWS Microsoft AD resource and referenced AD credentials that are stored in AWS Secrets Manager.


Created IAM role, Instance profile, and SSM document so EC2 instances can be added to Active Directory upon launch. Confirmed in ethernet settings that EC2 instances were joined to the domain.
-----------------

Successfully built AppStream fleet with a custom image with RDP application which allows me to securely connect to EC2 instances through a bastion server. 


-------------------
The network topology has been created: VPC, public subnets in multi AZ, private subnets in multi AZ, route tables, internet gateway, NAT gateway, security groups. 

-----------------------------


![image](https://github.com/jklemens90/Terraform/assets/95970840/b3162c21-7815-4951-823b-fab6b570562a)






