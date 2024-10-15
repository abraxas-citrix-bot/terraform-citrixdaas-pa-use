terraform {
  required_version = ">=1.2"
  required_providers {
    citrix = {
      source  = "citrix/citrix"
      version = "=1.0.4"
    }
  }
}

# This block specifies the Citrix Provider configuration.
provider "citrix" {
  cvad_config = {
    customer_id   = var.customer_id
    client_id     = var.client_id
    client_secret = var.client_secret
  }
}


####

variable "mandant_prefix" {
  description = "please enter the tenant prefix in this form: 022"
  type        = string
  default     = "022"
}


variable "client_id" {
  description = "The Citrix Cloud client id"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "The Citrix Cloud client secret"
  type        = string
  sensitive   = true

}

variable "customer_id" {
  type        = string
  description = "The Citrix Cloud customer id"
  #sensitive   = true
}


variable "citrix_deliverygroup_name" {
  description = "Name of the delivery group"
  type        = list(string)

}



variable "citrix_application_name" {
  description = "The name of the application"
  type        = string
}

variable "citrix_application_description" {
  description = "Application Description"
  type        = string
}

variable "citrix_application_published_name" {
  description = "The name of the application"
  type        = string
}


variable "citrix_application_command_line_executable" {
  description = "The command line executable"
  type        = string
}



variable "citrix_application_visibility" {
  description = "The visibility of the application"
  type        = list(string)
}


data "citrix_delivery_group" "example_delivery_group" {
  name = var.citrix_deliverygroup_name[0]
}

resource "citrix_admin_folder" "example_admin_folder_1" {
  name = var.mandant_prefix
  type = ["ContainsApplications"]
}

module "terraform_citrixdaas_pa_mvd" {
  source                                     = "github.com/adraxas-citrix-bot/terraform-citrixdaas-pa-mvd?ref=0.3.13"
  citrix_application_name                    = var.citrix_application_name
  citrix_application_description             = var.citrix_application_description
  citrix_application_published_name          = var.citrix_application_published_name
  citrix_application_command_line_arguments  = "“%**”"
  citrix_application_command_line_executable = var.citrix_application_command_line_executable
  citrix_application_working_directory       = "%HOMEDRIVE%%HOMEPATH%"
  citrix_application_visibility              = var.citrix_application_visibility
  citrix_application_icon                    = filebase64("${path.module}/icons/citrix.ico")
  citrix_application_folder_path             = citrix_admin_folder.example_admin_folder_1.path
  citrix_deliverygroup_name                  = [data.citrix_delivery_group.example_delivery_group.id]
}
