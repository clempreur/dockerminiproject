defmodule Worktime.Auth do
  @moduledoc """
  The Auth context.
  """

  import Ecto.Query, warn: false

  alias Worktime.Repo
  alias Worktime.Auth.Users
  alias Worktime.Auth.Roles

  @doc """
  Returns the list of users with correspondant email and password.

  ## Examples

      iex> authenticate_user("email@gmail.com", "thomas")
      [%Users{}, ...]

  """
  def authenticate_user(email, password) do
    query = from u in Users, where: u.email == ^email and u.password == ^password, select: u
    Repo.all(query)
  end

  def authenticate_user(nameSearch) do
    query = from u in Users, where: like(u.firstname, ^("%#{nameSearch}%")) or like(u.lastname, ^("%#{nameSearch}%")), select: u
    String.contains?("elixir of life", "of")
    Repo.all(query)
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%Users{}, ...]

  """
  def list_users do
    Repo.all(Users)
  end

  @doc """
  Gets a single users.

  Raises `Ecto.NoResultsError` if the Users does not exist.

  ## Examples

      iex> get_users!(123)
      %Users{}

      iex> get_users!(456)
      ** (Ecto.NoResultsError)

  """
  def get_users!(id), do: Repo.get!(Users, id)

  @doc """
  Gets a single users.

  Raises `Ecto.NoResultsError` if the Users does not exist.

  ## Examples

      iex> get_users!(exemple@gmail.com)
      %Users{}

      iex> get_users!(456)
      ** (Ecto.NoResultsError)

  """
  def get_users_by_mail(email) do
    query = from u in Users, where: u.email == ^email, select: u

    query
    |> Repo.all()
    |> List.first()
  end

  @doc """
  Verifie le format de l'adresse mail.

  ## Examples

      iex> verificate_mail(exemple@gmail.com)
      true

      iex> verificate_mail(456)
      false

  """
  def verificate_mail(email) do
    !Regex.match?(~r/^[A-Za-z0-9.%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,4}$/, email)
  end

  def get_users_by_mail(email, id) do
    query = from u in Users, where: u.email == ^email and u.id != ^id, select: u

    query
    |> Repo.all()
    |> List.first()
  end

  @doc """
  Gets a single users.

  Raises `Ecto.NoResultsError` if the Users does not exist.

  ## Examples

      iex> get_users!(123)
      %Users{}

      iex> get_users!(456)
      ** (Ecto.NoResultsError)

  """
  def get_users_clock(id) do
    user = Repo.one from u in Users,
             join: c in assoc(u, :clocks),
             where: u.id == ^id,
             preload: [ clocks: c],
             select: u
    user.clocks
  end


  @doc """
  Creates a users.

  ## Examples

      iex> create_users(%{field: value})
      {:ok, %Users{}}

      iex> create_users(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_users(attrs \\ %{}) do
    #Controle du format de l'adresse mail
    if verificate_mail(Map.get(attrs, "email")) do
      %{"rep" => "L'adresse mail '" <> Map.get(attrs, "email") <> "' est incorrect"}
    else
      #Vérification de l'existence du compte
      if get_users_by_mail(Map.get(attrs, "email")) do
        %{"rep" => "L'adresse mail '" <> Map.get(attrs, "email") <> "' est déjà utiliser"}
      else
        Users.changeset(%Users{}, attrs)
        |> Repo.insert()
      end
    end
  end

  @doc """
  Updates a users.

  ## Examples

      iex> update_users(users, %{field: new_value})
      {:ok, %Users{}}

      iex> update_users(users, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_users(%Users{} = users, attrs) do
      #Controle du format de l'adresse mail
    if verificate_mail(Map.get(attrs, "email")) do
      %{"rep" => "L'adresse mail '" <> Map.get(attrs, "email") <> "' est incorrect"}
    else
      #Vérification de l'existence du compte
      if get_users_by_mail(Map.get(attrs, "email"), users.id) do
        %{"rep" => "L'adresse mail '" <> Map.get(attrs, "email") <> "' est déjà utiliser"}
      else
        users
        |> Users.changeset(attrs)
        |> Repo.update()
      end
    end
  end

  def promote_users(%Users{} = users, newRole) do
    users
    |> Users.changeset(%{"roles_id" => newRole})
    |> Repo.update()
  end

  @doc """
  Deletes a Users.

  ## Examples

      iex> delete_users(users)
      {:ok, %Users{}}

      iex> delete_users(users)
      {:error, %Ecto.Changeset{}}

  """
  def delete_users(%Users{} = users) do
    Repo.delete(users)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking users changes.

  ## Examples

      iex> change_users(users)
      %Ecto.Changeset{source: %Users{}}

  """
  def change_users(%Users{} = users) do
    Users.changeset(users, %{})
  end

  alias Worktime.Auth.Clocks

  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clocks{}, ...]

  """
  def list_clocks do
    Repo.all(Clocks)
  end

  @doc """
  Gets a single clocks.

  Raises `Ecto.NoResultsError` if the Clocks does not exist.

  ## Examples

      iex> get_clocks!(123)
      %Clocks{}

      iex> get_clocks!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clocks!(id), do: Repo.get!(Clocks, id)

  @doc """
  Creates a clocks.

  ## Examples

      iex> create_clocks(%{field: value})
      {:ok, %Clocks{}}

      iex> create_clocks(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clocks(attrs \\ %{}) do
    user = Repo.get(Users, Map.get(attrs, "user"))
    attr = Ecto.build_assoc(user, :clocks, %{status: Map.get(attrs, "status"), time: Map.get(attrs, "time")})
    Repo.insert(attr)
  end

  @doc """
  Updates a clocks.

  ## Examples

      iex> update_clocks(clocks, %{field: new_value})
      {:ok, %Clocks{}}

      iex> update_clocks(clocks, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clocks(%Clocks{} = clocks, attrs) do
    clocks
    |> Clocks.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Clocks.

  ## Examples

      iex> delete_clocks(clocks)
      {:ok, %Clocks{}}

      iex> delete_clocks(clocks)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clocks(%Clocks{} = clocks) do
    Repo.delete(clocks)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clocks changes.

  ## Examples

      iex> change_clocks(clocks)
      %Ecto.Changeset{source: %Clocks{}}

  """
  def change_clocks(%Clocks{} = clocks) do
    Clocks.changeset(clocks, %{})
  end

  alias Worktime.Auth.Workingtimes

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%Workingtimes{}, ...]

  """
  def list_workingtimes do
    Repo.all(Workingtimes)
  end

  @doc """
  Gets a single workingtimes.

  Raises `Ecto.NoResultsError` if the Workingtimes does not exist.

  ## Examples

      iex> get_workingtimes!(123)
      %Workingtimes{}

      iex> get_workingtimes!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workingtimes!(id), do: Repo.get!(Workingtimes, id)

  def get_workingtimes!(userId, workingtimeID) do
    user = Repo.one from u in Users,
                    join: t in assoc(u, :workingtimes),
                    where: u.id == ^userId and t.id == ^workingtimeID,
                    preload: [workingtimes: t],
                    select: u
    if user do
      user.workingtimes
    else
      %{id: false}
    end

  end

  def get_workingtimesbyuser(userId) do
    user = Repo.one from u in Users,
                    join: t in assoc(u, :workingtimes),
                    where: u.id == ^userId,
                    preload: [workingtimes: t],
                    select: u
    if user do
      user.workingtimes
    else
      %{id: false}
    end
  end

  @doc """
  Creates a workingtimes.

  ## Examples

      iex> create_workingtimes(%{field: value})
      {:ok, %Workingtimes{}}

      iex> create_workingtimes(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workingtimes(attrs \\ %{}) do
    user = Repo.get(Users, Map.get(attrs, "user"))
    attr = Ecto.build_assoc(user, :workingtimes, %{start: Map.get(attrs, "start"), end: Map.get(attrs, "end")})
    Repo.insert(attr)
  end

  @doc """
  Updates a workingtimes.

  ## Examples

      iex> update_workingtimes(workingtimes, %{field: new_value})
      {:ok, %Workingtimes{}}

      iex> update_workingtimes(workingtimes, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workingtimes(%Workingtimes{} = workingtimes, attrs) do
    workingtimes
    |> Workingtimes.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Workingtimes.

  ## Examples

      iex> delete_workingtimes(workingtimes)
      {:ok, %Workingtimes{}}

      iex> delete_workingtimes(workingtimes)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workingtimes(%Workingtimes{} = workingtimes) do
    Repo.delete(workingtimes)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workingtimes changes.

  ## Examples

      iex> change_workingtimes(workingtimes)
      %Ecto.Changeset{source: %Workingtimes{}}

  """
  def change_workingtimes(%Workingtimes{} = workingtimes) do
    Workingtimes.changeset(workingtimes, %{})
  end

  @doc """
  Returns the list of roles.

  ## Examples

      iex> list_roles()
      [%Roles{}, ...]

  """
  def list_roles do
    Repo.all(Roles)
  end

  @doc """
  Gets a single roles.

  Raises `Ecto.NoResultsError` if the Roles does not exist.

  ## Examples

      iex> get_roles!(123)
      %Roles{}

      iex> get_roles!(456)
      ** (Ecto.NoResultsError)

  """
  def get_roles!(id), do: Repo.get!(Roles, id)

  @doc """
  Creates a roles.

  ## Examples

      iex> create_roles(%{field: value})
      {:ok, %Roles{}}

      iex> create_roles(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_roles(attrs \\ %{}) do
    %Roles{}
    |> Roles.changeset(attrs)
    |> Repo.insert()
  end

  def creates_roles(attrs \\ []) do
    Enum.map(attrs, fn(attr) -> create_roles(attr) end)
  end

  @doc """
  Updates a roles.

  ## Examples

      iex> update_roles(roles, %{field: new_value})
      {:ok, %Roles{}}

      iex> update_roles(roles, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_roles(%Roles{} = roles, attrs) do
    roles
    |> Roles.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Roles.

  ## Examples

      iex> delete_roles(roles)
      {:ok, %Roles{}}

      iex> delete_roles(roles)
      {:error, %Ecto.Changeset{}}

  """
  def delete_roles(%Roles{} = roles) do
    Repo.delete(roles)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking roles changes.

  ## Examples

      iex> change_roles(roles)
      %Ecto.Changeset{source: %Roles{}}

  """
  def change_roles(%Roles{} = roles) do
    Roles.changeset(roles, %{})
  end

  alias Worktime.Auth.Teams

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Teams{}, ...]

  """
  def list_teams do
    Repo.all(Teams)
  end

  @doc """
  Gets a single teams.

  Raises `Ecto.NoResultsError` if the Teams does not exist.

  ## Examples

      iex> get_teams!(123)
      %Teams{}

      iex> get_teams!(456)
      ** (Ecto.NoResultsError)

  """
  def get_teams!(id), do: Repo.get!(Teams, id)

  @doc """
  Creates a teams.

  ## Examples

      iex> create_teams(%{field: value})
      {:ok, %Teams{}}

      iex> create_teams(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_teams(attrs \\ %{}) do
    %Teams{}
    |> Teams.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a teams.

  ## Examples

      iex> update_teams(teams, %{field: new_value})
      {:ok, %Teams{}}

      iex> update_teams(teams, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_teams_add(%Teams{} = teams, users) do
    team = Repo.preload(teams, [:users])
    list_users = team.users ++ Enum.map(users, fn u -> Repo.get(Users, u) end)

    team
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:users, list_users)
    |> Repo.update()
  end

  def update_teams_suppr(teamId, list_users) do
    Enum.map(list_users, fn u ->
      users = Repo.get(Users, u)
      user = Repo.preload(users, [:roles, :teams, :clocks, :workingtimes])

      list_teams = Enum.filter(user.teams, fn team -> team.id != teamId end)

      user
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_assoc(:teams, list_teams)
      |> Repo.update!()
    end)
  end

  def change_teams_member(teams, users) do
    team = Repo.preload(teams, [:users])
    list_users = Enum.map(users, fn u -> Repo.get(Users, u) end)

    team
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:users, list_users)
    |> Repo.update()
  end

  def change_teams_manager(teams, managerID) do
    user = Repo.get(Users, managerID)
    if user.roles_id == 2 do
      %{"rep" => "Ce salarié ne peut pas être manager"}
    else
         teams
         |> Teams.changeset(%{"manager_id" => managerID})
         |> Repo.update()
    end
  end

  @doc """
  Deletes a Teams.

  ## Examples

      iex> delete_teams(teams)
      {:ok, %Teams{}}

      iex> delete_teams(teams)
      {:error, %Ecto.Changeset{}}

  """
  def delete_teams(%Teams{} = teams) do
    team = Repo.preload(teams, [:users])

    team
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:users, [])
    |> Repo.update!()
    Repo.delete(teams)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking teams changes.

  ## Examples

      iex> change_teams(teams)
      %Ecto.Changeset{source: %Teams{}}

  """
  def change_teams(%Teams{} = teams) do
    Teams.changeset(teams, %{})
  end

  alias Worktime.Auth.TeamshasUsers

  @doc """
  Returns the list of teamshasusers.

  ## Examples

      iex> list_teamshasusers()
      [%TeamshasUsers{}, ...]

  """
  def list_teamshasusers do
    Repo.all(TeamshasUsers)
  end

  @doc """
  Gets a single teamshas_users.

  Raises `Ecto.NoResultsError` if the Teamshas users does not exist.

  ## Examples

      iex> get_teamshas_users!(123)
      %TeamshasUsers{}

      iex> get_teamshas_users!(456)
      ** (Ecto.NoResultsError)

  """
  def get_teamshas_users!(id), do: Repo.get!(TeamshasUsers, id)

  @doc """
  Creates a teamshas_users.

  ## Examples

      iex> create_teamshas_users(%{field: value})
      {:ok, %TeamshasUsers{}}

      iex> create_teamshas_users(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_teamshas_users(attrs \\ %{}) do
    %TeamshasUsers{}
    |> TeamshasUsers.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a teamshas_users.

  ## Examples

      iex> update_teamshas_users(teamshas_users, %{field: new_value})
      {:ok, %TeamshasUsers{}}

      iex> update_teamshas_users(teamshas_users, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_teamshas_users(%TeamshasUsers{} = teamshas_users, attrs) do
    teamshas_users
    |> TeamshasUsers.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TeamshasUsers.

  ## Examples

      iex> delete_teamshas_users(teamshas_users)
      {:ok, %TeamshasUsers{}}

      iex> delete_teamshas_users(teamshas_users)
      {:error, %Ecto.Changeset{}}

  """
  def delete_teamshas_users(%TeamshasUsers{} = teamshas_users) do
    Repo.delete(teamshas_users)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking teamshas_users changes.

  ## Examples

      iex> change_teamshas_users(teamshas_users)
      %Ecto.Changeset{source: %TeamshasUsers{}}

  """
  def change_teamshas_users(%TeamshasUsers{} = teamshas_users) do
    TeamshasUsers.changeset(teamshas_users, %{})
  end
end
