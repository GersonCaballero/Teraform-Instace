provider "aws" {
 region = "us-east-1"
 access_key = "${var.acceskey}"
 secret_key = "${var.secretkey}"
}

resource "aws_instance" "web" {
 ami  = "ami-04b9e92b5572fa0d1"
 instance_type = "t2.micro"
 key_name = "${var.llavename}"
 security_groups = ["${aws_security_group.allow_tls.name}"]

 tags = {
  Name = "Trabajo clase convariables"
 }
}

resource "aws_default_vpc" "default"{
 tags = {
  Name = "Default VPC"
 }
}

resource "aws_security_group" "allow_tls"{
 name = "security_group_trabajo_clase_convariables"
 description = "security_group_ssh_trabajo_clase_convariables"
 vpc_id = "${aws_default_vpc.default.id}"

 ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }

 egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "${var.dbname}"
  username             = "${var.usernamedb}"
  password             = "${var.passworddb}"
  parameter_group_name = "default.mysql5.7"
  identifier 	       = "${var.identifierdb}"
  final_snapshot_identifier ="gerson"
}
