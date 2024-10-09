variable "kitty" {
    # we can define the type of variables that we use in the tuple inside []
    # the variables that need to be passed to this should exactly be 3 in number and of that specific type for it to work
    type = tuple([string, number, bool])
    default = ["cat", 7, true]
}