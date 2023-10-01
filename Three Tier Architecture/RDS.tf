#create 2 RDS instances using SQL Server 2019 AMI. Place them in the private subnet

#attach EBS volumes for C drive, F drive, G drive, L drive for both instances. Drive sizes should match on both DB 
#instances 

#C drive= 80, F drive= 200, L drive= 50, G drive= 40




module "db" {
  source = "../../"

  identifier = Database_Server1

  engine               = "sqlserver-ex"
  engine_version       = "15.00"
  family               = "sqlserver-ex-15.0" # DB parameter group
  major_engine_version = "15.00"             # DB option group
  instance_class       = "db.t3.large"

  allocated_storage     = 200  
  
  # Encryption at rest is not available for DB instances running SQL Server Express Edition
  storage_encrypted = false

  username = "John"
  port     = 1433

  domain               = aws_directory_service_directory.demo.id
  domain_iam_role_name = aws_iam_role.rds_ad_auth.name

  multi_az               = false
  db_subnet_group_name   = module.vpc.database_subnet_group
  vpc_security_group_ids = [module.security_group.DB_sg]

  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = false


  options                   = []
  create_db_parameter_group = false
  license_model             = "license-included"
  timezone                  = "GMT Standard Time"
  character_set_name        = "Latin1_General_CI_AS"

  tags = {
    Name = "Database_Server1" 
  }
}





module "db" { 
  source = "../../"

  identifier = Database_Server2

  engine               = "sqlserver-ex"
  engine_version       = "15.00"
  family               = "sqlserver-ex-15.0" # DB parameter group
  major_engine_version = "15.00"             # DB option group
  instance_class       = "db.t3.large"

  allocated_storage     = 200
  

  # Encryption at rest is not available for DB instances running SQL Server Express Edition
  storage_encrypted = false 

  username = "John"
  port     = 1433

  domain               = aws_directory_service_directory.demo.id
  domain_iam_role_name = aws_iam_role.rds_ad_auth.name

  multi_az               = false
  db_subnet_group_name   = module.vpc.database_subnet_group
  vpc_security_group_ids = [module.security_group.DB_sg]

  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = false 


  options                   = []
  create_db_parameter_group = false
  license_model             = "license-included"
  timezone                  = "GMT Standard Time"
  character_set_name        = "Latin1_General_CI_AS"

  tags = {
    Name = "Database_Server2" 
  }
}




  