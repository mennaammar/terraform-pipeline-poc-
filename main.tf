##################################################################
# Data sources to get VPC, subnet, security group and AMI details
##################################################################

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "v4.3.0"

  name        = "example"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = data.aws_vpc.default.id

 # ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_cidr_blocks = ["197.48.189.127/32"]
  ingress_rules       = [ "ssh-tcp"]

    ##########Security bugs #################
     ## comment this to remediate
    # egress_rules        = ["all-all"]

}

module "ec2_with_t2" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "v2.19.0"
  instance_count = 1

  name          = "maf-instance-t2"
  ami           = "ami-0c2b8ca1dad447f8a" # the ami data source doesn't choose the correct one. ami-037aa94719126a377
  key_name = "mafkey"
  instance_type = "t2.small"
  subnet_id     = tolist(data.aws_subnet_ids.all.ids)[0]

  vpc_security_group_ids      = [module.security_group.security_group_id]
  ##########Security bugs #################
  ## comment this to remediate
   #associate_public_ip_address = true
  metadata_options = {
	http_tokens = "required"
  }	
   ###################################
   ####OPA ####
   tags = {
    BU   = "IT"
    ENV = "dev"
  }
   
}
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "v2.7.0"
  bucket = "my-s3-bucketmafterraformpoc"
  acl    = "private"

  versioning = {
    enabled = true
  }

  ##################################################
  ##########Security bugs #################
  #   server_side_encryption_configuration = {
  #     rule = {
  #       apply_server_side_encryption_by_default = {
  #       sse_algorithm = "AES256"
  #       }
  #   } 
  #  }
    block_public_policy = true
     block_public_acls = true
     restrict_public_buckets = true
     ignore_public_acls = true
     
   
  
   logging = {
		target_bucket = "bucket-logging-maf-us-east" #logging-bucketmaf
	}

  
 #####################################################
}

############################
# resource "aws_db_instance" "default" {
#   allocated_storage    = 10
#   engine               = "mysql"
#   engine_version       = "5.7"
#   instance_class       = "db.t3.micro"
#   name                 = "mydb"
#   username             = "foo"
#   password             = "foobarbaz"
#   parameter_group_name = "default.mysql5.7"
#   skip_final_snapshot  = true
# }
