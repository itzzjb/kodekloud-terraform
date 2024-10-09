variable "bella" {
    # just like type = list(string)
    # but here instead of string we are giving a datastructure as a data type
    # it's defined in another {}
    type = object ({
        name = string
        color = string
        age = number
        food = list(string)
        favourite_pet = bool
    })
    # setting the default values of the above specified fields
    default = {
        name = "bella"
        color = "brown"
        age = 7
        food = ["fish", "chicken", "turkey"]
        favourite_pet = true
    }
}