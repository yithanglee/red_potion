defmodule WebAccWeb.SupplierProductController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.SupplierProduct
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
          from(a in SupplierProduct, where: ilike(a.name, ^"%#{params["search"]["value"]}%"))
        )

      data2 =
        Repo.all(
          from(
            a in SupplierProduct,
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
    else
      supplier_products = Settings.list_supplier_products()
      render(conn, "index.html", supplier_products: supplier_products)
    end
  end

  def new(conn, _params) do
    changeset = Settings.change_supplier_product(%SupplierProduct{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"supplier_products" => supplier_product_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
      Repo.delete_all(
        from rm in SupplierProduct,
          where: rm.supplier_id == ^supplier_product_params["supplier_id"]
      )

      list =
        for product_id <- supplier_product_params["product_id"] |> Map.keys() do
          {:ok, rm} =
            Settings.create_supplier_product(%{
              supplier_id: supplier_product_params["supplier_id"],
              product_id: product_id
            })

          Utility.s_to_map(rm)
        end

      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(list))
    else
      case Settings.create_supplier_product(supplier_product_params) do
        {:ok, supplier_product} ->
          conn
          |> put_flash(:info, "Supplier product created successfully.")
          |> redirect(to: Routes.supplier_product_path(conn, :show, supplier_product))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    supplier_product = Settings.get_supplier_product!(id)
    render(conn, "show.html", supplier_product: supplier_product)
  end

  def edit(conn, %{"id" => id}) do
    supplier_product = Settings.get_supplier_product!(id)
    changeset = Settings.change_supplier_product(supplier_product)
    render(conn, "edit.html", supplier_product: supplier_product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "supplier_product" => supplier_product_params}) do
    supplier_product = Settings.get_supplier_product!(id)

    case Settings.update_supplier_product(supplier_product, supplier_product_params) do
      {:ok, supplier_product} ->
        conn
        |> put_flash(:info, "Supplier product updated successfully.")
        |> redirect(to: Routes.supplier_product_path(conn, :show, supplier_product))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", supplier_product: supplier_product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    supplier_product = Repo.get(SupplierProduct, id)

    if supplier_product != nil do
      {:ok, _supplier_product} = Settings.delete_supplier_product(supplier_product)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "Supplier product deleted successfully.")
        |> redirect(to: Routes.supplier_product_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
