resource "aws_db_subnet_group" "db_postgres" {
  name       = "db-postgres"
  subnet_ids = local.private_subnets
}

resource "aws_db_instance" "postgres" {
  identifier             = "app-db"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "15"
  username               = var.db_user
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_postgres.name
  vpc_security_group_ids = [module.sg_rds_postgres.security_group_id]
  skip_final_snapshot    = true
  db_name                = var.db_name
}
