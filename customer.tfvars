
#mandant_prefix           = "022" # hier neue Mandantenprefix eingeben
environment_tag = "P"   # hier neue Umgebungstag eingeben
customer        = "APC" # hier neue Kundenname eingeben
apckunde        = "SIT Engineering AG"


citrix_application_name                    = "CMD Citrix Terraform 💡 Innovator 🎬 Showcase" # wird in der Schlaufe mit Mandantenprefix erstellt
citrix_application_description             = "Erleben Sie die Zukunft der Anwendungsbereitstellung mit unserer innovativen Demo, die die Leistungsfähigkeit von Citrix und Terraform vereint. Diese Showcase-Apps demonstrieren, wie Sie mit Terraform automatisiert und effizient Citrix-Umgebungen erstellen und verwalten können."
citrix_application_published_name          = "CMD Citrix-Terraform_Showcase"
citrix_application_command_line_arguments  = "“%**”" # aktuell noch ein Bug, es kann kein leerer Wert angegeben werden
citrix_application_command_line_executable = "C:\\Windows\\system32\\cmd.exe"
citrix_application_working_directory       = "%HOMEDRIVE%%HOMEPATH%"
citrix_deliverygroup_name                  = ["002-P-HSD-NON-SIT-0020"] #wird später über ein modul gelöst
citrix_application_visibility              = ["m002\\axdlet"]           # Benutzer oder Gruppe definieren
