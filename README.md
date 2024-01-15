
Version de Dart utilisée : La version utilisée est compatible avec la plage de versions entre 3.1.5 et 4.0.0, mais nous avons développé sur la version 3.1.5.

Concernant les fonctionnalités de l'application :

L'application vise à aider les habitants d'Angers à trouver un lieu pour pratiquer leur sport préféré. L'utilisateur peut choisir parmi une liste de sports, et l'application lui renverra une liste des endroits où il peut pratiquer ce sport.

L'application se compose de trois écrans :

Écran d'accueil : Il affiche le nom de l'application avec une mise en page attrayante. L'utilisateur a accès à deux boutons cliquables : l'un pour accéder à ses favoris et l'autre pour trouver un lieu sportif.

Écran "Trouver un lieu" : Sur cette page, l'utilisateur peut spécifier le sport qu'il souhaite pratiquer. Une liste de tous les endroits où il peut pratiquer ce sport lui est alors présentée, avec les noms et les coordonnées GPS de chaque lieu. À partir de cette page, il a la possibilité de marquer des lieux comme favoris, qui seront ensuite accessibles depuis la page des favoris.

Écran "Mes favoris" : Cette section est divisée en deux parties :

a. Liste : Elle affiche tous les lieux sportifs marqués comme favoris, avec la possibilité de les retirer de la liste des favoris.

b. Carte : Les lieux sportifs favoris sont affichés sur une carte OpenStreetMap, marqués par un indicateur rouge et le nom du lieu sportif. Cela facilite la localisation des lieux sportifs favoris pour l'utilisateur.

L'application utilise l'API suivante : https://data.angers.fr/explore/dataset/equipements-sportifs-angers/api/

L'application respecte les consignes suivantes :
-utilise un système de persistance des données pour le stockage des informations.
-intègre un "state management" global pour gérer les lieux sportifs favoris.

La dernière version du projet est sur la branche main.
