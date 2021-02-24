defmodule WebAccWeb.PurchaseOrderController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.PurchaseOrder
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

      json =
        cond do
          params["search"]["value"] != "" ->
            data =
              Repo.all(
                from(a in PurchaseOrder,
                  left_join: p in Settings.Product,
                  on: p.id == a.product_id,
                  where:
                    ilike(p.name, ^"%#{params["search"]["value"]}%") and
                      a.pom_id == ^params["pom_id"]
                )
              )

            data2 =
              Repo.all(
                from(
                  a in PurchaseOrder,
                  left_join: p in Settings.Product,
                  on: p.id == a.product_id,
                  where:
                    ilike(p.name, ^"%#{params["search"]["value"]}%") and
                      a.pom_id == ^params["pom_id"],
                  limit: ^limit,
                  offset: ^offset,
                  order_by: ^order_by,
                  select: %{
                    id: a.id,
                    quantity: a.quantity,
                    product_id: p.id,
                    sku: p.sku,
                    product_name: p.name
                  }
                )
              )

            %{
              data: data2,
              recordsTotal: Enum.count(data2),
              recordsFiltered: Enum.count(data),
              draw: String.to_integer(params["draw"])
            }

          true ->
            data = Repo.all(from(a in PurchaseOrder, where: a.pom_id == ^params["pom_id"]))

            data2 =
              Repo.all(
                from(
                  a in PurchaseOrder,
                  left_join: p in Settings.Product,
                  on: p.id == a.product_id,
                  where: a.pom_id == ^params["pom_id"],
                  limit: ^limit,
                  offset: ^offset,
                  order_by: ^order_by,
                  select: %{
                    id: a.id,
                    quantity: a.quantity,
                    product_id: p.id,
                    sku: p.sku,
                    product_name: p.name
                  }
                )
              )

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
      purchase_orders = Settings.list_purchase_orders()
      render(conn, "index.html", purchase_orders: purchase_orders)
    end
  end

  def new(conn, _params) do
    changeset = Settings.change_purchase_order(%PurchaseOrder{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"purchase_orders" => purchase_order_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
      if purchase_order_params["id"] != nil do
        purchase_order =
          if purchase_order_params["id"] == "0" do
            nil
          else
            Settings.get_purchase_order!(purchase_order_params["id"])
          end

        if purchase_order == nil do
          case Settings.create_purchase_order(purchase_order_params) do
            {:ok, purchase_order} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(purchase_order)))

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
          case Settings.update_purchase_order(purchase_order, purchase_order_params) do
            {:ok, purchase_order} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(purchase_order)))

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
      case Settings.create_purchase_order(purchase_order_params) do
        {:ok, purchase_order} ->
          conn
          |> put_flash(:info, "Purchase order created successfully.")
          |> redirect(to: Routes.purchase_order_path(conn, :show, purchase_order))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    purchase_order = Settings.get_purchase_order!(id)
    render(conn, "show.html", purchase_order: purchase_order)
  end

  def edit(conn, %{"id" => id}) do
    purchase_order = Settings.get_purchase_order!(id)
    changeset = Settings.change_purchase_order(purchase_order)
    render(conn, "edit.html", purchase_order: purchase_order, changeset: changeset)
  end

  def update(conn, %{"id" => id, "purchase_order" => purchase_order_params}) do
    purchase_order = Settings.get_purchase_order!(id)

    case Settings.update_purchase_order(purchase_order, purchase_order_params) do
      {:ok, purchase_order} ->
        conn
        |> put_flash(:info, "Purchase order updated successfully.")
        |> redirect(to: Routes.purchase_order_path(conn, :show, purchase_order))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", purchase_order: purchase_order, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    purchase_order = Repo.get(PurchaseOrder, id)

    if purchase_order != nil do
      {:ok, _purchase_order} = Settings.delete_purchase_order(purchase_order)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "Purchase order deleted successfully.")
        |> redirect(to: Routes.purchase_order_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
