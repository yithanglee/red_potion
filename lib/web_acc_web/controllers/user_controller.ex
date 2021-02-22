defmodule WebAccWeb.UserController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.User
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

      cond do
        params["role_id"] != nil ->
          data =
            Repo.all(
              from(a in User,
                where:
                  a.role_id == ^params["role_id"] and
                    ilike(a.name, ^"%#{params["search"]["value"]}%")
              )
            )

          data2 =
            Repo.all(
              from(
                a in User,
                where:
                  a.role_id == ^params["role_id"] and
                    ilike(a.name, ^"%#{params["search"]["value"]}%"),
                limit: ^limit,
                offset: ^offset,
                order_by: ^order_by
              )
            )
            |> Enum.map(fn x -> Utility.s_to_map(x) end)

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

        true ->
          data =
            Repo.all(from(a in User, where: ilike(a.name, ^"%#{params["search"]["value"]}%")))

          data2 =
            Repo.all(
              from(
                a in User,
                where: ilike(a.name, ^"%#{params["search"]["value"]}%"),
                limit: ^limit,
                offset: ^offset,
                order_by: ^order_by
              )
            )
            |> Enum.map(fn x -> Utility.s_to_map(x) end)

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
      end
    else
      users = Settings.list_users()
      render(conn, "index.html", users: users)
    end
  end

  def new(conn, _params) do
    changeset = Settings.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"users" => user_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
      user_params = Utility.upload_file(user_params)

      if user_params["id"] != nil do
        user =
          if user_params["id"] == "0" do
            nil
          else
            Settings.get_user!(user_params["id"])
          end

        if user == nil do
          case Settings.create_user(user_params) do
            {:ok, user} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(user)))

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
          case Settings.update_user(user, user_params) do
            {:ok, user} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(user)))

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
      case Settings.create_user(user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "User created successfully.")
          |> redirect(to: Routes.user_path(conn, :show, user))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    user = Settings.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Settings.get_user!(id)
    changeset = Settings.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Settings.get_user!(id)

    case Settings.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)

    if user != nil do
      {:ok, _user} = Settings.delete_user(user)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "User deleted successfully.")
        |> redirect(to: Routes.user_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
