# READ ME
#### Travail effectué par Nicolas Catanoso Xavier Ferry Nicolas Opériol-Gerbal ~~~ NXN
### A. Lancement de l'application

Au lancement de l'application, une page de login est affichée. 
Il est possible de continuer sur l'application sans créer de compte mais certaines fonctionnalités ne seront pas disponibles (ex: création d'un service, envoie d'un message)

#####  Navigation Bar
Tout au long de la navigation, plusieurs boutons sont accessibles dans la navigation bar. 
  - ```+``` permet d'accéder à la création d'aide.
  - ```Profil``` permet d'accéder à son profil
  - ```loupe``` permet de d'aller à la page de recherche
  - ```<``` permet de revenir à la page précédente.
  - ```Deconnexion```remplace ```<``` dans le cas où nous nous trouvons sur la page de recherche


### B. Création de services
En appuyant sur  ```+ ``` dans la barre de navigation, l'utilisateur est redirigé vers la page de création de service.
Il doit : 
  - renseigner un titre
  - choisir une (ou plusieurs) catégorie(s)
  - saisir une description
  - selectionner une date de début et du date de fin
  - le temps à consacrer au service

### C. Recherche de services

On peut voir la liste des services disponibles en choisissant de les afficher par catégorie ou par géolocalisation. 

###### Par catégorie :
Une ```liste des catégories``` apparait, puis une liste des services faisant référence à la catégorie choisie.

###### Par géolocalisation :
Une carte de l'endroit où se situe l'utilisateur apparait avec des ```pins``` situés sur les adresses des services disponible. Au clic sur un petit aperçu du service est visible ainsi qu'une icône  ```informations```. Un clic sur celle-ci redirige vers l'affichage du service.

### D. Affichage d'un service

Les informations relatives au service sont disponibles (titre, dates etc.). Le login de l'utilisateur qui a proposé le service est en fait un bouton ! Il redirige vers le profil de ce dernier (et permet de le contacter en privé).

Un ```mur```est affiché en bas de la page. C'est un moyen public de contacter les personnes interessées par ce service. Lorsqu'un message est envoyé par une personne lambda, il apparait aligné à gauche et de couleur grise. Si c'est la personne qui a proposé qui envoie un message, il est vert ! Enfin, les messages que nous avons envoyés sont alignés sur la droite de l'écran. Lorsque le mur devient trop rempli, il devient ```scrollable```

Finalement, si ce service interesse l'utilisateur, il peut ```demander de l'aide``` en cliquant sur le bouton portant ce nom.

### E. Demande d'aide

L'utilisateur peut selectionner la date à laquelle il souhaiterait recevoir l'aide.
Celui qui a proposé cette aide verra alors une ```alerte``` la prochaine fois qu'il lancera l'application. Cette dernière lui propose de se rendre à ses services.

### F. Mon Compte

##### F.1 Mon profil
Ici, on peut voir les informations saisies à la création du compte. On peut également voir la ```moyenne des notes```qui nous ont été attribuées. Un profil est accessible de tous.

##### F.2 Messagerie
En plus du mur public, il est possible d'avoir une communication privée avec un utilisateur. En cliquant sur ```messagerie```, une liste des personnes avec qui le contact a déjà été initié est visible. Evidemment, il est possible de cliquer sur une personne et de lui envoyer autant de message que l'on souhaite. Le fonctionnement est identique à celui du mur décris précédemment.

Pour initier le contact avec quelqu'un, il faut trouver un service proposé par cette personne et cliquer sur son nom. Il n'est pas possible d'envoyer de message à quelqu'un sans passer par cette étape ( hormis pour repondre à quelqu'un qui est passé par cette étape ).

##### F.3 Services que je propose
Une liste contenant les demandes qui sont effectuées envers l'utilisateur est affichée. Au clic sur une demande, une alerte comportant le login de l'autre utilisateur et la date qu'il souhaite apparait. 
Cette alerte propose :
  - Accepter et contacter
  - Refuser
  - Annuler

###### Accepter et contacter 
Lorsqu'il accepte, il est redirigé vers la page de contact en privé avec l'utilisateur en question. 
Si il re-selectionne ce service dans la liste, on lui proposera alors de ```noter```.

###### Refuser
Il est également possible de refuser une demande de service. Le service sera supprimé et donc ne sera plus visible par l'autre utilisateur, ni par l'utilisateur courant.

##### F.4 Services que je demande
Lorsque le service n'est pas encore accepté, une alerte s'affiche au clic sur une des cellules de la liste. 
Lorsque celui-ci est accepté par l'utilisateur qui propose le service, l'alerte est différente de la précédente. On propose maintenant de noter l'autre utilisateur.

### G. Notation
On peut noter et attribuer un nombre d'```étoiles```à un utilisateur ainsi qu'un commentaire.
On peut également voir la note qui nous a été attribué par l'autre utilisateur, ainsi que le commentaire.


