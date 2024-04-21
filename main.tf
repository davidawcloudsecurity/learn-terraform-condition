provider "aws" {
  region = "us-east-1"
}

variable "your_existing_vpc_id" {
  description = "The vpc id the instance will be created (e.g., vpc-086340xxxxxxxxxxx)"
  type        = string
  default     = "vpc-086340a0c95fe4d4b"
}

variable "your_existing_subnet_id" {
  description = "Specifies the main CIDR block."
  type        = string
  default     = "subnet-0d3db2de738b69acc"
}

variable "your_existing_security_group" {
  description = "Specifies the exisiting security group"
  type        = string
  default     = "sg-0e7a8e0647f5e91e3"
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
  default     = true
}

# Condition to create an EC2 instance
resource "aws_instance" "example" {
  count = var.create_instance ? 1 : 0
  ami           = "ami-0fe630eb857a6ec83"  
  instance_type = "t2.micro"
  vpc_security_group_ids      = [var.your_existing_security_group] # Use the ID of the existing security group

  # Associate the instance with the default VPC
  subnet_id                   = var.your_existing_subnet_id
}

//
# Define a variable for condition
variable "create_instance-01" {
  description = "Set to true to create an instance, false to skip"
  type        = bool
  default     = false
}

variable "instance_id" {
  description = "The ID of the instance to check"
  type        = string
}

# Condition to create an EC2 instance
resource "aws_instance" "example-01" {
  count         = var.create_instance-01 ? 1 : 0
  ami           = "ami-0fe630eb857a6ec83"
  instance_type = "t2.micro"
  vpc_security_group_ids      = [var.your_existing_security_group] # Use the ID of the existing security group

  # Associate the instance with the default VPC
  subnet_id                   = var.your_existing_subnet_id
}

# Check if instance exists
data "aws_instances" "existing_instances" {
  filter {
    name   = var.instance_id
    values = ["i-0bacd75918bbeed04"]
  }
}

output "instance_id" {
  value = length(data.aws_instances.existing_instances.ids) > 0
}
output "data_aws_instances_existing_instance_ids" {
  value = data.aws_instances.existing_instance.id
}
