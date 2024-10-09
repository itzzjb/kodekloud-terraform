variable "content" {
    # We are specifying the type as map
    # we can specify the data type of the map we want
    type = map(string)
    # we specify as many key value pairs enclosed within curly braces
    default = {
        # statement1 and statement2 are Keys and the data following them are Values
        "statement1" = "We love pets!"
        "statement2" = "We love animals!"
    }
}