defmodule WebAccWeb.StockLevelController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.StockLevel
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
        Repo.all(
          from(a in StockLevel,
            left_join: p in Settings.Product,
            on: p.id == a.product_id,
            left_join: l in Settings.Location,
            on: l.id == a.location_id,
            where: ilike(p.name, ^"%#{params["search"]["value"]}%")
          )
        )

      data2 =
        Repo.all(
          from(
            a in StockLevel,
            left_join: p in Settings.Product,
            on: p.id == a.product_id,
            left_join: l in Settings.Location,
            on: l.id == a.location_id,
            where: ilike(p.name, ^"%#{params["search"]["value"]}%"),
            select: %{
              id: a.id,
              available: a.available,
              location: l.name,
              location_id: a.location_id,
              min_alert: a.min_alert,
              min_order: a.min_order,
              onhand: a.onhand,
              ordered: a.ordered,
              product: p.name,
              product_id: a.product_id
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
      stock_levels = Settings.list_stock_levels()
      render(conn, "index.html", stock_levels: stock_levels)
    end
  end

  def new(conn, _params) do
    changeset = Settings.change_stock_level(%StockLevel{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"stock_levels" => stock_level_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
      if stock_level_params["id"] != nil do
        stock_level =
          if stock_level_params["id"] == "0" do
            nil
          else
            Settings.get_stock_level!(stock_level_params["id"])
          end

        if stock_level == nil do
          case Settings.create_stock_level(stock_level_params) do
            {:ok, stock_level} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(stock_level)))

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
          case Settings.update_stock_level(stock_level, stock_level_params) do
            {:ok, stock_level} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(stock_level)))

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
      case Settings.create_stock_level(stock_level_params) do
        {:ok, stock_level} ->
          conn
          |> put_flash(:info, "Stock level created successfully.")
          |> redirect(to: Routes.stock_level_path(conn, :show, stock_level))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    stock_level = Settings.get_stock_level!(id)
    render(conn, "show.html", stock_level: stock_level)
  end

  def edit(conn, %{"id" => id}) do
    stock_level = Settings.get_stock_level!(id)
    changeset = Settings.change_stock_level(stock_level)
    render(conn, "edit.html", stock_level: stock_level, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stock_level" => stock_level_params}) do
    stock_level = Settings.get_stock_level!(id)

    case Settings.update_stock_level(stock_level, stock_level_params) do
      {:ok, stock_level} ->
        conn
        |> put_flash(:info, "Stock level updated successfully.")
        |> redirect(to: Routes.stock_level_path(conn, :show, stock_level))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", stock_level: stock_level, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stock_level = Repo.get(StockLevel, id)

    if stock_level != nil do
      {:ok, _stock_level} = Settings.delete_stock_level(stock_level)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "Stock level deleted successfully.")
        |> redirect(to: Routes.stock_level_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
