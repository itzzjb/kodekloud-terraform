variable "prefix-list" {
    type = list(string)
    # in lists we can use the same value multiple time
    default = ["Mr", "Mr", "Mr"]
}

variable "prefix" {
    type = set(string)
    # in sets each value should be unique
    default = [ "Mr", "Mrs", "Sir" ]
}