defmodule WebAccWeb.MenuController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.Menu
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

      data =
        Repo.all(from(a in Menu, where: ilike(a.name, ^"%#{params["search"]["value"]}%")))

      data2 =
        Repo.all(
          from(
            a in Menu,
            where: ilike(a.name, ^"%#{params["search"]["value"]}%"),
            limit: ^limit,
            offset: ^offset,
            order_by: ^order_by
          )
        )
        |> Enum.map(fn x -> Utility.s_to_map(x) end)
      json =
      %{
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
      menus = Settings.list_menus()
      render(conn, "index.html", menus: menus)
    end 
  end

  def new(conn, _params) do
    changeset = Settings.change_menu(%Menu{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"menus" => menu_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        if menu_params["id"] != nil do
          menu = 
          if menu_params["id"] == "0" do
            nil 
            else
            Settings.get_menu!( menu_params["id"] )
          end

          if menu == nil do
              case Settings.create_menu(menu_params) do
                {:ok, menu} ->
                  conn
                  |> put_resp_content_type("application/json")
                  |> send_resp(200, Jason.encode!(Utility.s_to_map(menu)))
                {:error, %Ecto.Changeset{} = changeset} ->
                  errors = changeset.errors |> Keyword.keys()

                  {reason, message} = changeset.errors |> hd()
                  {proper_message, message_list} = message
                  final_reason = Atom.to_string(reason) <> " " <> proper_message

                  conn
                  |> put_resp_content_type("application/json")
                  |> send_resp(500, Jason.encode!(%{status: final_reason}))
              end
          else
              case Settings.update_menu(menu, menu_params) do
                {:ok, menu} ->
                  conn
                  |> put_resp_content_type("application/json")
                  |> send_resp(200, Jason.encode!(Utility.s_to_map(menu)))
                {:error, %Ecto.Changeset{} = changeset} ->
                  errors = changeset.errors |> Keyword.keys()

                  {reason, message} = changeset.errors |> hd()
                  {proper_message, message_list} = message
                  final_reason = Atom.to_string(reason) <> " " <> proper_message

                  conn
                  |> put_resp_content_type("application/json")
                  |> send_resp(500, Jason.encode!(%{status: final_reason}))
              end
          end 
        
        end 
    else
      case Settings.create_menu(menu_params) do
        {:ok, menu} ->
          conn
          |> put_flash(:info, "Menu created successfully.")
          |> redirect(to: Routes.menu_path(conn, :show, menu))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    menu = Settings.get_menu!(id)
    render(conn, "show.html", menu: menu)
  end

  def edit(conn, %{"id" => id}) do
    menu = Settings.get_menu!(id)
    changeset = Settings.change_menu(menu)
    render(conn, "edit.html", menu: menu, changeset: changeset)
  end

  def update(conn, %{"id" => id, "menu" => menu_params}) do
    menu = Settings.get_menu!(id)

    case Settings.update_menu(menu, menu_params) do
      {:ok, menu} ->
        conn
        |> put_flash(:info, "Menu updated successfully.")
        |> redirect(to: Routes.menu_path(conn, :show, menu))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", menu: menu, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    menu = Repo.get(Menu , (id))

    if menu != nil do
        {:ok, _menu} = Settings.delete_menu(menu)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "Menu deleted successfully.")
        |> redirect(to: Routes.menu_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
