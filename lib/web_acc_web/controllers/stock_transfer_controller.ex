defmodule WebAccWeb.StockTransferController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.StockTransfer
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

      data = Repo.all(from(a in StockTransfer, where: a.stm_id == ^params["stm_id"]))

      data2 =
        Repo.all(
          from(
            a in StockTransfer,
            where: a.stm_id == ^params["stm_id"],
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
      stock_transfers = Settings.list_stock_transfers()
      render(conn, "index.html", stock_transfers: stock_transfers)
    end
  end

  def new(conn, _params) do
    changeset = Settings.change_stock_transfer(%StockTransfer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"stock_transfers" => stock_transfer_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
      if stock_transfer_params["id"] != nil do
        stock_transfer =
          if stock_transfer_params["id"] == "0" do
            nil
          else
            Settings.get_stock_transfer!(stock_transfer_params["id"])
          end

        if stock_transfer == nil do
          case Settings.create_stock_transfer(stock_transfer_params) do
            {:ok, stock_transfer} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(stock_transfer)))

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
          case Settings.update_stock_transfer(stock_transfer, stock_transfer_params) do
            {:ok, stock_transfer} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(stock_transfer)))

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
      case Settings.create_stock_transfer(stock_transfer_params) do
        {:ok, stock_transfer} ->
          conn
          |> put_flash(:info, "Stock transfer created successfully.")
          |> redirect(to: Routes.stock_transfer_path(conn, :show, stock_transfer))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    stock_transfer = Settings.get_stock_transfer!(id)
    render(conn, "show.html", stock_transfer: stock_transfer)
  end

  def edit(conn, %{"id" => id}) do
    stock_transfer = Settings.get_stock_transfer!(id)
    changeset = Settings.change_stock_transfer(stock_transfer)
    render(conn, "edit.html", stock_transfer: stock_transfer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stock_transfer" => stock_transfer_params}) do
    stock_transfer = Settings.get_stock_transfer!(id)

    case Settings.update_stock_transfer(stock_transfer, stock_transfer_params) do
      {:ok, stock_transfer} ->
        conn
        |> put_flash(:info, "Stock transfer updated successfully.")
        |> redirect(to: Routes.stock_transfer_path(conn, :show, stock_transfer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", stock_transfer: stock_transfer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stock_transfer = Repo.get(StockTransfer, id)

    if stock_transfer != nil do
      {:ok, _stock_transfer} = Settings.delete_stock_transfer(stock_transfer)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "Stock transfer deleted successfully.")
        |> redirect(to: Routes.stock_transfer_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
