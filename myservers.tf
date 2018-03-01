provider "aws" {
  access_key = "AKIAIFGEQJI7OZYD6CJQ"
  secret_key = "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"
  region     = "us-east-1"
}

variable "countapp" {
  default = 2
}

variable "countweb" {
  default = 2
}

variable "countdb" {
  default = 1
}

resource "aws_instance" "appserver" {
  ami             = "ami-26ebbc5c"
  instance_type   = "t2.micro"
  depends_on      = ["aws_instance.dbserver"]
  key_name        = "awskeys"
  security_groups = ["default"]
  count           = "${var.countapp}"
  tags {
	Name          = "${format("appserver-%03d", ${aws_instance.appserver.count[countapp.index]} + 1)}"
  }
}

resource "aws_instance" "webserver" {
  ami             = "ami-26ebbc5c"
  instance_type   = "t2.micro"
  depends_on      = ["aws_instance.dbserver"]
  key_name        = "awskeys"
  security_groups = ["default"]
  count           = "${var.countweb}"
  tags {
	Name          = "${format("webserver-%03d", ${aws_instance.webserver.count[countweb.index]} + 1)}"
  }
}

resource "aws_instance" "dbserver" {
  ami             = "ami-26ebbc5c"
  instance_type   = "t2.micro"
  key_name        = "awskeys"
  security_groups = ["default"]
  count           = "${var.countdb}"  
  tags {
	Name          = "${format("dbserver-%03d", ${aws_instance.dbserver.count[countdb.index]} + 1)}"
  }
}
