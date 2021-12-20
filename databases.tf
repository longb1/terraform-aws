# RDS creation
resource "aws_db_instance" "longb_db" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "8.0.23"
  instance_class         = "db.t2.micro"
  name                   = "longb_db"
  username               = "foo"
  password               = "foobarbaz"
  skip_final_snapshot    = true
  db_subnet_group_name   = "longb_subnet_grp"
  vpc_security_group_ids = [aws_security_group.longb_VPC_SG.id]
}