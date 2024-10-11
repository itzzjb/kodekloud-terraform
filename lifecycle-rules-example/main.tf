resource "local_file" "pet1" {
  filename = var.filename1
  content = var.content
  file_permission = var.file_permission
  # we will add the life cycle rules here
  lifecycle {
    # this is one of the argumennt/rule that we can pass into the lifecycle block
    # this ensures that a new resource will be created first before deleting the old one.
    create_before_destroy = true
    # lifecycle rule we applied caused the local file to the created first and the same file to be destroyed
    # This goes to show that it is not always advisable to use this rule!
  }
}

resource "local_file" "pet2" {
  filename = var.filename2
  content = var.content
  file_permission = var.file_permission
  lifecycle {
    # by using this terraform will reject any changes that will result in resource getting destroyed when usign terraform apply command
    # it will also give and error message as an output
    # this is very useful for prevent resources from getting accidently deleted. 
    # for example a database resource may not be something we want to delete once it provisioned
    prevent_destroy = true
    # note that the resouce will still be destroyed if we make use of the terrafrom destroy command
  }
}


resource "local_file" "pet3" {
  filename = var.filename3
  content = var.content
  file_permission = var.file_permission
  lifecycle {
    # this will prevent a resource from being updated based on a list of attributes that we define within the lifecycle block
    # we can ignore changes to a resouce when specific attributes of the resouce changes
    ignore_changes = [
        # if the content of filename attribute of the resource is changed, all the changes will be ignored
        content,filename
    ]
    # you can also ignore changes for changes done to any (all) argument
    # ignore_changes =  all
  }
}