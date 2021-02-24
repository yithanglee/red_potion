defmodule WebAccWeb.StockMovementController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.StockMovement
  alias WebAcc.{Repo}
  import Ecto.Query
  require IEx

  def index(conn, params) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
      limit = String.to_integer(params["length"])
      offset = String.to_integer(params["start"])

      column_no = params["order"]["0"]["column"]
      key = params["columns"][column_no]["data"] |> String.to_atom()
      dir = params["order"]["0"]["dir"] |> String.to_atom()
      order_by = [{dir, key}]

      json =
        cond do
          params["location_id"] != nil && params["product_id"] != nil ->
            data =
              Repo.all(
                from(a in StockMovement,
                  where:
                    a.location_id == ^params["location_id"] and
                      a.product_id == ^params["product_id"]
                )
              )

            data2 =
              Repo.all(
                from(
                  a in StockMovement,
                  where:
                    a.location_id == ^params["location_id"] and
                      a.product_id == ^params["product_id"],
                  limit: ^limit,
                  offset: ^offset,
                  order_by: ^order_by
                )
              )
              |> Enum.map(fn x -> Utility.s_to_map(x) end)

            %{
              data: data2,
              recordsTotal: Enum.count(data2),
              recordsFiltered: Enum.count(data),
              draw: String.to_integer(params["draw"])
            }

          true ->
            data =
              Repo.all(
                from(a in StockMovement,
                  where: ilike(a.reference, ^"%#{params["search"]["value"]}%")
                )
              )

            data2 =
              Repo.all(
                from(
                  a in StockMovement,
                  where: ilike(a.reference, ^"%#{params["search"]["value"]}%"),
                  limit: ^limit,
                  offset: ^offset,
                  order_by: ^order_by
                )
              )
              |> Enum.map(fn x -> Utility.s_to_map(x) end)

            %{
              data: data2,
              recordsTotal: Enum.count(data2),
              recordsFiltered: Enum.count(data),
              draw: String.to_integer(params["draw"])
            }
        end

      conn
      |> put_resp_content_type("application/json")
      |> send_resp(
        200,
        Jason.encode!(json)
      )
    else
      stock_movements = Settings.list_stock_movements()
      render(conn, "index.html", stock_movements: stock_movements)
    end
  end

  def new(conn, _params) do
    changeset = Settings.change_stock_movement(%StockMovement{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"stock_movements" => stock_movement_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
      if stock_movement_params["id"] != nil do
        stock_movement =
          if stock_movement_params["id"] == "0" do
            nil
          else
            Settings.get_stock_movement!(stock_movement_params["id"])
          end

        if stock_movement == nil do
          case Settings.create_stock_movement(stock_movement_params) do
            {:ok, stock_movement} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(stock_movement)))

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
          case Settings.update_stock_movement(stock_movement, stock_movement_params) do
            {:ok, stock_movement} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(stock_movement)))

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
      case Settings.create_stock_movement(stock_movement_params) do
        {:ok, stock_movement} ->
          conn
          |> put_flash(:info, "Stock movement created successfully.")
          |> redirect(to: Routes.stock_movement_path(conn, :show, stock_movement))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    stock_movement = Settings.get_stock_movement!(id)
    render(conn, "show.html", stock_movement: stock_movement)
  end

  def edit(conn, %{"id" => id}) do
    stock_movement = Settings.get_stock_movement!(id)
    changeset = Settings.change_stock_movement(stock_movement)
    render(conn, "edit.html", stock_movement: stock_movement, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stock_movement" => stock_movement_params}) do
    stock_movement = Settings.get_stock_movement!(id)

    case Settings.update_stock_movement(stock_movement, stock_movement_params) do
      {:ok, stock_movement} ->
        conn
        |> put_flash(:info, "Stock movement updated successfully.")
        |> redirect(to: Routes.stock_movement_path(conn, :show, stock_movement))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", stock_movement: stock_movement, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stock_movement = Repo.get(StockMovement, id)

    if stock_movement != nil do
      {:ok, _stock_movement} = Settings.delete_stock_movement(stock_movement)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "Stock movement deleted successfully.")
        |> redirect(to: Routes.stock_movement_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
