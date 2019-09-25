defmodule Worktime.AuthTest do
  use Worktime.DataCase

  alias Worktime.Auth

  describe "users" do
    alias Worktime.Auth.Users

    @valid_attrs %{email: "some email", username: "some username"}
    @update_attrs %{email: "some updated email", username: "some updated username"}
    @invalid_attrs %{email: nil, username: nil}

    def users_fixture(attrs \\ %{}) do
      {:ok, users} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_users()

      users
    end

    test "list_users/0 returns all users" do
      users = users_fixture()
      assert Auth.list_users() == [users]
    end

    test "get_users!/1 returns the users with given id" do
      users = users_fixture()
      assert Auth.get_users!(users.id) == users
    end

    test "create_users/1 with valid data creates a users" do
      assert {:ok, %Users{} = users} = Auth.create_users(@valid_attrs)
      assert users.email == "some email"
      assert users.username == "some username"
    end

    test "create_users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_users(@invalid_attrs)
    end

    test "update_users/2 with valid data updates the users" do
      users = users_fixture()
      assert {:ok, %Users{} = users} = Auth.update_users(users, @update_attrs)
      assert users.email == "some updated email"
      assert users.username == "some updated username"
    end

    test "update_users/2 with invalid data returns error changeset" do
      users = users_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_users(users, @invalid_attrs)
      assert users == Auth.get_users!(users.id)
    end

    test "delete_users/1 deletes the users" do
      users = users_fixture()
      assert {:ok, %Users{}} = Auth.delete_users(users)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_users!(users.id) end
    end

    test "change_users/1 returns a users changeset" do
      users = users_fixture()
      assert %Ecto.Changeset{} = Auth.change_users(users)
    end
  end

  describe "clocks" do
    alias Worktime.Auth.Clocks

    @valid_attrs %{time: ~N[2010-04-17 14:00:00]}
    @update_attrs %{time: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{time: nil}

    def clocks_fixture(attrs \\ %{}) do
      {:ok, clocks} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_clocks()

      clocks
    end

    test "list_clocks/0 returns all clocks" do
      clocks = clocks_fixture()
      assert Auth.list_clocks() == [clocks]
    end

    test "get_clocks!/1 returns the clocks with given id" do
      clocks = clocks_fixture()
      assert Auth.get_clocks!(clocks.id) == clocks
    end

    test "create_clocks/1 with valid data creates a clocks" do
      assert {:ok, %Clocks{} = clocks} = Auth.create_clocks(@valid_attrs)
      assert clocks.time == ~N[2010-04-17 14:00:00]
    end

    test "create_clocks/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_clocks(@invalid_attrs)
    end

    test "update_clocks/2 with valid data updates the clocks" do
      clocks = clocks_fixture()
      assert {:ok, %Clocks{} = clocks} = Auth.update_clocks(clocks, @update_attrs)
      assert clocks.time == ~N[2011-05-18 15:01:01]
    end

    test "update_clocks/2 with invalid data returns error changeset" do
      clocks = clocks_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_clocks(clocks, @invalid_attrs)
      assert clocks == Auth.get_clocks!(clocks.id)
    end

    test "delete_clocks/1 deletes the clocks" do
      clocks = clocks_fixture()
      assert {:ok, %Clocks{}} = Auth.delete_clocks(clocks)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_clocks!(clocks.id) end
    end

    test "change_clocks/1 returns a clocks changeset" do
      clocks = clocks_fixture()
      assert %Ecto.Changeset{} = Auth.change_clocks(clocks)
    end
  end

  describe "workingtimes" do
    alias Worktime.Auth.Workingtimes

    @valid_attrs %{end: ~N[2010-04-17 14:00:00], start: ~N[2010-04-17 14:00:00]}
    @update_attrs %{end: ~N[2011-05-18 15:01:01], start: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{end: nil, start: nil}

    def workingtimes_fixture(attrs \\ %{}) do
      {:ok, workingtimes} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_workingtimes()

      workingtimes
    end

    test "list_workingtimes/0 returns all workingtimes" do
      workingtimes = workingtimes_fixture()
      assert Auth.list_workingtimes() == [workingtimes]
    end

    test "get_workingtimes!/1 returns the workingtimes with given id" do
      workingtimes = workingtimes_fixture()
      assert Auth.get_workingtimes!(workingtimes.id) == workingtimes
    end

    test "create_workingtimes/1 with valid data creates a workingtimes" do
      assert {:ok, %Workingtimes{} = workingtimes} = Auth.create_workingtimes(@valid_attrs)
      assert workingtimes.end == ~N[2010-04-17 14:00:00]
      assert workingtimes.start == ~N[2010-04-17 14:00:00]
    end

    test "create_workingtimes/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_workingtimes(@invalid_attrs)
    end

    test "update_workingtimes/2 with valid data updates the workingtimes" do
      workingtimes = workingtimes_fixture()
      assert {:ok, %Workingtimes{} = workingtimes} = Auth.update_workingtimes(workingtimes, @update_attrs)
      assert workingtimes.end == ~N[2011-05-18 15:01:01]
      assert workingtimes.start == ~N[2011-05-18 15:01:01]
    end

    test "update_workingtimes/2 with invalid data returns error changeset" do
      workingtimes = workingtimes_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_workingtimes(workingtimes, @invalid_attrs)
      assert workingtimes == Auth.get_workingtimes!(workingtimes.id)
    end

    test "delete_workingtimes/1 deletes the workingtimes" do
      workingtimes = workingtimes_fixture()
      assert {:ok, %Workingtimes{}} = Auth.delete_workingtimes(workingtimes)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_workingtimes!(workingtimes.id) end
    end

    test "change_workingtimes/1 returns a workingtimes changeset" do
      workingtimes = workingtimes_fixture()
      assert %Ecto.Changeset{} = Auth.change_workingtimes(workingtimes)
    end
  end

  describe "roles" do
    alias Worktime.Auth.Roles

    @valid_attrs %{label: "some label", status: 42}
    @update_attrs %{label: "some updated label", status: 43}
    @invalid_attrs %{label: nil, status: nil}

    def roles_fixture(attrs \\ %{}) do
      {:ok, roles} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_roles()

      roles
    end

    test "list_roles/0 returns all roles" do
      roles = roles_fixture()
      assert Auth.list_roles() == [roles]
    end

    test "get_roles!/1 returns the roles with given id" do
      roles = roles_fixture()
      assert Auth.get_roles!(roles.id) == roles
    end

    test "create_roles/1 with valid data creates a roles" do
      assert {:ok, %Roles{} = roles} = Auth.create_roles(@valid_attrs)
      assert roles.label == "some label"
      assert roles.status == 42
    end

    test "create_roles/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_roles(@invalid_attrs)
    end

    test "update_roles/2 with valid data updates the roles" do
      roles = roles_fixture()
      assert {:ok, %Roles{} = roles} = Auth.update_roles(roles, @update_attrs)
      assert roles.label == "some updated label"
      assert roles.status == 43
    end

    test "update_roles/2 with invalid data returns error changeset" do
      roles = roles_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_roles(roles, @invalid_attrs)
      assert roles == Auth.get_roles!(roles.id)
    end

    test "delete_roles/1 deletes the roles" do
      roles = roles_fixture()
      assert {:ok, %Roles{}} = Auth.delete_roles(roles)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_roles!(roles.id) end
    end

    test "change_roles/1 returns a roles changeset" do
      roles = roles_fixture()
      assert %Ecto.Changeset{} = Auth.change_roles(roles)
    end
  end

  describe "teams" do
    alias Worktime.Auth.Teams

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def teams_fixture(attrs \\ %{}) do
      {:ok, teams} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_teams()

      teams
    end

    test "list_teams/0 returns all teams" do
      teams = teams_fixture()
      assert Auth.list_teams() == [teams]
    end

    test "get_teams!/1 returns the teams with given id" do
      teams = teams_fixture()
      assert Auth.get_teams!(teams.id) == teams
    end

    test "create_teams/1 with valid data creates a teams" do
      assert {:ok, %Teams{} = teams} = Auth.create_teams(@valid_attrs)
      assert teams.name == "some name"
    end

    test "create_teams/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_teams(@invalid_attrs)
    end

    test "update_teams/2 with valid data updates the teams" do
      teams = teams_fixture()
      assert {:ok, %Teams{} = teams} = Auth.update_teams(teams, @update_attrs)
      assert teams.name == "some updated name"
    end

    test "update_teams/2 with invalid data returns error changeset" do
      teams = teams_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_teams(teams, @invalid_attrs)
      assert teams == Auth.get_teams!(teams.id)
    end

    test "delete_teams/1 deletes the teams" do
      teams = teams_fixture()
      assert {:ok, %Teams{}} = Auth.delete_teams(teams)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_teams!(teams.id) end
    end

    test "change_teams/1 returns a teams changeset" do
      teams = teams_fixture()
      assert %Ecto.Changeset{} = Auth.change_teams(teams)
    end
  end

  describe "teamshasusers" do
    alias Worktime.Auth.TeamshasUsers

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def teamshas_users_fixture(attrs \\ %{}) do
      {:ok, teamshas_users} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_teamshas_users()

      teamshas_users
    end

    test "list_teamshasusers/0 returns all teamshasusers" do
      teamshas_users = teamshas_users_fixture()
      assert Auth.list_teamshasusers() == [teamshas_users]
    end

    test "get_teamshas_users!/1 returns the teamshas_users with given id" do
      teamshas_users = teamshas_users_fixture()
      assert Auth.get_teamshas_users!(teamshas_users.id) == teamshas_users
    end

    test "create_teamshas_users/1 with valid data creates a teamshas_users" do
      assert {:ok, %TeamshasUsers{} = teamshas_users} = Auth.create_teamshas_users(@valid_attrs)
    end

    test "create_teamshas_users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_teamshas_users(@invalid_attrs)
    end

    test "update_teamshas_users/2 with valid data updates the teamshas_users" do
      teamshas_users = teamshas_users_fixture()
      assert {:ok, %TeamshasUsers{} = teamshas_users} = Auth.update_teamshas_users(teamshas_users, @update_attrs)
    end

    test "update_teamshas_users/2 with invalid data returns error changeset" do
      teamshas_users = teamshas_users_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_teamshas_users(teamshas_users, @invalid_attrs)
      assert teamshas_users == Auth.get_teamshas_users!(teamshas_users.id)
    end

    test "delete_teamshas_users/1 deletes the teamshas_users" do
      teamshas_users = teamshas_users_fixture()
      assert {:ok, %TeamshasUsers{}} = Auth.delete_teamshas_users(teamshas_users)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_teamshas_users!(teamshas_users.id) end
    end

    test "change_teamshas_users/1 returns a teamshas_users changeset" do
      teamshas_users = teamshas_users_fixture()
      assert %Ecto.Changeset{} = Auth.change_teamshas_users(teamshas_users)
    end
  end
end
