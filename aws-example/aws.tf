# This is a example of how the configuration file is written to a aws_instance resource
resource "aws_instance" "webserver" {
  ami = "ami-005fc0f236362e99f"
  instance_type = "t2.micro"
}
