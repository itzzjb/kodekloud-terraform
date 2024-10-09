# We use the Variable block here
# we are passing in the variable name after the block name
# even though we give any name for the variable, we 
variable "filename" {
    # we are passing in the default value we are giving the variable
    default = "C:/Users/januda.bethmin.de.si/Desktop/kodekloud-terraform/variables-example/pet.txt"
}

variable "content" {
    default = "I love pets!"
}

variable "prefix" {
    default = "Mr."
}

variable "separator" {
    default = "."
}

variable "length" {
    default = "1"
}