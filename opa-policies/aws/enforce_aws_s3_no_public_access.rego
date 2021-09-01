package terraform
 
import input as tfplan

# make sure no public access is enabled 
deny[reason_public] {
  
    resource:= tfplan.resource_changes[_]
    resource.type =="aws_s3_bucket"
    trace(resource.change.after.acl)
    resource.change.after.acl != "private"
    reason_public := sprintf(
    "%s: resource type is missing acl",
      [resource.type]
    )
}
