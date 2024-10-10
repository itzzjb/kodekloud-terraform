resource "local_file" "pets" {
  filename = var.filename
  content = var.content
  # if there is no implicit dependency, we can create a explicit dependency as needed.
  # we can do that by usinf depends_on argument
  depends_on = [ 
    # here are are mentioning the <resource_type>.<resource_name> that depends on
    random_pet.my-pet 
  ]
}

resource "random_pet" "my-pet" {
  prefix = var.prefix
  separator = var.seperator
  length = var.length
}