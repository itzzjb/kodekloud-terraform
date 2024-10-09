resource "random_pet" "my-pet" {
    # Convert the set to a list and get the first element
    prefix = tolist(var.prefix)[0]
}