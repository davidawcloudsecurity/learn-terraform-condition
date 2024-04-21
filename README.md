# learn-terraform-condition
how to use condition in terraform

This example creates an AWS EC2 instance, and the instance will be created only if the condition is met.
```ruby
provider "aws" {
  region = "us-east-1"
}

# Define a variable for condition
variable "create_instance" {
  description = "Set to true to create an instance, false to skip"
  type        = bool
  default     = false
}

# Condition to create an EC2 instance
resource "aws_instance" "example" {
  count = var.create_instance ? 1 : 0
  
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

```
This will create the EC2 instance. If you want to skip the instance creation, run Terraform apply without the variable or with create_instance=false.
```ruby
terraform apply -var 'create_instance=true'
```
