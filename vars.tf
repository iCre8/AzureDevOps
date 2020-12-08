variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default = "East US"
}
variable "UseTags"{
    description = "Available Tages for this resource"
    default = "project-1"
}
variable "user_name" {
  description = "Enter the username. This should be a administrative account"
  sensitive = true
}

variable "user_pass" {
  description = "Enter the password"
  sensitive = true

}

variable "vm_instances" {
  description = "User enters number of VM's to create"
}