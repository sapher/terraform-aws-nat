variable "name" {
  description = "Nat instance name"
  type        = string
}

variable "enabled" {
  description = "Enable module"
  type        = bool
  default     = true
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t3.nano"
}

variable "vpc_id" {
  description = "VPC Id"
  type        = string
}

variable "private_route_table_ids" {
  description = "IDs for private route table"
  type        = list(string)
}

variable "public_subnet_id" {
  description = "Public subnet ID where nat instance is deployed"
  type        = string
}

variable "tags" {
  description = "Optional tags for all resources"
  type        = map(string)
  default     = {}
}
