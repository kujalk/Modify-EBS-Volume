Purpose - AWS CLI based Shell script to modify EBS volume from type GP2 to type GP3

Pre-Requisites -
[1] Install AWS CLI and configure the region -> IAM user must have appropriate privileges to modify the volume
[2] sudo yum install jq -y

Testing Environment - Terraform template provided to create EC2 with additional volumes and appropriate role attached to EC2. 
Make sure you change the SSH key name for EC2 and configure the AWS CLI region once logged in.

Developer - K.Janarthanan 

