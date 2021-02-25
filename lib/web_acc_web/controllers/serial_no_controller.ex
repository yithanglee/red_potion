defmodule WebAccWeb.SerialNoController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.SerialNo
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

      data = Repo.all(from(a in SerialNo))

      data2 =
        Repo.all(
          from(
            a in SerialNo,
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
    else
      serial_nos = Settings.list_serial_nos()
      render(conn, "index.html", serial_nos: serial_nos)
    end
  end

  def new(conn, _params) do
    changeset = Settings.change_serial_no(%SerialNo{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"serial_nos" => serial_no_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
      if serial_no_params["id"] != nil do
        serial_no =
          if serial_no_params["id"] == "0" do
            nil
          else
            Settings.get_serial_no!(serial_no_params["id"])
          end

        if serial_no == nil do
          case Settings.create_serial_no(serial_no_params) do
            {:ok, serial_no} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(serial_no)))

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
          case Settings.update_serial_no(serial_no, serial_no_params) do
            {:ok, serial_no} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(serial_no)))

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
      case Settings.create_serial_no(serial_no_params) do
        {:ok, serial_no} ->
          conn
          |> put_flash(:info, "Serial no created successfully.")
          |> redirect(to: Routes.serial_no_path(conn, :show, serial_no))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    serial_no = Settings.get_serial_no!(id)
    render(conn, "show.html", serial_no: serial_no)
  end

  def edit(conn, %{"id" => id}) do
    serial_no = Settings.get_serial_no!(id)
    changeset = Settings.change_serial_no(serial_no)
    render(conn, "edit.html", serial_no: serial_no, changeset: changeset)
  end

  def update(conn, %{"id" => id, "serial_no" => serial_no_params}) do
    serial_no = Settings.get_serial_no!(id)

    case Settings.update_serial_no(serial_no, serial_no_params) do
      {:ok, serial_no} ->
        conn
        |> put_flash(:info, "Serial no updated successfully.")
        |> redirect(to: Routes.serial_no_path(conn, :show, serial_no))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", serial_no: serial_no, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    serial_no = Repo.get(SerialNo, id)

    if serial_no != nil do
      {:ok, _serial_no} = Settings.delete_serial_no(serial_no)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "Serial no deleted successfully.")
        |> redirect(to: Routes.serial_no_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
