resource "local_file" "pet" {
    filename = "C:/Users/januda.bethmin.de.si/Desktop/kodekloud-terraform/map-example/pet.txt"
    # we need to use key matching to access the values of the map
    # here we are using the value of the key statement2
    content = var.content["statement2"]
}