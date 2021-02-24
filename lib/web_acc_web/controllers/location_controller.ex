defmodule WebAccWeb.LocationController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.Location
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
        Repo.all(from(a in Location, where: ilike(a.name, ^"%#{params["search"]["value"]}%")))

      data2 =
        Repo.all(
          from(
            a in Location,
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
      locations = Settings.list_locations()
      render(conn, "index.html", locations: locations)
    end 
  end

  def new(conn, _params) do
    changeset = Settings.change_location(%Location{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"locations" => location_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        if location_params["id"] != nil do
          location = 
          if location_params["id"] == "0" do
            nil 
            else
            Settings.get_location!( location_params["id"] )
          end

          if location == nil do
              case Settings.create_location(location_params) do
                {:ok, location} ->
                  conn
                  |> put_resp_content_type("application/json")
                  |> send_resp(200, Jason.encode!(Utility.s_to_map(location)))
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
              case Settings.update_location(location, location_params) do
                {:ok, location} ->
                  conn
                  |> put_resp_content_type("application/json")
                  |> send_resp(200, Jason.encode!(Utility.s_to_map(location)))
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
      case Settings.create_location(location_params) do
        {:ok, location} ->
          conn
          |> put_flash(:info, "Location created successfully.")
          |> redirect(to: Routes.location_path(conn, :show, location))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    location = Settings.get_location!(id)
    render(conn, "show.html", location: location)
  end

  def edit(conn, %{"id" => id}) do
    location = Settings.get_location!(id)
    changeset = Settings.change_location(location)
    render(conn, "edit.html", location: location, changeset: changeset)
  end

  def update(conn, %{"id" => id, "location" => location_params}) do
    location = Settings.get_location!(id)

    case Settings.update_location(location, location_params) do
      {:ok, location} ->
        conn
        |> put_flash(:info, "Location updated successfully.")
        |> redirect(to: Routes.location_path(conn, :show, location))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", location: location, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    location = Repo.get(Location , (id))

    if location != nil do
        {:ok, _location} = Settings.delete_location(location)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "Location deleted successfully.")
        |> redirect(to: Routes.location_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
