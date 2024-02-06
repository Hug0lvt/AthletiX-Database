# Database

Commande à executé a la racine du projet Backend pour récupérer le script sql issu des migrations :
``` bash
dotnet ef migrations script --project .\2.Repositories\ --startup-project .\1.API\
```