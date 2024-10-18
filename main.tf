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



###############################################################################
# Data Sources
###############################################################################

data "citrix_delivery_group" "example_delivery_group" {
  name = var.citrix_deliverygroup_name[0]
}

resource "citrix_admin_folder" "example_admin_folder_1" {
  name = var.mandant_prefix
  type = ["ContainsApplications"]
}

###############################################################################
# Resources
###############################################################################

module "terraform_citrixdaas_pa_mvd" {
  source = "github.com/adraxas-citrix-bot/terraform-citrixdaas-pa-mvd?ref=0.5.2"
  #source  = "gitlab.abraxas-tools.ch/sit/terraform-citrixdaas-pa-mvd/local"
  #version = "0.5.2"
  #source                                     = "../module"
  citrix_application_name                    = var.citrix_application_name
  citrix_application_description             = var.citrix_application_description
  citrix_application_published_name          = var.citrix_application_published_name
  citrix_application_command_line_arguments  = "“%**”"
  citrix_application_command_line_executable = var.citrix_application_command_line_executable
  citrix_application_working_directory       = "%HOMEDRIVE%%HOMEPATH%"
  citrix_application_visibility              = var.citrix_application_visibility
  citrix_application_icon                    = citrix_application_icon.example_application_icon.id
  citrix_application_folder_path             = citrix_admin_folder.example_admin_folder_1.path
  citrix_deliverygroup_name                  = data.citrix_delivery_group.example_delivery_group.name

}

resource "citrix_application_icon" "example_application_icon" {
  raw_data = filebase64("${path.module}/${var.icon_path}")
}


###############################################################################
# variable
###############################################################################

variable "client_id" {
  description = <<-EOF
  Please enter the The Citrix Cloud Client id. Example: 12345678-1234-1234-1234-123456789012
  Link https://developer-docs.citrix.com/en-us/citrix-cloud/citrix-cloud-api-overview/get-started-with-citrix-cloud-apis.html
  EOF
  type        = string
}

variable "client_secret" {
  description = <<-EOF
  Please enter the The Citrix Cloud Client secret. Example: xxxxxxx-xxxxxxx==
  Link https://developer-docs.citrix.com/en-us/citrix-cloud/citrix-cloud-api-overview/get-started-with-citrix-cloud-apis.html
  EOF
  type        = string
  sensitive   = true
}

variable "customer_id" {
  description = <<-EOF
  Please enter The Citrix Cloud customer id. Example: xxxxxxxx
  Link https://developer-docs.citrix.com/en-us/citrix-cloud/citrix-cloud-api-overview/get-started-with-citrix-cloud-apis.html
  EOF
  type        = string
}

variable "citrix_application_visibility" {
  description = <<-EOF
  Please enter Users or group . Example: ["domain\\UserOrGroupName"]
  By default, the application is visible to all users within a delivery group. However, you can restrict its visibility to only certain users by specifying them in the limit_visibility_to_users list.
  EOF
  type        = list(string)
}

variable "citrix_deliverygroup_name" {
  description = <<-EOF
  Please enter the Name of the delivery group. Example: ["DG-A-Test"]
  EOF
  type        = list(string)
}



#############################################
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





variable "icon_path" {
  description = "Please enter the Path to the icon"
  type        = string
  default     = "/icons/citrix.ico"
}

variable "mandant_prefix" {
  description = "please enter the Customer name"
  type        = string
}
