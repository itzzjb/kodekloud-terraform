variable "prefix" {
    # these are the values we are a
    default = ["Mr", "Mrs", "Sir"]
    # We are specifying the type as list
    # we can specify the data type of the list we want
    type = list(string)
}