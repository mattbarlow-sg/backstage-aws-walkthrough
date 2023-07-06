variable "region" {
  description = "AWS Region to target"
  type        = string
}

variable "env_name" {
  description = "Environment name string to be used for decisions and name generation"
  type        = string
}

variable "name_prefix" {
  description = "String to use as prefix on object names"
  type        = string
}

variable "name_suffix" {
  description = "String to append to object names. This is optional, so start with dash if using."
  type        = string
  default     = ""
}

variable "source_repo" {
  description = "name of repo which holds this code"
  type        = string
}

//variable "application_name" {
//  description = "The name of the application to put in the Application tag"
//  type        = string
//}

variable "backup_key" {
  description = "Tag key used to indicate backup resource"
  type        = string
  default     = "AWS_Backup"
}

variable "backup_key_value" {
  description = "Tag key used to indicate backup resource"
  type        = string
  default     = true
}

variable "backup_failed_sns_endpoint" {
  description = "SNS topic endpoint"
  type        = string
  default = "msp@stratusgrid.com"
}