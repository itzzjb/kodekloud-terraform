# we can create resources from multiple providers within the same configuration

# local provider
resource "local_file" "pet" {
    filename = "C:/Users/januda.bethmin.de.si/Desktop/kodekloud-terraform/multiple-example/pet.txt"
    content = "We love pets!"
}

# random provider
# this resource type provided by the random provider creates random pet name
resource "random_pet" "my_pet" {
  prefix = "Mr."
  separator = "."
  length = "1"
}

