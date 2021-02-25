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

  alias WebAcc.Settings.Location

  @doc """
  Returns the list of locations.

  ## Examples

      iex> list_locations()
      [%Location{}, ...]

  """
  def list_locations do
    Repo.all(Location)
  end

  @doc """
  Gets a single location.

  Raises `Ecto.NoResultsError` if the Location does not exist.

  ## Examples

      iex> get_location!(123)
      %Location{}

      iex> get_location!(456)
      ** (Ecto.NoResultsError)

  """
  def get_location!(id), do: Repo.get!(Location, id)

  @doc """
  Creates a location.

  ## Examples

      iex> create_location(%{field: value})
      {:ok, %Location{}}

      iex> create_location(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_location(attrs \\ %{}) do
    a =
      %Location{}
      |> Location.changeset(attrs)
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
  Updates a location.

  ## Examples

      iex> update_location(location, %{field: new_value})
      {:ok, %Location{}}

      iex> update_location(location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_location(%Location{} = location, attrs) do
    a =
      location
      |> Location.changeset(attrs)
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
  Deletes a location.

  ## Examples

      iex> delete_location(location)
      {:ok, %Location{}}

      iex> delete_location(location)
      {:error, %Ecto.Changeset{}}

  """
  def delete_location(%Location{} = location) do
    Repo.delete(location)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking location changes.

  ## Examples

      iex> change_location(location)
      %Ecto.Changeset{source: %Location{}}

  """
  def change_location(%Location{} = location) do
    Location.changeset(location, %{})
  end

  alias WebAcc.Settings.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    a =
      %Product{}
      |> Product.changeset(attrs)
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
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    a =
      product
      |> Product.changeset(attrs)
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
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{source: %Product{}}

  """
  def change_product(%Product{} = product) do
    Product.changeset(product, %{})
  end

  alias WebAcc.Settings.StockLevel

  @doc """
  Returns the list of stock_levels.

  ## Examples

      iex> list_stock_levels()
      [%StockLevel{}, ...]

  """
  def list_stock_levels do
    Repo.all(StockLevel)
  end

  @doc """
  Gets a single stock_level.

  Raises `Ecto.NoResultsError` if the Stock level does not exist.

  ## Examples

      iex> get_stock_level!(123)
      %StockLevel{}

      iex> get_stock_level!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stock_level!(id), do: Repo.get!(StockLevel, id)

  @doc """
  Creates a stock_level.

  ## Examples

      iex> create_stock_level(%{field: value})
      {:ok, %StockLevel{}}

      iex> create_stock_level(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stock_level(attrs \\ %{}) do
    a =
      %StockLevel{}
      |> StockLevel.changeset(attrs)
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
  Updates a stock_level.

  ## Examples

      iex> update_stock_level(stock_level, %{field: new_value})
      {:ok, %StockLevel{}}

      iex> update_stock_level(stock_level, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stock_level(%StockLevel{} = stock_level, attrs) do
    a =
      stock_level
      |> StockLevel.changeset(attrs)
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
  Deletes a stock_level.

  ## Examples

      iex> delete_stock_level(stock_level)
      {:ok, %StockLevel{}}

      iex> delete_stock_level(stock_level)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stock_level(%StockLevel{} = stock_level) do
    Repo.delete(stock_level)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stock_level changes.

  ## Examples

      iex> change_stock_level(stock_level)
      %Ecto.Changeset{source: %StockLevel{}}

  """
  def change_stock_level(%StockLevel{} = stock_level) do
    StockLevel.changeset(stock_level, %{})
  end

  alias WebAcc.Settings.StockMovement

  @doc """
  Returns the list of stock_movements.

  ## Examples

      iex> list_stock_movements()
      [%StockMovement{}, ...]

  """
  def list_stock_movements do
    Repo.all(StockMovement)
  end

  @doc """
  Gets a single stock_movement.

  Raises `Ecto.NoResultsError` if the Stock movement does not exist.

  ## Examples

      iex> get_stock_movement!(123)
      %StockMovement{}

      iex> get_stock_movement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stock_movement!(id), do: Repo.get!(StockMovement, id)

  def count_inventory(action, acc) do
    actions = [
      "adjust_out",
      "adjust_in",
      "repack_to",
      "repack_from",
      "ordered",
      "received",
      "booked",
      "canceled",
      "sold",
      "pos_sold"
    ]

    final =
      case action.action do
        "adjust_out" ->
          %{
            onhand: acc.onhand - action.qty,
            ordered: acc.ordered,
            available: acc.available - action.qty
          }

        "adjust_in" ->
          %{
            onhand: acc.onhand + action.qty,
            ordered: acc.ordered,
            available: acc.available + action.qty
          }

        "repack_to" ->
          %{
            onhand: acc.onhand + action.qty,
            ordered: acc.ordered,
            available: acc.available + action.qty
          }

        "repack_from" ->
          %{
            onhand: acc.onhand - action.qty,
            ordered: acc.ordered,
            available: acc.available - action.qty
          }

        "ordered" ->
          %{
            onhand: acc.onhand,
            ordered: acc.ordered + action.qty,
            available: acc.available
          }

        "received" ->
          %{
            onhand: acc.onhand + action.qty,
            ordered: acc.ordered - action.qty,
            available: acc.available + action.qty
          }

        "canceled" ->
          %{
            onhand: acc.onhand,
            ordered: acc.ordered,
            available: acc.available + action.qty
          }

        "sold" ->
          %{
            onhand: acc.onhand - action.qty,
            ordered: acc.ordered,
            available: acc.available - action.qty
          }

        "pos_sold" ->
          %{
            onhand: acc.onhand - action.qty,
            ordered: acc.ordered,
            available: acc.available - action.qty
          }

        _ ->
          acc
      end
  end

  @doc """
  Creates a stock_movement.

  ## Examples

      iex> create_stock_movement(%{field: value})
      {:ok, %StockMovement{}}

      iex> create_stock_movement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stock_movement(attrs \\ %{}) do
    a =
      %StockMovement{}
      |> StockMovement.changeset(attrs)
      |> Repo.insert()

    case a do
      {:ok, model} ->
        WebAccWeb.Endpoint.broadcast("user:lobby", "model_update", %{
          source: model.__meta__.source,
          data: Utility.s_to_map(model)
        })

        item =
          WebAcc.Repo.get_by(WebAcc.Settings.StockLevel,
            product_id: model.product_id,
            location_id: model.location_id
          )

        item =
          if item == nil do
            {:ok, sl} =
              WebAcc.Settings.create_stock_level(%{
                product_id: model.product_id,
                location_id: model.location_id
              })

            sl
          else
            item
          end

        # here update the stock levels 
        actions =
          Repo.all(
            from(
              s in StockMovement,
              where: s.product_id == ^item.product_id and s.location_id == ^item.location_id,
              select: %{action: s.action, qty: sum(s.quantity)},
              group_by: [s.action]
            )
          )

        final_qty =
          Enum.reduce(
            actions,
            %{onhand: 0, ordered: 0, available: 0},
            fn list_item, acc ->
              count_inventory(list_item, acc)
            end
          )

        case WebAcc.Settings.update_stock_level(item, final_qty) do
          {:ok, item} ->
            IO.inspect(item)
            nil

          {:error, cg} ->
            nil
        end

      _ ->
        nil
    end

    a
  end

  @doc """
  Updates a stock_movement.

  ## Examples

      iex> update_stock_movement(stock_movement, %{field: new_value})
      {:ok, %StockMovement{}}

      iex> update_stock_movement(stock_movement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stock_movement(%StockMovement{} = stock_movement, attrs) do
    a =
      stock_movement
      |> StockMovement.changeset(attrs)
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
  Deletes a stock_movement.

  ## Examples

      iex> delete_stock_movement(stock_movement)
      {:ok, %StockMovement{}}

      iex> delete_stock_movement(stock_movement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stock_movement(%StockMovement{} = stock_movement) do
    Repo.delete(stock_movement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stock_movement changes.

  ## Examples

      iex> change_stock_movement(stock_movement)
      %Ecto.Changeset{source: %StockMovement{}}

  """
  def change_stock_movement(%StockMovement{} = stock_movement) do
    StockMovement.changeset(stock_movement, %{})
  end

  alias WebAcc.Settings.Supplier

  @doc """
  Returns the list of suppliers.

  ## Examples

      iex> list_suppliers()
      [%Supplier{}, ...]

  """
  def list_suppliers do
    Repo.all(Supplier)
  end

  @doc """
  Gets a single supplier.

  Raises `Ecto.NoResultsError` if the Supplier does not exist.

  ## Examples

      iex> get_supplier!(123)
      %Supplier{}

      iex> get_supplier!(456)
      ** (Ecto.NoResultsError)

  """
  def get_supplier!(id), do: Repo.get!(Supplier, id)

  @doc """
  Creates a supplier.

  ## Examples

      iex> create_supplier(%{field: value})
      {:ok, %Supplier{}}

      iex> create_supplier(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_supplier(attrs \\ %{}) do
    a =
      %Supplier{}
      |> Supplier.changeset(attrs)
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
  Updates a supplier.

  ## Examples

      iex> update_supplier(supplier, %{field: new_value})
      {:ok, %Supplier{}}

      iex> update_supplier(supplier, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_supplier(%Supplier{} = supplier, attrs) do
    a =
      supplier
      |> Supplier.changeset(attrs)
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
  Deletes a supplier.

  ## Examples

      iex> delete_supplier(supplier)
      {:ok, %Supplier{}}

      iex> delete_supplier(supplier)
      {:error, %Ecto.Changeset{}}

  """
  def delete_supplier(%Supplier{} = supplier) do
    Repo.delete(supplier)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking supplier changes.

  ## Examples

      iex> change_supplier(supplier)
      %Ecto.Changeset{source: %Supplier{}}

  """
  def change_supplier(%Supplier{} = supplier) do
    Supplier.changeset(supplier, %{})
  end

  alias WebAcc.Settings.SupplierProduct

  @doc """
  Returns the list of supplier_products.

  ## Examples

      iex> list_supplier_products()
      [%SupplierProduct{}, ...]

  """
  def list_supplier_products do
    Repo.all(SupplierProduct)
  end

  @doc """
  Gets a single supplier_product.

  Raises `Ecto.NoResultsError` if the Supplier product does not exist.

  ## Examples

      iex> get_supplier_product!(123)
      %SupplierProduct{}

      iex> get_supplier_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_supplier_product!(id), do: Repo.get!(SupplierProduct, id)

  @doc """
  Creates a supplier_product.

  ## Examples

      iex> create_supplier_product(%{field: value})
      {:ok, %SupplierProduct{}}

      iex> create_supplier_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_supplier_product(attrs \\ %{}) do
    a =
      %SupplierProduct{}
      |> SupplierProduct.changeset(attrs)
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
  Updates a supplier_product.

  ## Examples

      iex> update_supplier_product(supplier_product, %{field: new_value})
      {:ok, %SupplierProduct{}}

      iex> update_supplier_product(supplier_product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_supplier_product(%SupplierProduct{} = supplier_product, attrs) do
    a =
      supplier_product
      |> SupplierProduct.changeset(attrs)
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
  Deletes a supplier_product.

  ## Examples

      iex> delete_supplier_product(supplier_product)
      {:ok, %SupplierProduct{}}

      iex> delete_supplier_product(supplier_product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_supplier_product(%SupplierProduct{} = supplier_product) do
    Repo.delete(supplier_product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking supplier_product changes.

  ## Examples

      iex> change_supplier_product(supplier_product)
      %Ecto.Changeset{source: %SupplierProduct{}}

  """
  def change_supplier_product(%SupplierProduct{} = supplier_product) do
    SupplierProduct.changeset(supplier_product, %{})
  end

  alias WebAcc.Settings.PurchaseOrder

  @doc """
  Returns the list of purchase_orders.

  ## Examples

      iex> list_purchase_orders()
      [%PurchaseOrder{}, ...]

  """
  def list_purchase_orders do
    Repo.all(PurchaseOrder)
  end

  @doc """
  Gets a single purchase_order.

  Raises `Ecto.NoResultsError` if the Purchase order does not exist.

  ## Examples

      iex> get_purchase_order!(123)
      %PurchaseOrder{}

      iex> get_purchase_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_purchase_order!(id), do: Repo.get!(PurchaseOrder, id)

  def order_pom_task(model) do
    pom = Repo.get(WebAcc.Settings.PurchaseOrderMaster, model.pom_id)

    create_stock_movement(%{
      action: "ordered",
      location_id: pom.location_id,
      product_id: model.product_id,
      quantity: model.quantity,
      reference: pom.po_no
    })
  end

  @doc """
  Creates a purchase_order.

  ## Examples

      iex> create_purchase_order(%{field: value})
      {:ok, %PurchaseOrder{}}

      iex> create_purchase_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_purchase_order(attrs \\ %{}) do
    a =
      %PurchaseOrder{}
      |> PurchaseOrder.changeset(attrs)
      |> Repo.insert()

    case a do
      {:ok, model} ->
        WebAccWeb.Endpoint.broadcast("user:lobby", "model_update", %{
          source: model.__meta__.source,
          data: Utility.s_to_map(model)
        })

        Task.start_link(__MODULE__, :order_pom_task, [model])

      _ ->
        nil
    end

    a
  end

  @doc """
  Updates a purchase_order.

  ## Examples

      iex> update_purchase_order(purchase_order, %{field: new_value})
      {:ok, %PurchaseOrder{}}

      iex> update_purchase_order(purchase_order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_purchase_order(%PurchaseOrder{} = purchase_order, attrs) do
    a =
      purchase_order
      |> PurchaseOrder.changeset(attrs)
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
  Deletes a purchase_order.

  ## Examples

      iex> delete_purchase_order(purchase_order)
      {:ok, %PurchaseOrder{}}

      iex> delete_purchase_order(purchase_order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_purchase_order(%PurchaseOrder{} = purchase_order) do
    Repo.delete(purchase_order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking purchase_order changes.

  ## Examples

      iex> change_purchase_order(purchase_order)
      %Ecto.Changeset{source: %PurchaseOrder{}}

  """
  def change_purchase_order(%PurchaseOrder{} = purchase_order) do
    PurchaseOrder.changeset(purchase_order, %{})
  end

  alias WebAcc.Settings.PurchaseOrderMaster

  @doc """
  Returns the list of purchase_order_masters.

  ## Examples

      iex> list_purchase_order_masters()
      [%PurchaseOrderMaster{}, ...]

  """
  def list_purchase_order_masters do
    Repo.all(PurchaseOrderMaster)
  end

  @doc """
  Gets a single purchase_order_master.

  Raises `Ecto.NoResultsError` if the Purchase order master does not exist.

  ## Examples

      iex> get_purchase_order_master!(123)
      %PurchaseOrderMaster{}

      iex> get_purchase_order_master!(456)
      ** (Ecto.NoResultsError)

  """
  def get_purchase_order_master!(id), do: Repo.get!(PurchaseOrderMaster, id)

  @doc """
  Creates a purchase_order_master.

  ## Examples

      iex> create_purchase_order_master(%{field: value})
      {:ok, %PurchaseOrderMaster{}}

      iex> create_purchase_order_master(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_purchase_order_master(attrs \\ %{}) do
    a =
      %PurchaseOrderMaster{}
      |> PurchaseOrderMaster.changeset(attrs)
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
  Updates a purchase_order_master.

  ## Examples

      iex> update_purchase_order_master(purchase_order_master, %{field: new_value})
      {:ok, %PurchaseOrderMaster{}}

      iex> update_purchase_order_master(purchase_order_master, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_purchase_order_master(%PurchaseOrderMaster{} = purchase_order_master, attrs) do
    a =
      purchase_order_master
      |> PurchaseOrderMaster.changeset(attrs)
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
  Deletes a purchase_order_master.

  ## Examples

      iex> delete_purchase_order_master(purchase_order_master)
      {:ok, %PurchaseOrderMaster{}}

      iex> delete_purchase_order_master(purchase_order_master)
      {:error, %Ecto.Changeset{}}

  """
  def delete_purchase_order_master(%PurchaseOrderMaster{} = purchase_order_master) do
    Repo.delete(purchase_order_master)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking purchase_order_master changes.

  ## Examples

      iex> change_purchase_order_master(purchase_order_master)
      %Ecto.Changeset{source: %PurchaseOrderMaster{}}

  """
  def change_purchase_order_master(%PurchaseOrderMaster{} = purchase_order_master) do
    PurchaseOrderMaster.changeset(purchase_order_master, %{})
  end

  alias WebAcc.Settings.StockReceive

  @doc """
  Returns the list of stock_receives.

  ## Examples

      iex> list_stock_receives()
      [%StockReceive{}, ...]

  """
  def list_stock_receives do
    Repo.all(StockReceive)
  end

  @doc """
  Gets a single stock_receive.

  Raises `Ecto.NoResultsError` if the Stock receive does not exist.

  ## Examples

      iex> get_stock_receive!(123)
      %StockReceive{}

      iex> get_stock_receive!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stock_receive!(id), do: Repo.get!(StockReceive, id)

  def pom_task(model) do
    pom = Repo.get(PurchaseOrderMaster, model.pom_id)

    create_stock_movement(%{
      action: "received",
      location_id: pom.location_id,
      product_id: model.product_id,
      quantity: model.quantity,
      reference: pom.po_no
    })
  end

  @doc """
  Creates a stock_receive.

  ## Examples

      iex> create_stock_receive(%{field: value})
      {:ok, %StockReceive{}}

      iex> create_stock_receive(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stock_receive(attrs \\ %{}) do
    a =
      %StockReceive{}
      |> StockReceive.changeset(attrs)
      |> Repo.insert()

    case a do
      {:ok, model} ->
        WebAccWeb.Endpoint.broadcast("user:lobby", "model_update", %{
          source: model.__meta__.source,
          data: Utility.s_to_map(model)
        })

        # here create the stock movement

        Task.start_link(__MODULE__, :pom_task, [model])

      _ ->
        nil
    end

    a
  end

  @doc """
  Updates a stock_receive.

  ## Examples

      iex> update_stock_receive(stock_receive, %{field: new_value})
      {:ok, %StockReceive{}}

      iex> update_stock_receive(stock_receive, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stock_receive(%StockReceive{} = stock_receive, attrs) do
    a =
      stock_receive
      |> StockReceive.changeset(attrs)
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
  Deletes a stock_receive.

  ## Examples

      iex> delete_stock_receive(stock_receive)
      {:ok, %StockReceive{}}

      iex> delete_stock_receive(stock_receive)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stock_receive(%StockReceive{} = stock_receive) do
    Repo.delete(stock_receive)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stock_receive changes.

  ## Examples

      iex> change_stock_receive(stock_receive)
      %Ecto.Changeset{source: %StockReceive{}}

  """
  def change_stock_receive(%StockReceive{} = stock_receive) do
    StockReceive.changeset(stock_receive, %{})
  end

  alias WebAcc.Settings.StockReceiveMaster

  @doc """
  Returns the list of stock_receive_masters.

  ## Examples

      iex> list_stock_receive_masters()
      [%StockReceiveMaster{}, ...]

  """
  def list_stock_receive_masters do
    Repo.all(StockReceiveMaster)
  end

  @doc """
  Gets a single stock_receive_master.

  Raises `Ecto.NoResultsError` if the Stock receive master does not exist.

  ## Examples

      iex> get_stock_receive_master!(123)
      %StockReceiveMaster{}

      iex> get_stock_receive_master!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stock_receive_master!(id), do: Repo.get!(StockReceiveMaster, id)

  @doc """
  Creates a stock_receive_master.

  ## Examples

      iex> create_stock_receive_master(%{field: value})
      {:ok, %StockReceiveMaster{}}

      iex> create_stock_receive_master(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stock_receive_master(attrs \\ %{}) do
    a =
      %StockReceiveMaster{}
      |> StockReceiveMaster.changeset(attrs)
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
  Updates a stock_receive_master.

  ## Examples

      iex> update_stock_receive_master(stock_receive_master, %{field: new_value})
      {:ok, %StockReceiveMaster{}}

      iex> update_stock_receive_master(stock_receive_master, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stock_receive_master(%StockReceiveMaster{} = stock_receive_master, attrs) do
    a =
      stock_receive_master
      |> StockReceiveMaster.changeset(attrs)
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
  Deletes a stock_receive_master.

  ## Examples

      iex> delete_stock_receive_master(stock_receive_master)
      {:ok, %StockReceiveMaster{}}

      iex> delete_stock_receive_master(stock_receive_master)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stock_receive_master(%StockReceiveMaster{} = stock_receive_master) do
    Repo.delete(stock_receive_master)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stock_receive_master changes.

  ## Examples

      iex> change_stock_receive_master(stock_receive_master)
      %Ecto.Changeset{source: %StockReceiveMaster{}}

  """
  def change_stock_receive_master(%StockReceiveMaster{} = stock_receive_master) do
    StockReceiveMaster.changeset(stock_receive_master, %{})
  end

  alias WebAcc.Settings.SalesOrderMaster

  @doc """
  Returns the list of sales_order_masters.

  ## Examples

      iex> list_sales_order_masters()
      [%SalesOrderMaster{}, ...]

  """
  def list_sales_order_masters do
    Repo.all(SalesOrderMaster)
  end

  @doc """
  Gets a single sales_order_master.

  Raises `Ecto.NoResultsError` if the Sales order master does not exist.

  ## Examples

      iex> get_sales_order_master!(123)
      %SalesOrderMaster{}

      iex> get_sales_order_master!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sales_order_master!(id), do: Repo.get!(SalesOrderMaster, id)

  @doc """
  Creates a sales_order_master.

  ## Examples

      iex> create_sales_order_master(%{field: value})
      {:ok, %SalesOrderMaster{}}

      iex> create_sales_order_master(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sales_order_master(attrs \\ %{}) do
    a =
      %SalesOrderMaster{}
      |> SalesOrderMaster.changeset(attrs)
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
  Updates a sales_order_master.

  ## Examples

      iex> update_sales_order_master(sales_order_master, %{field: new_value})
      {:ok, %SalesOrderMaster{}}

      iex> update_sales_order_master(sales_order_master, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sales_order_master(%SalesOrderMaster{} = sales_order_master, attrs) do
    a =
      sales_order_master
      |> SalesOrderMaster.changeset(attrs)
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
  Deletes a sales_order_master.

  ## Examples

      iex> delete_sales_order_master(sales_order_master)
      {:ok, %SalesOrderMaster{}}

      iex> delete_sales_order_master(sales_order_master)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sales_order_master(%SalesOrderMaster{} = sales_order_master) do
    Repo.delete(sales_order_master)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sales_order_master changes.

  ## Examples

      iex> change_sales_order_master(sales_order_master)
      %Ecto.Changeset{source: %SalesOrderMaster{}}

  """
  def change_sales_order_master(%SalesOrderMaster{} = sales_order_master) do
    SalesOrderMaster.changeset(sales_order_master, %{})
  end

  alias WebAcc.Settings.SalesOrder

  @doc """
  Returns the list of sales_orders.

  ## Examples

      iex> list_sales_orders()
      [%SalesOrder{}, ...]

  """
  def list_sales_orders do
    Repo.all(SalesOrder)
  end

  @doc """
  Gets a single sales_order.

  Raises `Ecto.NoResultsError` if the Sales order does not exist.

  ## Examples

      iex> get_sales_order!(123)
      %SalesOrder{}

      iex> get_sales_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sales_order!(id), do: Repo.get!(SalesOrder, id)

  def order_som_task(model) do
    som = Repo.get(WebAcc.Settings.SalesOrderMaster, model.som_id)

    create_stock_movement(%{
      action: "sold",
      location_id: som.location_id,
      product_id: model.product_id,
      quantity: model.quantity,
      reference: "SO#{som.id}"
    })
  end

  @doc """
  Creates a sales_order.

  ## Examples

      iex> create_sales_order(%{field: value})
      {:ok, %SalesOrder{}}

      iex> create_sales_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sales_order(attrs \\ %{}) do
    a =
      %SalesOrder{}
      |> SalesOrder.changeset(attrs)
      |> Repo.insert()

    case a do
      {:ok, model} ->
        WebAccWeb.Endpoint.broadcast("user:lobby", "model_update", %{
          source: model.__meta__.source,
          data: Utility.s_to_map(model)
        })

        Task.start_link(__MODULE__, :order_som_task, [model])

      _ ->
        nil
    end

    a
  end

  @doc """
  Updates a sales_order.

  ## Examples

      iex> update_sales_order(sales_order, %{field: new_value})
      {:ok, %SalesOrder{}}

      iex> update_sales_order(sales_order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sales_order(%SalesOrder{} = sales_order, attrs) do
    a =
      sales_order
      |> SalesOrder.changeset(attrs)
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
  Deletes a sales_order.

  ## Examples

      iex> delete_sales_order(sales_order)
      {:ok, %SalesOrder{}}

      iex> delete_sales_order(sales_order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sales_order(%SalesOrder{} = sales_order) do
    Repo.delete(sales_order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sales_order changes.

  ## Examples

      iex> change_sales_order(sales_order)
      %Ecto.Changeset{source: %SalesOrder{}}

  """
  def change_sales_order(%SalesOrder{} = sales_order) do
    SalesOrder.changeset(sales_order, %{})
  end

  alias WebAcc.Settings.Customer

  @doc """
  Returns the list of customers.

  ## Examples

      iex> list_customers()
      [%Customer{}, ...]

  """
  def list_customers do
    Repo.all(Customer)
  end

  @doc """
  Gets a single customer.

  Raises `Ecto.NoResultsError` if the Customer does not exist.

  ## Examples

      iex> get_customer!(123)
      %Customer{}

      iex> get_customer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_customer!(id), do: Repo.get!(Customer, id)

  @doc """
  Creates a customer.

  ## Examples

      iex> create_customer(%{field: value})
      {:ok, %Customer{}}

      iex> create_customer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_customer(attrs \\ %{}) do
    a =
      %Customer{}
      |> Customer.changeset(attrs)
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
  Updates a customer.

  ## Examples

      iex> update_customer(customer, %{field: new_value})
      {:ok, %Customer{}}

      iex> update_customer(customer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_customer(%Customer{} = customer, attrs) do
    a =
      customer
      |> Customer.changeset(attrs)
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
  Deletes a customer.

  ## Examples

      iex> delete_customer(customer)
      {:ok, %Customer{}}

      iex> delete_customer(customer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_customer(%Customer{} = customer) do
    Repo.delete(customer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking customer changes.

  ## Examples

      iex> change_customer(customer)
      %Ecto.Changeset{source: %Customer{}}

  """
  def change_customer(%Customer{} = customer) do
    Customer.changeset(customer, %{})
  end

  alias WebAcc.Settings.StockTransferMaster

  @doc """
  Returns the list of stock_transfer_master.

  ## Examples

      iex> list_stock_transfer_master()
      [%StockTransferMaster{}, ...]

  """
  def list_stock_transfer_master do
    Repo.all(StockTransferMaster)
  end

  @doc """
  Gets a single stock_transfer_master.

  Raises `Ecto.NoResultsError` if the Stock transfer master does not exist.

  ## Examples

      iex> get_stock_transfer_master!(123)
      %StockTransferMaster{}

      iex> get_stock_transfer_master!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stock_transfer_master!(id), do: Repo.get!(StockTransferMaster, id)

  @doc """
  Creates a stock_transfer_master.

  ## Examples

      iex> create_stock_transfer_master(%{field: value})
      {:ok, %StockTransferMaster{}}

      iex> create_stock_transfer_master(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stock_transfer_master(attrs \\ %{}) do
    a =
      %StockTransferMaster{}
      |> StockTransferMaster.changeset(attrs)
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
  Updates a stock_transfer_master.

  ## Examples

      iex> update_stock_transfer_master(stock_transfer_master, %{field: new_value})
      {:ok, %StockTransferMaster{}}

      iex> update_stock_transfer_master(stock_transfer_master, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stock_transfer_master(%StockTransferMaster{} = stock_transfer_master, attrs) do
    a =
      stock_transfer_master
      |> StockTransferMaster.changeset(attrs)
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
  Deletes a stock_transfer_master.

  ## Examples

      iex> delete_stock_transfer_master(stock_transfer_master)
      {:ok, %StockTransferMaster{}}

      iex> delete_stock_transfer_master(stock_transfer_master)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stock_transfer_master(%StockTransferMaster{} = stock_transfer_master) do
    Repo.delete(stock_transfer_master)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stock_transfer_master changes.

  ## Examples

      iex> change_stock_transfer_master(stock_transfer_master)
      %Ecto.Changeset{source: %StockTransferMaster{}}

  """
  def change_stock_transfer_master(%StockTransferMaster{} = stock_transfer_master) do
    StockTransferMaster.changeset(stock_transfer_master, %{})
  end

  alias WebAcc.Settings.StockTransfer

  @doc """
  Returns the list of stock_transfers.

  ## Examples

      iex> list_stock_transfers()
      [%StockTransfer{}, ...]

  """
  def list_stock_transfers do
    Repo.all(StockTransfer)
  end

  @doc """
  Gets a single stock_transfer.

  Raises `Ecto.NoResultsError` if the Stock transfer does not exist.

  ## Examples

      iex> get_stock_transfer!(123)
      %StockTransfer{}

      iex> get_stock_transfer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stock_transfer!(id), do: Repo.get!(StockTransfer, id)

  def order_stm_task(model) do
    stm = Repo.get(WebAcc.Settings.StockTransferMaster, model.stm_id)

    a =
      create_stock_movement(%{
        action: "adjust_out",
        location_id: stm.from_id,
        product_id: model.product_id,
        quantity: model.quantity,
        reference: "STM#{stm.id}"
      })

    b =
      create_stock_movement(%{
        action: "adjust_in",
        location_id: stm.to_id,
        product_id: model.product_id,
        quantity: model.quantity,
        reference: "STM#{stm.id}"
      })

    [a, b]
  end

  @doc """
  Creates a stock_transfer.

  ## Examples

      iex> create_stock_transfer(%{field: value})
      {:ok, %StockTransfer{}}

      iex> create_stock_transfer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stock_transfer(attrs \\ %{}) do
    a =
      %StockTransfer{}
      |> StockTransfer.changeset(attrs)
      |> Repo.insert()

    case a do
      {:ok, model} ->
        WebAccWeb.Endpoint.broadcast("user:lobby", "model_update", %{
          source: model.__meta__.source,
          data: Utility.s_to_map(model)
        })

        # Task.start_link(__MODULE__, :order_stm_task, [model])
        b = order_stm_task(model)
        IO.inspect(b)

      _ ->
        nil
    end

    a
  end

  @doc """
  Updates a stock_transfer.

  ## Examples

      iex> update_stock_transfer(stock_transfer, %{field: new_value})
      {:ok, %StockTransfer{}}

      iex> update_stock_transfer(stock_transfer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stock_transfer(%StockTransfer{} = stock_transfer, attrs) do
    a =
      stock_transfer
      |> StockTransfer.changeset(attrs)
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
  Deletes a stock_transfer.

  ## Examples

      iex> delete_stock_transfer(stock_transfer)
      {:ok, %StockTransfer{}}

      iex> delete_stock_transfer(stock_transfer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stock_transfer(%StockTransfer{} = stock_transfer) do
    Repo.delete(stock_transfer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stock_transfer changes.

  ## Examples

      iex> change_stock_transfer(stock_transfer)
      %Ecto.Changeset{source: %StockTransfer{}}

  """
  def change_stock_transfer(%StockTransfer{} = stock_transfer) do
    StockTransfer.changeset(stock_transfer, %{})
  end
end
