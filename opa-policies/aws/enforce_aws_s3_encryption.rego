package terraform
 
import input as tfplan

# make sure S3 encryption is enabled.
deny[reason] {
  
    resource:= tfplan.resource_changes[_]
    resource.type =="aws_s3_bucket"    
    not resource.change.after.server_side_encryption_configuration[0].rule
    reason := sprintf(
    "%s: resource type is missing encryption",
      [resource.type]
    )
}
