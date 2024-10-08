# the type of block here is a "resource" block
# then we have the declaration of the resource type as "local_file"
# the resource type is provides two bits of information, the providers and the resource
# local -> provider
# file -> resource
# the final declaration is resource name and it's set to "pet". used to identify the resouce and can be named anything.
# can use the local_sensitive_file to make the content of the file won't display in the terminal
resource "local_file" "pet" {
  # within the block we are defining the arguments
  # written in key-value pair format
  # arguments are specific to type of reource that we are creating 
  filename = "C:/Users/januda.bethmin.de.si/Desktop/kodekloud-terraform/localfile-example/pet.txt" # absolute path
  content = "We love pets!"
}