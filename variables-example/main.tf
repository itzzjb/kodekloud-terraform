# we can use the variables assigned in the variables.tf file in main.tf file
# var.<variable_name>
resource "local_file" "pet" {
    filename = var.filename 
    content = var.content
}

resource "random_pet" "my-pet" {
    prefix = var.prefix
    separator = var.separator
    length = var.length
}