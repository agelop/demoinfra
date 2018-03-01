provider "aws" {
  access_key = "AKIAIDURYYBFY3JXGQZA"
  secret_key = "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"
  region     = "sa-east-1"
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
	Name          = "${format("appserver-%03d", count.index + 1)}"
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
	Name          = "${format("webserver-%03d", count.index + 1)}"
  }
}

resource "aws_instance" "dbserver" {
  ami             = "ami-26ebbc5c"
  instance_type   = "t2.micro"
  key_name        = "awskeys"
  security_groups = ["default"]
  count           = "${var.countdb}"  
  tags {
	Name          = "${format("dbserver-%03d", count.index + 1)}"
  }
}
