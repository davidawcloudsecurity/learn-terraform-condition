provider "aws" {
  region = "us-east-1"
}
/*
Condition to control whether the EC2 instance should be created or not by 
changing the value of the create_instance variable.
terraform apply -var 'create_instance=true'
This will create the EC2 instance.
If you want to skip the instance creation, run Terraform apply without the variable or with create_instance=false.
*/
# Define a variable for condition
variable "create_instance" {
  description = "Set to true to create an instance, false to skip"
  type        = bool
  default     = false
}

# Condition to create an EC2 instance
resource "aws_instance" "example" {
  count = var.create_instance ? 1 : 0
  
  ami           = "ami-0fe630eb857a6ec83"
  instance_type = "t2.micro"
}

//
# Define a variable for condition
variable "create_instance-01" {
  description = "Set to true to create an instance, false to skip"
  type        = bool
  default     = false
}

# Condition to create an EC2 instance
resource "aws_instance" "example-01" {
  count         = var.create_instance-01 ? 1 : 0
  ami           = "ami-0fe630eb857a6ec83"
  instance_type = "t2.micro"
}

# Check if instance exists
data "aws_instances" "existing_instance" {
  instance_tags = {
    Name = "your-instance-name"
  }
}

output "instance_id" {
  value = length(data.aws_instances.existing_instance.ids) > 0 ? data.aws_instances.existing_instance.ids[0] : "Instance does not exist"
}
