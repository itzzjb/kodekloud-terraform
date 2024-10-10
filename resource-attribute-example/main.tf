resource "local_file" "pet" {
  filename = var.filename
  # the random_pet resource will return a attribute called id as a output that contains the pet name
  # we can use that attribute called id here in the local_file resource
  content = "My favourite pet is ${random_pet.my-pet.id}"
  # You can use it directly like this as well
  # content = random_pet.my-pet.id
}

resource "random_pet" "my-pet" {
  prefix = var.prefix
  separator = var.seperator
  length = var.length
}