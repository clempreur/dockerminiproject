Lancement du projet sous Docker

1 er étape:

    Se rendre dans le docker-compose.yml à la racine, et modifier les informations de connexion à la base de donnée dans phoenix -> environnement et aussi dans db->environnement
    Se rendre dans le dossier API/config et modifier le fichier dev.exs pour mettre vos informations de connexion à la base de donnée
2 ème étape:

    taper : docker-compose build dans le terminal en étant à la racine du dossier

3 ème étape:

    taper: docker-compose up dans le terminal en étant à la racine du dossier

4 ème étape:

    Se rendre sur son localhost avec pour port 8080 pour accéder au front
    Se rendre sur son localhost avec pour port 4001 pour accéder à l'API

