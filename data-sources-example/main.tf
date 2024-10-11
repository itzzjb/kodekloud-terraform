resource "local_file" "pet" {
    filename = var.filename
    # to use the data that got from the data source 
    # this is same as usign resource attributes but need to have a prefix called data
    # the local_file data souce expoces content and content_base64 
    content = data.local_file.dog.content
}

# the dogs.txt is created after the initial provision that creates the pet.txt.check 
# dogs.txt is outside the management of terraform at this point in time
# we are using this file as the data source and use it's data as contents of our existing file pet.txt

# we will have a seperate data block here
# the block is followed by the type of resource which we are trying to read
# this can be any valid resouce type provided by any valid provider
data "local_file" "dog" {
    # we can file the attributes that a local file exposes using the documentaion
    filename = "C:/Users/januda.bethmin.de.si/Desktop/kodekloud-terraform/data-sources-example/datasource/dogs.txt"
}