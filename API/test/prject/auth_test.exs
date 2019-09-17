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
end
