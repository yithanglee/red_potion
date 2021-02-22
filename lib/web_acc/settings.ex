defmodule WebAcc.Settings do
  @moduledoc """
  The Settings context.
  """

  import Ecto.Query, warn: false
  alias WebAcc.Repo
  require IEx

  alias WebAcc.Settings.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    a =
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()

    case a do
      {:ok, model} ->
        WebAccWeb.Endpoint.broadcast("user:lobby", "model_update", %{
          source: model.__meta__.source,
          data: Utility.s_to_map(model)
        })

      _ ->
        nil
    end

    a
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    a =
      user
      |> User.changeset(attrs)
      |> Repo.update()

    case a do
      {:ok, model} ->
        WebAccWeb.Endpoint.broadcast("user:lobby", "model_update", %{
          source: model.__meta__.source,
          data: Utility.s_to_map(model)
        })

      _ ->
        nil
    end

    a
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias WebAcc.Settings.Role

  @doc """
  Returns the list of roles.

  ## Examples

      iex> list_roles()
      [%Role{}, ...]

  """
  def list_roles do
    Repo.all(Role)
  end

  @doc """
  Gets a single role.

  Raises `Ecto.NoResultsError` if the Role does not exist.

  ## Examples

      iex> get_role!(123)
      %Role{}

      iex> get_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role!(id), do: Repo.get!(Role, id)

  @doc """
  Creates a role.

  ## Examples

      iex> create_role(%{field: value})
      {:ok, %Role{}}

      iex> create_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role(attrs \\ %{}) do
    a =
      %Role{}
      |> Role.changeset(attrs)
      |> Repo.insert()

    case a do
      {:ok, model} ->
        WebAccWeb.Endpoint.broadcast("user:lobby", "model_update", %{
          source: model.__meta__.source,
          data: Utility.s_to_map(model)
        })

      _ ->
        nil
    end

    a
  end

  @doc """
  Updates a role.

  ## Examples

      iex> update_role(role, %{field: new_value})
      {:ok, %Role{}}

      iex> update_role(role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role(%Role{} = role, attrs) do
    a =
      role
      |> Role.changeset(attrs)
      |> Repo.update()

    case a do
      {:ok, model} ->
        WebAccWeb.Endpoint.broadcast("user:lobby", "model_update", %{
          source: model.__meta__.source,
          data: Utility.s_to_map(model)
        })

      _ ->
        nil
    end

    a
  end

  @doc """
  Deletes a role.

  ## Examples

      iex> delete_role(role)
      {:ok, %Role{}}

      iex> delete_role(role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking role changes.

  ## Examples

      iex> change_role(role)
      %Ecto.Changeset{source: %Role{}}

  """
  def change_role(%Role{} = role) do
    Role.changeset(role, %{})
  end

  alias WebAcc.Settings.Menu

  @doc """
  Returns the list of menus.

  ## Examples

      iex> list_menus()
      [%Menu{}, ...]

  """
  def list_menus do
    Repo.all(Menu)
  end

  @doc """
  Gets a single menu.

  Raises `Ecto.NoResultsError` if the Menu does not exist.

  ## Examples

      iex> get_menu!(123)
      %Menu{}

      iex> get_menu!(456)
      ** (Ecto.NoResultsError)

  """
  def get_menu!(id), do: Repo.get!(Menu, id)

  @doc """
  Creates a menu.

  ## Examples

      iex> create_menu(%{field: value})
      {:ok, %Menu{}}

      iex> create_menu(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_menu(attrs \\ %{}) do
    a =
      %Menu{}
      |> Menu.changeset(attrs)
      |> Repo.insert()

    case a do
      {:ok, model} ->
        WebAccWeb.Endpoint.broadcast("user:lobby", "model_update", %{
          source: model.__meta__.source,
          data: Utility.s_to_map(model)
        })

        Repo.all(from(m in Menu))
        |> Enum.map(fn x -> Utility.s_to_map(x) end)
        |> Jason.encode!()
        |> Utility.write_json("menu.json")

      _ ->
        nil
    end

    a
  end

  @doc """
  Updates a menu.

  ## Examples

      iex> update_menu(menu, %{field: new_value})
      {:ok, %Menu{}}

      iex> update_menu(menu, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_menu(%Menu{} = menu, attrs) do
    a =
      menu
      |> Menu.changeset(attrs)
      |> Repo.update()

    case a do
      {:ok, model} ->
        WebAccWeb.Endpoint.broadcast("user:lobby", "model_update", %{
          source: model.__meta__.source,
          data: Utility.s_to_map(model)
        })

        Repo.all(from(m in Menu))
        |> Enum.map(fn x -> Utility.s_to_map(x) end)
        |> Jason.encode!()
        |> Utility.write_json("menu.json")

      _ ->
        nil
    end

    a
  end

  @doc """
  Deletes a menu.

  ## Examples

      iex> delete_menu(menu)
      {:ok, %Menu{}}

      iex> delete_menu(menu)
      {:error, %Ecto.Changeset{}}

  """
  def delete_menu(%Menu{} = menu) do
    Repo.delete(menu)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking menu changes.

  ## Examples

      iex> change_menu(menu)
      %Ecto.Changeset{source: %Menu{}}

  """
  def change_menu(%Menu{} = menu) do
    Menu.changeset(menu, %{})
  end

  alias WebAcc.Settings.RoleMenu

  @doc """
  Returns the list of role_menus.

  ## Examples

      iex> list_role_menus()
      [%RoleMenu{}, ...]

  """
  def list_role_menus do
    Repo.all(RoleMenu)
  end

  @doc """
  Gets a single role_menu.

  Raises `Ecto.NoResultsError` if the Role menu does not exist.

  ## Examples

      iex> get_role_menu!(123)
      %RoleMenu{}

      iex> get_role_menu!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role_menu!(id), do: Repo.get!(RoleMenu, id)

  @doc """
  Creates a role_menu.

  ## Examples

      iex> create_role_menu(%{field: value})
      {:ok, %RoleMenu{}}

      iex> create_role_menu(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role_menu(attrs \\ %{}) do
    a =
      %RoleMenu{}
      |> RoleMenu.changeset(attrs)
      |> Repo.insert()

    case a do
      {:ok, model} ->
        WebAccWeb.Endpoint.broadcast("user:lobby", "model_update", %{
          source: model.__meta__.source,
          data: Utility.s_to_map(model)
        })

      _ ->
        nil
    end

    a
  end

  @doc """
  Updates a role_menu.

  ## Examples

      iex> update_role_menu(role_menu, %{field: new_value})
      {:ok, %RoleMenu{}}

      iex> update_role_menu(role_menu, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role_menu(%RoleMenu{} = role_menu, attrs) do
    a =
      role_menu
      |> RoleMenu.changeset(attrs)
      |> Repo.update()

    case a do
      {:ok, model} ->
        WebAccWeb.Endpoint.broadcast("user:lobby", "model_update", %{
          source: model.__meta__.source,
          data: Utility.s_to_map(model)
        })

      _ ->
        nil
    end

    a
  end

  @doc """
  Deletes a role_menu.

  ## Examples

      iex> delete_role_menu(role_menu)
      {:ok, %RoleMenu{}}

      iex> delete_role_menu(role_menu)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role_menu(%RoleMenu{} = role_menu) do
    Repo.delete(role_menu)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking role_menu changes.

  ## Examples

      iex> change_role_menu(role_menu)
      %Ecto.Changeset{source: %RoleMenu{}}

  """
  def change_role_menu(%RoleMenu{} = role_menu) do
    RoleMenu.changeset(role_menu, %{})
  end
end
