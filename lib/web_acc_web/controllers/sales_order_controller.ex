defmodule WebAccWeb.SalesOrderController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.SalesOrder
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

      data = Repo.all(from(a in SalesOrder, where: a.som_id == ^params["som_id"]))

      data2 =
        Repo.all(
          from(
            a in SalesOrder,
            where: a.som_id == ^params["som_id"],
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
      sales_orders = Settings.list_sales_orders()
      render(conn, "index.html", sales_orders: sales_orders)
    end
  end

  def new(conn, _params) do
    changeset = Settings.change_sales_order(%SalesOrder{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sales_orders" => sales_order_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
      if sales_order_params["id"] != nil do
        sales_order =
          if sales_order_params["id"] == "0" do
            nil
          else
            Settings.get_sales_order!(sales_order_params["id"])
          end

        if sales_order == nil do
          case Settings.create_sales_order(sales_order_params) do
            {:ok, sales_order} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(sales_order)))

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
          case Settings.update_sales_order(sales_order, sales_order_params) do
            {:ok, sales_order} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(sales_order)))

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
      case Settings.create_sales_order(sales_order_params) do
        {:ok, sales_order} ->
          conn
          |> put_flash(:info, "Sales order created successfully.")
          |> redirect(to: Routes.sales_order_path(conn, :show, sales_order))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    sales_order = Settings.get_sales_order!(id)
    render(conn, "show.html", sales_order: sales_order)
  end

  def edit(conn, %{"id" => id}) do
    sales_order = Settings.get_sales_order!(id)
    changeset = Settings.change_sales_order(sales_order)
    render(conn, "edit.html", sales_order: sales_order, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sales_order" => sales_order_params}) do
    sales_order = Settings.get_sales_order!(id)

    case Settings.update_sales_order(sales_order, sales_order_params) do
      {:ok, sales_order} ->
        conn
        |> put_flash(:info, "Sales order updated successfully.")
        |> redirect(to: Routes.sales_order_path(conn, :show, sales_order))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sales_order: sales_order, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sales_order = Repo.get(SalesOrder, id)

    if sales_order != nil do
      {:ok, _sales_order} = Settings.delete_sales_order(sales_order)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "Sales order deleted successfully.")
        |> redirect(to: Routes.sales_order_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
