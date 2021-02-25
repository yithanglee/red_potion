defmodule WebAccWeb.StockTransferMasterController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.StockTransferMaster
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

      data = Repo.all(from(a in StockTransferMaster))

      data2 =
        Repo.all(
          from(
            a in StockTransferMaster,
            left_join: b in Settings.Location,
            on: b.id == a.from_id,
            left_join: c in Settings.Location,
            on: c.id == a.to_id,
            select: %{
              id: a.id,
              from_id: a.from_id,
              to_id: a.to_id,
              delivery_date: a.delivery_date,
              status: a.status,
              from: b.name,
              to: c.name
            },
            limit: ^limit,
            offset: ^offset,
            order_by: ^order_by
          )
        )

      # |> Enum.map(fn x -> Utility.s_to_map(x) end)

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
      stock_transfer_master = Settings.list_stock_transfer_master()
      render(conn, "index.html", stock_transfer_master: stock_transfer_master)
    end
  end

  def new(conn, _params) do
    changeset = Settings.change_stock_transfer_master(%StockTransferMaster{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"stock_transfer_master" => stock_transfer_master_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
      if stock_transfer_master_params["id"] != nil do
        stock_transfer_master =
          if stock_transfer_master_params["id"] == "0" do
            nil
          else
            Settings.get_stock_transfer_master!(stock_transfer_master_params["id"])
          end

        if stock_transfer_master == nil do
          case Settings.create_stock_transfer_master(stock_transfer_master_params) do
            {:ok, stock_transfer_master} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(stock_transfer_master)))

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
          case Settings.update_stock_transfer_master(
                 stock_transfer_master,
                 stock_transfer_master_params
               ) do
            {:ok, stock_transfer_master} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(stock_transfer_master)))

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
      case Settings.create_stock_transfer_master(stock_transfer_master_params) do
        {:ok, stock_transfer_master} ->
          conn
          |> put_flash(:info, "Stock transfer master created successfully.")
          |> redirect(to: Routes.stock_transfer_master_path(conn, :show, stock_transfer_master))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    stock_transfer_master = Settings.get_stock_transfer_master!(id)
    render(conn, "show.html", stock_transfer_master: stock_transfer_master)
  end

  def edit(conn, %{"id" => id}) do
    stock_transfer_master = Settings.get_stock_transfer_master!(id)
    changeset = Settings.change_stock_transfer_master(stock_transfer_master)
    render(conn, "edit.html", stock_transfer_master: stock_transfer_master, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stock_transfer_master" => stock_transfer_master_params}) do
    stock_transfer_master = Settings.get_stock_transfer_master!(id)

    case Settings.update_stock_transfer_master(
           stock_transfer_master,
           stock_transfer_master_params
         ) do
      {:ok, stock_transfer_master} ->
        conn
        |> put_flash(:info, "Stock transfer master updated successfully.")
        |> redirect(to: Routes.stock_transfer_master_path(conn, :show, stock_transfer_master))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html",
          stock_transfer_master: stock_transfer_master,
          changeset: changeset
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    stock_transfer_master = Repo.get(StockTransferMaster, id)

    if stock_transfer_master != nil do
      {:ok, _stock_transfer_master} = Settings.delete_stock_transfer_master(stock_transfer_master)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "Stock transfer master deleted successfully.")
        |> redirect(to: Routes.stock_transfer_master_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
