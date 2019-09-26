# Worktime

Pour démarrer l'API:

  * Installer les dépendances `mix deps.get`
    * Si db déjà créer, la supprimer `mix ecto.drop`
  * Créer base de donnée `mix ecto.create`
  * Mettre à jour la db `mix ecto.migrate`
  * Démarrer le serveur phoenix `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

##Au démarrage

3 rôles sont créer par défaut:

  * 1 : Manager
  * 2 : Employe
  * 3 : Administrateur
  
 Ainsi qu'un utilisateur Admin avec:
 
  * Email: "admin@gmail.com"
  * Password: "admin"

## Detail des tables

  * Users:
    * firstname     :string
    * lastname      :string
    * password      :string
    * email         :string
    * timeByMonth   :integer
    * roles_id      :integer
    * clocks        tableau d'objet Clocks
    * workingtimes  tableau d'objet Workingtimes
    * roles         tableau d'objet Roles
    * team          tableau d'objet Team

  * Clocks:
    * time          :string
    * status        :boolean
    * users         tableau d'objet Users

  * Workingtimes:
    * end           :string
    * start         :string
    * users         tableau d'objet Users

  * roles:
    * label         :string
    * status        :integer
    * users         tableau d'objet Users

  * teams:
    * name          :string
    * manager_id    :integer
    * users         tableau d'objet Users

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
