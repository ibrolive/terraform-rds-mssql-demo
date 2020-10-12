# Database Instance Cheatsheet:
provider "aws" {
  #version = "~> 2.0"
  region = var.region
}


##################################################################################
# DB instance
##################################################################################
resource "aws_db_instance" "sqlexpress" {
  allocated_storage         = 20 # gigabytes
  backup_retention_period   = 7   # in days
  db_subnet_group_name      = aws_db_subnet_group.default.name
  engine                    = "sqlserver-ex"
  engine_version            = "14.00.1000.169.v1"
  instance_class            = "db.t2.medium"
  identifier                = "sqlexpress"
  multi_az                  = false
  name                      = null
  #parameter_group_name      = "sqlexpressparamgroup1" # if you have tuned it
  #create_db_parameter_group = false #unsupported argument
  #major_engine_version      = "14.00" #unsupported argument
  timezone                  = "Central Standard Time"
  license_model             = "license-included"
  password                  = "${trimspace(file("${path.module}/secrets/postgresdb-password.txt"))}"
  port                      = 1433
  publicly_accessible       = true
  storage_encrypted         = false
  storage_type              = "gp2"
  username                  = "sqlexpress"
  vpc_security_group_ids    = ["${aws_security_group.AWS_VPC_Security_Group.id}"]
  maintenance_window        = "Mon:00:00-Mon:03:00"
  backup_window             = "03:00-06:00"
  final_snapshot_identifier = "SqlexpressDemoDBSnapshot" # Snapshot name upon DB deletion
  deletion_protection       = false # Database Deletion Protection
}
