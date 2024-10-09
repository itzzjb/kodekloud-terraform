resource "random_pet" "my-pet" {
    # we can use different values of the list through the index
    prefix = var.prefix[0]
}