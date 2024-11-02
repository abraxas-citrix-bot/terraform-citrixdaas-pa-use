# Terraform-Citrix-Playground

Welcome to the Terraform scripts for deploying Citrix DaaS. This collection of scripts helps you efficiently and consistently implement Citrix DaaS.

**Note:** This project is intended for testing purposes only. Please do not use it for deploying production infrastructure.


Feedback If you enjoyed this tutorial, please give this repo a star by clicking the star button at the top right of this page. ![Alt text](icons/shared.png) />

## Table of Contents
- [Prerequisites](#prerequisites)
- [Setup and Installation](#setup-and-installation)
- [Usage Guide](#usage-guide)
  - [Step 1: Clone the Repository](#step-1-clone-the-repository)
  - [Step 2: Create an API Client and Set Environment Variables](#step-2-create-an-api-client-and-set-environment-variables)
  - [Step 3: Review and Edit Terraform Files](#step-3-review-and-edit-terraform-files)
  - [Step 4: Initialize Terraform](#step-4-initialize-terraform)
  - [Step 5: Plan and Apply](#step-5-plan-and-apply)
  - [Step 6: Destroy Resources](#step-6-destroy-resources)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites
- Terraform installed (we recommend installing Terraform on Linux or WSL)
- Citrix Cloud account
- Delivery Group

## Setup and Installation

## Usage Guide

### Step 1: Clone the Repository

Begin by cloning this repository to your local machine:
```bash
git clone https://github.com/abraxas-citrix-bot/terraform-citrixdaas-pa-use.git
cd terraform-citrixdaas-pa-use
```

### Step 3: Download the Terraform Files
- Ensure Terraform is installed on your system. You can download the latest version from the Terraform website.

### Step 2: Create an API Client and Set Environment Variables
1. The Secure Client in Citrix Cloud is the same as the SPN in Azure. It is used for authentication.
   - API clients in Citrix Cloud are always tied to one administrator and one customer. API clients are not visible to other administrators. If you want to access more than one customer, you must create API clients within each customer.
   - API clients are automatically restricted to the rights of the administrator that created it.
   - Citrix Cloud API Overview
   - https://developer-docs.citrix.com/en-us/citrix-cloud/citrix-cloud-api-overview/get-started-with-citrix-cloud-apis.html
2. To create an API client, select **Identity and Access Management** from the menu.
   - If this option does not appear, you do not have adequate permissions to create an API client. Contact your administrator to get the required permissions.
3. Click **API Access**, then **Secure Clients**, and enter a name in the textbox adjacent to the button **Create Client**.
4. After entering a name, click **Create Client**.
5. Create a Citrix API Key in the Citrix DaaS Tenant and note it down securely, for example in Notepad, in the following format. 
   Then, enter it in the linux WSL shell. 
   Please ensure that the API key is not stored in the Git repository. 

    ```sh
    export TF_VAR_client_id="xxxxx"
    export TF_VAR_client_secret="xxxxx"
    export TF_VAR_customer_id="xxxx"
    export TF_VAR_citrix_deliverygroup_name='["dg_test"]' # name of delivery group
    export TF_VAR_citrix_application_visibility='["domain\\group"]'   # user or AD group for visibility
    ```

    Then, enter it in the windows Powershell.
   ```sh
    $env:TF_VAR_client_id="xxxxx"
    $env:TF_VAR_client_secret="xxxxx"
    $env:TF_VAR_customer_id="xxxx"
    $env:TF_VAR_citrix_deliverygroup_name='["dg_test"]' # name of delivery group
    $env:TF_VAR_citrix_application_visibility='["domain\\group"]'   # user or AD group for visibility
   ```

### Step 3: Create TF Files or Clone this Repo

- Please download this repository or create two files: `main.tf` and `customer.auto.tfvars`.
- In the `customer.auto.tfvars` file, you can adjust the values as needed.

<details>
<summary>Create TF Files</summary>
<br>
This is how you dropdown.


**main.tf**
```hcl
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

```

customer.auto.tfvars
```hcl
mandant_prefix                             = "Customer A"
citrix_application_name                    = "Calc Citrix Terraform 💡 Innovator 🎬 Showcase"
citrix_application_published_name          = "Calc Citrix-Terraform_Showcase"
citrix_application_description             = "Experience the future of application delivery with our innovative demo that combines the power of Citrix and Terraform. These showcase apps demonstrate how you can create and manage Citrix environments efficiently and automatically with Terraform."
citrix_application_command_line_executable = "C:\\Windows\\system32\\calc.exe"
icon_path                                  = "icons/citrix.ico"
```

</details>

### Step 4: Initialize Terraform
Run `terraform init`.

### Step 5: Plan and Apply Terraform Configuration
Execute `terraform plan`

Execute `terraform apply -auto-approve`

### Step 6: Destroy Terraform Resources
Execute `terraform destroy -auto-approve`

## Roadmap
Would you like to see new projects in this repository? If you have ideas or suggestions for new projects that should be included, feel free to create an issue or submit a pull request.

## Contributing
Thank you to all the people who have contributed to this project!
@cedfont
@abraxas-citrix-bot


## License
This project is licensed under the MIT License - see the LICENSE file for details.



