# public_ip_check
The repository contains code for lab installation of checking instance public ip workflow.

The purpose of the lab is to notify the team about public IP address appeared on the controlled instance. AWS API calls are monitored with the help of CloudTrail and events are sent to lambda function for parsing and sent notification to SNS topic.

## Description
The infrastructure provisioned by this module is considered to be deployed into prepared environment:
- VPC and subnets are set without default public ip association
- S3 bucket for tfstate is set up and accessible
- Secured storage is set up and accessible

For needs of the lab installation is simplified:
- EC2 instance has only one interface
- All code is written in all-in-one root module due to absence of proper environment
- Default VPC, subnet and security groups are used
- Some values, e.g. instance type, are hardcoded as there is no need to scale this setup
- Tags are mostly ommitted as only the 'Name' makes sense for the lab