# Roles

1: Manager
2: Employe
3: Administrator

### Récupérer un roles par id
 
```shell
GET http://localhost:4000/api/roles/:id
```

### Créer un roles
 
```shell
POST http://localhost:4000/api/roles
"Content-Type: application/json" 
{
	"roles": {
		"label": "employe",
        "status": 2
	}
}
```

### Supprimer un roles par id
 
```shell
DELETE http://localhost:4000/api/roles/:id
```

# User

### Récupérer tous les utilisateurs
 
```shell
GET http://localhost:4000/api/users
```

### Récupérer utilisateur par id
 
```shell
GET http://localhost:4000/api/users/by_id?id=exempledId
```

### Récupérer un utilisateur par email et password
 
```shell
GET http://localhost:4000/api/users/sign_in?email=exemple@gmail.com&password=exemple
```

### Récupérer un utilisateur par nom ou prenom
 
```shell
GET http://localhost:4000/api/users/search_user?nameSearch=exemple
```
 
### Créer un utilisateur
 
```shell
POST http://localhost:4000/api/users/sign_up
"Content-Type: application/json" 
{
	"users": {
		"email": "thomas.ferrand@gmail.com",
		"firstname": "Thomas",
		"lastname": "Ferrand",
		"password": "1234",
        "timeByMonth": 35,
        "roles_id": 2
	}
}
```
 
### Mettre à jour un utilisateur

```shell
PUT http://localhost:4000/api/users/update/:id
"Content-Type: application/json" 
{
	"users": {
		"email": "thomas.ferrand@gmail.com",
		"firstname": "Thomas",
		"lastname": "Ferrand",
		"password": "1234",
        "timeByMonth": 35
	}
}
```
 
### Supprimer un utilisateur
 
```shell
DELETE http://localhost:4000/api/users/:id
```
 
### Promouvoir un utilisateur
 
```shell
PUT http://localhost:4000/api/users/promote
"Content-Type: application/json" 
{
	"id": idUser
    "role": 2
}
```

# Clocks

### Créer un pointages avec id utilisateur
 
```shell
POST http://localhost:4000/api/clocks
"Content-Type: application/json" 
{
	"clocks":{
		"time": "2019-01-23 23:50:07",
		"status": true,
		"user": idUser
	}
}
```

### Récupérer un pointages avec id utilisateur
 
```shell
GET http://localhost:4000/api/clocks/:idUser
```

# WorkingTimes

### Récupérer tous les workingtimes d'un user
 
```shell
GET http://localhost:4000/api/workingtimes/:userID
```

### Récupérer un workingtimes par id et idUser
 
```shell
GET http://localhost:4000/api/workingtimes/:userID/:workingtimeID
```
 
### Créer un workingtimes avec idUser
 
```shell
POST http://localhost:4000/api/workingtimes/:userID
"Content-Type: application/json" 
{
	"workingtimes":{
		"start": "2019-02-24 13:50:07",
		"end": "2019-02-24 23:50:07",
		"user": 1
	}
}
```
 
### Mettre à jour un workingtimes avec l'id
 
```shell
PUT http://localhost:4000/api/workingtimes/:id
"Content-Type: application/json" 
{
	"workingtimes":{
		"start": newDate,
		"end": newDate,
		"user": 1
	}
}
```
 
### Supprimer un workingtimes
 
```shell
DELETE http://localhost:4000/api/workingtimes/:id
```

# Teams
 
### Créer une team
 
L'utilisateur indiquer comme manager d'équipe est automatiquement rajouter à l'équipe
```shell
POST http://localhost:4000/api/teams
"Content-Type: application/json" 
{
	"teams":{
		"name": teams
	}
}
```

### Supprimer une team
 
```shell
DELETE http://localhost:4000/api/teams/:id
```
 
### Ajouter des membres à une team
 
```shell
PUT http://localhost:4000/api/teams/add_user
"Content-Type: application/json" 
{
	"id": idTeams,
	"users": [idUser1, idUser2]
}
```
 
### Supprimer des membres d'une team
 
```shell
PUT http://localhost:4000/api/teams/suppr_user
"Content-Type: application/json" 
{
	"id": idTeams,
	"users": [idUser1, idUser2]
}
```
 
### Changer les membres d'une team
 
```shell
PUT http://localhost:4000/api/teams/change_user
"Content-Type: application/json" 
{
	"id": idTeams,
	"users": [idUser1, idUser2]
}
```
 
### Changer le manager d'une team
 
```shell
PUT http://localhost:4000/api/teams/change_manager
"Content-Type: application/json" 
{
	"id": idTeams,
	"managerID": idManager
}
```