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

How to filter base on instance id
```ruby
# Ask from user
variable "instance_id" {
  description = "The ID of the instance to check"
  type        = string
}

# Check if instance exists
data "aws_instances" "existing_instances" {
  filter {
    name   = "instance-id"
    values = [var.instance_id]
  }
}

output "instance_id" {
  value = length(data.aws_instances.existing_instances.ids) > 0
}

#This will output a json value of the var.instance_id in data.aws_instances.existing_instances
output "data_aws_instances_existing_instance_ids" {
  value = data.aws_instances.existing_instances. # (e.g data.aws_instances.existing_instances.id = "us-east-1",  data.aws_instances.existing_instances.ids = tolist([
  "i-0bacd75918bbeed04"
}

# Example of output
/*
data_aws_instances_existing_instance_ids = {
  "filter" = toset([
    {
      "name" = "instance-id"
      "values" = toset([
        "i-0bacd75918bbeed04",
      ])
    },
  ])
  "id" = "us-east-1"
  "ids" = tolist([
    "i-0bacd75918bbeed04",
  ])
  "instance_state_names" = toset(null) /* of string */
  "instance_tags" = tomap(null) /* of string */
  "ipv6_addresses" = tolist([])
  "private_ips" = tolist([
    "10.0.0.8",
  ])
  "public_ips" = tolist([])
  "timeouts" = null /* object */
}
*/
```
