#create 2 RDS instances using SQL Server 2019 AMI. Place them in different AZ within a private subnet. Have the
#ability to failover.

#attach EBS volumes for C drive, F drive, G drive, L drive for both instances. Drive sizes should match on both DB 
#instances 

#C drive= 80, F drive= 200, L drive= 50, G drive= 40


 
  
# create the rds instance
resource "aws_db_instance" "db_instance" {
  engine                  = "sqlserver-ex"
  engine_version          = "15.00"
  multi_az                = false
  identifier              = "rds-three-tier" 
  username                = "John"
  password                = "test3929"
  port                    = 1433
  instance_class          = "db.t3.large"
  allocated_storage       = 200
  db_subnet_group_name    = aws_db_subnet_group.database_subnet_group.name 
  vpc_security_group_ids  = [aws_security_group.DB_sg.id]
  
        

  skip_final_snapshot     = true
}

# create a second rds instance in another AZ within a private subnet 