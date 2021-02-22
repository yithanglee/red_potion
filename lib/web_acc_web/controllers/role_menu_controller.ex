defmodule WebAccWeb.RoleMenuController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.RoleMenu
  alias WebAcc.{Repo}
  import Ecto.Query

  def index(conn, params) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
      limit = String.to_integer(params["length"])
      offset = String.to_integer(params["start"])

      column_no = params["order"]["0"]["column"]
      key = params["columns"][column_no]["data"] |> String.to_atom()
      dir = params["order"]["0"]["dir"] |> String.to_atom()
      order_by = [{dir, key}]

      data = Repo.all(from(a in RoleMenu, where: a.role_id == ^params["role_id"]))

      data2 =
        Repo.all(
          from(
            a in RoleMenu,
            left_join: r in Settings.Role,
            on: r.id == a.role_id,
            left_join: m in Settings.Menu,
            on: m.id == a.menu_id,
            where: a.role_id == ^params["role_id"],
            select: %{
              id: a.id,
              role_id: r.name,
              menu_id: m.name
            },
            limit: ^limit,
            offset: ^offset,
            order_by: ^order_by
          )
        )

      json = %{
        data: data2,
        recordsTotal: Enum.count(data2),
        recordsFiltered: Enum.count(data),
        draw: String.to_integer(params["draw"])
      }

      conn
      |> put_resp_content_type("application/json")
      |> send_resp(
        200,
        Jason.encode!(json)
      )
    else
      role_menus = Settings.list_role_menus()
      render(conn, "index.html", role_menus: role_menus)
    end
  end

  def new(conn, _params) do
    changeset = Settings.change_role_menu(%RoleMenu{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"role_menus" => role_menu_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
      Repo.delete_all(from rm in RoleMenu, where: rm.role_id == ^role_menu_params["role_id"])

      list =
        for menu_id <- role_menu_params["menu_id"] |> Map.keys() do
          {:ok, rm} =
            Settings.create_role_menu(%{role_id: role_menu_params["role_id"], menu_id: menu_id})

          Utility.s_to_map(rm)
        end

      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(list))
    else
      case Settings.create_role_menu(role_menu_params) do
        {:ok, role_menu} ->
          conn
          |> put_flash(:info, "Role menu created successfully.")
          |> redirect(to: Routes.role_menu_path(conn, :show, role_menu))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    role_menu = Settings.get_role_menu!(id)
    render(conn, "show.html", role_menu: role_menu)
  end

  def edit(conn, %{"id" => id}) do
    role_menu = Settings.get_role_menu!(id)
    changeset = Settings.change_role_menu(role_menu)
    render(conn, "edit.html", role_menu: role_menu, changeset: changeset)
  end

  def update(conn, %{"id" => id, "role_menu" => role_menu_params}) do
    role_menu = Settings.get_role_menu!(id)

    case Settings.update_role_menu(role_menu, role_menu_params) do
      {:ok, role_menu} ->
        conn
        |> put_flash(:info, "Role menu updated successfully.")
        |> redirect(to: Routes.role_menu_path(conn, :show, role_menu))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", role_menu: role_menu, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    role_menu = Repo.get(RoleMenu, id)

    if role_menu != nil do
      {:ok, _role_menu} = Settings.delete_role_menu(role_menu)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "Role menu deleted successfully.")
        |> redirect(to: Routes.role_menu_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
