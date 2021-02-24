defmodule WebAccWeb.StockReceiveController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.StockReceive
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

      data = Repo.all(from(a in StockReceive))

      data2 =
        Repo.all(
          from(
            a in StockReceive,
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
      stock_receives = Settings.list_stock_receives()
      render(conn, "index.html", stock_receives: stock_receives)
    end
  end

  def new(conn, _params) do
    changeset = Settings.change_stock_receive(%StockReceive{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"stock_receives" => stock_receive_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
      if stock_receive_params["id"] != nil do
        stock_receive =
          if stock_receive_params["id"] == "0" do
            nil
          else
            Settings.get_stock_receive!(stock_receive_params["id"])
          end

        if stock_receive == nil do
          case Settings.create_stock_receive(stock_receive_params) do
            {:ok, stock_receive} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(stock_receive)))

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
          case Settings.update_stock_receive(stock_receive, stock_receive_params) do
            {:ok, stock_receive} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(stock_receive)))

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
      case Settings.create_stock_receive(stock_receive_params) do
        {:ok, stock_receive} ->
          conn
          |> put_flash(:info, "Stock receive created successfully.")
          |> redirect(to: Routes.stock_receive_path(conn, :show, stock_receive))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    stock_receive = Settings.get_stock_receive!(id)
    render(conn, "show.html", stock_receive: stock_receive)
  end

  def edit(conn, %{"id" => id}) do
    stock_receive = Settings.get_stock_receive!(id)
    changeset = Settings.change_stock_receive(stock_receive)
    render(conn, "edit.html", stock_receive: stock_receive, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stock_receive" => stock_receive_params}) do
    stock_receive = Settings.get_stock_receive!(id)

    case Settings.update_stock_receive(stock_receive, stock_receive_params) do
      {:ok, stock_receive} ->
        conn
        |> put_flash(:info, "Stock receive updated successfully.")
        |> redirect(to: Routes.stock_receive_path(conn, :show, stock_receive))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", stock_receive: stock_receive, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stock_receive = Repo.get(StockReceive, id)

    if stock_receive != nil do
      {:ok, _stock_receive} = Settings.delete_stock_receive(stock_receive)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "Stock receive deleted successfully.")
        |> redirect(to: Routes.stock_receive_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
