export TF_VAR_client_id="xxxxx"
export TF_VAR_client_secret="xxxxx"
export TF_VAR_customer_id="xxxx"
export TF_VAR_citrix_deliverygroup_name=""
export TF_VAR_citrix_application_visibility=""


# Terraform-Playground-Azure

_Willkommen in deinem neuen Terraform-Playground!_


In diesem Projekt kannst du deine Terraform und Azure Kenntnisse testen und neue Dinge ausprobieren. Wir haben hier alles für dich vorbereitet, was du brauchst, um mit einem einfachen Terraform-Skript zu starten.

Viel Spass beim Experimentieren!

##Achtung!
Dieses Projekt ist nur für den Testzweck gedacht. Bitte verwende es nicht für die Bereitstellung von Produktionsinfrastruktur.


Viel Spass beim Terraformen! :)


So geht's:
## Anleitung zur Verwendung des Repositories

## Step 1
1.  Du kannst via Abraxas Service-Now eine Azure-playground für 30 tagen bestellen
    Link hier: https://servicenow.abraxas-tools.ch/sp?id=sc_cat_item&sys_id=6130f7bf1bdb11507251a71eab4bcb11 

   Weitere infos zur Playground-Azure hier https://confluence.abraxas-tools.ch/confluence/display/ITS/Azure+Playground

## Step 2

2.  Nach paar Minuten bekommst du die wichtigen infos per E-Mail.

   - ABX Azure Testumgebung RG_xxxx wurde eingerichtet.
     Im Anhang findest du die Wichtigen Variablen

![Alt text](Bild/vars.png)

Die Daten werden im Step4 benötigt

## Step 3

3.  Das Repository wird entweder für dich persönlich oder dein Team geforkt
https://gitlab.abraxas-tools.ch/sit/azureterraformplayground/-/forks/new

![Alt text](Bild/image.png)

![Alt text](Bild/image-2.png)

## Step 4 Environment Variables

4. Die folgenden Variablen (TF_VAR_ARM_CLIENT_ID, TF_VAR_ARM_CLIENT_SECRET, TF_VAR_resource_group_name ,TF_VAR_gitlab_token ) müssen eingetragen werden.Die Variable findest du im Mail.
   

   TF_VAR_ARM_CLIENT_ID="xxxxxxxxxxxxxxxxxx"
   
   TF_VAR_ARM_CLIENT_SECRET="xxxxxxxxxxxxxxxxxx"
   
   TF_VAR_resource_group_name="RG_xxxx"
   
   TF_VAR_gitlab_token="glpat-xxxxx" *hier wird deine personliche Gitlab Access Token eingetragen 

   Das folgende Bild zeigt wie die Variable hinzugefügt werden können.
   Über das Gitlab Navigationsmenü unter Settings->CI/CD.
 
![Alt text](Bild/image-3.png)

![Alt text](Bild/image-4.png)
   
   

   Falls du keinen Gitlab Access Token hast, kannst du hier einen generieren
   https://gitlab.abraxas-tools.ch/-/profile/personal_access_tokens aufrufen
   Name: User_Name eingeben
   Scopes auswählen:
   read_repository
   write_repository
   read_registry
   Schritt für Schritt Anleitung findest du in dem unteren Link.
   https://confluence.abraxas-tools.ch/confluence/display/OSAMDOKU/Gitlab+Access+Token+generieren
   



## Step 5
5. Der vorhandene Code z.B. terraform.tfvars kann entweder über Visual Studio oder auch über das WebStudio angepasst werden, z.B. wie der Wert bei: "Cost_Center_tag" ="SAP 51XXXXXX" und die "email_notification"     = "XXXXX@abraxas.ch", wo die Information geschickt wird, dass die VM heruntergefahren sind.

![Alt text](Bild/image-5.png)

Nachdem du den Git Commit & Push durchgeführt hast, wird eine Git-Pipeline gestartet, die den Code für dich erneut prüft und auch einen Terraform-Plan durchführt.
  
![Alt text](Bild/image-6.png)

Wenn im Gitlab Pipline keine Fehler auftreten, werden folgenden Ressourcen in Azure: eine Windows-VM und eine Linux-VM,  über die Pipeline automatisch erstellt.
  
![Alt text](Bild/image-7.png)


Melde dich über das Azure-Portal mit deinen Anmeldeinformationen aus der E-Mail an und überprüfe, ob die VMs erstellt wurden.

## Step 6
6. Was muss berücksichtigt werden?

Um einen reibungslosen Ablauf zu gewährleisten, gibt es im Umgang mit dem Playground einige wenige Richtlinien, an die man sich halten sollte. Wichtigster Punkt ist: dass Ressourcen nach Möglichkeit bei Nichtbenutzung heruntergefahren werden sollten. Ein Scheduler für das automatische Herunterfahren wurde eingerichtet.


Da du die Ressourcen nicht mehr benötigst, bitte ich dich, die VMs zu löschen. Starte dazu einfach die Pipeline und setze die Variable DESTROY_MODE auf "active".
Bitte vergiss nicht, dies ebenfalls zu genehmigen. Dadurch werden die VMs sofort gelöscht.

   ![Alt text](Bild/image-8.png)
   ![Alt text](Bild/image-8-1.png)

## Hier sind ein paar Ideen, wie du das Projekt weiter nutzen kannst:

- Erstelle eine neue VM mit einem anderen Betriebssystem.
- Erweitere die VM mit mehr Speicher oder CPU.
- Erstelle eine neue Netzwerkschnittstelle für die VM.
- Erstelle eine neue Netzwerksicherheitsgruppe für die VM.

_Witziges Gedicht_

Terraform-Skripte


> Terraform-Skripte sind wie Zaubersprüche,
Sie können dich mit Infrastruktur verzaubern.


Aber Vorsicht, Terraform-Skripte können auch gefährlich sein,
Wenn du einen Fehler machst,
Kannst du deine Infrastruktur ruinieren.

Also sei vorsichtig, wenn du mit Terraform-Skripten arbeitest,
Und lies dir die Dokumentation sorgfältig durch.

Und wenn du einen Fehler machst,
Dann kannst du immer noch terraform destroy ausführen.

[Disclaimer: Terraform ist ein grossartiges Werkzeug, aber es ist wichtig, es mit Vorsicht zu benutzen.]

[Zusätzliche Tipps und Tricks für Terraform-Einsteiger]

Lies die Dokumentation sorgfältig durch. Das ist der beste Weg, um zu lernen, wie Terraform funktioniert.

- https://developer.hashicorp.com/terraform/docs

- https://registry.terraform.io/

- https://learn.microsoft.com/de-de/azure/developer/terraform/

Starte mit einfachen Projekten. Sobald du die Grundlagen verstanden hast, kannst du dich an komplexere Projekte wagen.
Frage um Hilfe, wenn du sie brauchst. Es gibt viele Online-Foren und Ressourcen, die dir helfen können, wenn du feststeckst.


## Roadmap

Möchtest du neue Projekte in diesem Repository sehen?

Wenn du Ideen oder Vorschläge für neue Projekte hast, die in diesem Repository aufgenommen werden sollten, kannst du gerne ein Issue erstellen oder einen Pull-Request einreichen.

## Support

Hast du ein Problem oder einen Fehler gefunden?

Wenn du ein Problem oder einen Fehler findest, kannst du gerne ein Issue erstellen oder einen Pull-Request einreichen, um das Problem zu beheben.



Viel Erfolg!
