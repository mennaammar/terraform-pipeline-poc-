package terraform
 
import input as tfplan

# make sure BU tag exists in every aws instance created. 
deny[reason] {

    resource:= tfplan.resource_changes[_]
    resource.type =="aws_instance"
    not resource.change.after.tags.BU
    reason := sprintf(
    "%s: resource type is missing BU required tags",
      [resource.type]
    )
  
}

# make sure ENV tag exists in every aws instance created. 
deny[reason] {
    resource:= tfplan.resource_changes[_]
    resource.type =="aws_instance"
    not resource.change.after.tags.ENV   
    reason := sprintf(
    "%s: resource type is missing ENV required tags",
      [resource.type]
    )
  
}