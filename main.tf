terraform {
  required_version = ">=1.2"
  required_providers {

    random = {
      source  = "hashicorp/random"
      version = "= 3.6.2" # Stellen Sie sicher, dass Sie die gewünschte Version angeben
    }

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

########################################################

########################################################




resource "citrix_admin_folder" "example-admin-folder-1" {
  name = var.mandant_prefix
  type = ["ContainsApplications"]
}

module "terraform_citrixdaas_pa_mvd" {
  source                                     = "github.com/adraxas-citrix-bot/terraform-citrixdaas-pa-mvd?ref=0.0.13"
  citrix_application_name                    = var.citrix_application_name
  citrix_application_description             = var.citrix_application_description
  citrix_application_published_name          = var.citrix_application_published_name
  citrix_application_command_line_arguments  = "“%**”"
  citrix_application_command_line_executable = var.citrix_application_command_line_executable
  citrix_application_working_directory       = "%HOMEDRIVE%%HOMEPATH%"
  citrix_application_visibility              = var.citrix_application_visibility
  citrix_application_icon                    = filebase64("${path.module}/icons/citrix.ico")
  citrix_application_folder_path             = citrix_admin_folder.example-admin-folder-1.path
  citrix_deliverygroup_name                  = [data.citrix_delivery_group.example_delivery_group.id]

}


#######################################################################################
# Variables for the deployment of the Citrix Virtual Apps and Desktops service on Azure
# Variables for the new Citrix DaaS environment in general
#######################################################################################
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


variable "mandant_prefix" {
  description = "mandant prefix"
  type        = string
}

variable "citrix_deliverygroup_name" {
  description = "Name of the delivery group"
  type        = list(string)
}

variable "citrix_application_folder_path" {
  type        = string
  description = "Path to the folder where the application should be placed"
  default     = "value"
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

variable "citrix_application_command_line_arguments" {
  description = "cmd arguments"
  type        = string
}

variable "citrix_application_command_line_executable" {
  description = "The command line executable"
  type        = string
}

variable "citrix_application_working_directory" {
  description = "The working directory"
  type        = string
}


variable "citrix_application_visibility" {
  description = "The visibility of the application"
  type        = list(string)
}
