variable "content" {
    type = map
    # we specify as many key value pairs enclosed within curly braces
    default = {
        # statement1 and statement2 are Keys and the data following them are Values
        "statement1" = "We love pets!"
        "statement2" = "We love animals!"
    }
}