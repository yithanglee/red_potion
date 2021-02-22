defmodule WebAccWeb.RoleController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.Role
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
        Repo.all(from(a in Role, where: ilike(a.name, ^"%#{params["search"]["value"]}%")))

      data2 =
        Repo.all(
          from(
            a in Role,
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
      roles = Settings.list_roles()
      render(conn, "index.html", roles: roles)
    end 
  end

  def new(conn, _params) do
    changeset = Settings.change_role(%Role{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"roles" => role_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        if role_params["id"] != nil do
          role = 
          if role_params["id"] == "0" do
            nil 
            else
            Settings.get_role!( role_params["id"] )
          end

          if role == nil do
              case Settings.create_role(role_params) do
                {:ok, role} ->
                  conn
                  |> put_resp_content_type("application/json")
                  |> send_resp(200, Jason.encode!(Utility.s_to_map(role)))
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
              case Settings.update_role(role, role_params) do
                {:ok, role} ->
                  conn
                  |> put_resp_content_type("application/json")
                  |> send_resp(200, Jason.encode!(Utility.s_to_map(role)))
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
      case Settings.create_role(role_params) do
        {:ok, role} ->
          conn
          |> put_flash(:info, "Role created successfully.")
          |> redirect(to: Routes.role_path(conn, :show, role))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    role = Settings.get_role!(id)
    render(conn, "show.html", role: role)
  end

  def edit(conn, %{"id" => id}) do
    role = Settings.get_role!(id)
    changeset = Settings.change_role(role)
    render(conn, "edit.html", role: role, changeset: changeset)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = Settings.get_role!(id)

    case Settings.update_role(role, role_params) do
      {:ok, role} ->
        conn
        |> put_flash(:info, "Role updated successfully.")
        |> redirect(to: Routes.role_path(conn, :show, role))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", role: role, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Repo.get(Role , (id))

    if role != nil do
        {:ok, _role} = Settings.delete_role(role)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "Role deleted successfully.")
        |> redirect(to: Routes.role_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
