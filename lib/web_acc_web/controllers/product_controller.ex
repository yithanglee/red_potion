defmodule WebAccWeb.ProductController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.Product
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
          params["supplier_id"] != nil ->
            data =
              Repo.all(
                from(a in Product,
                  left_join: sp in Settings.SupplierProduct,
                  on: sp.product_id == a.id,
                  where:
                    ilike(a.name, ^"%#{params["search"]["value"]}%") and
                      sp.supplier_id == ^params["supplier_id"]
                )
              )

            data2 =
              Repo.all(
                from(
                  a in Product,
                  left_join: sp in Settings.SupplierProduct,
                  on: sp.product_id == a.id,
                  where:
                    ilike(a.name, ^"%#{params["search"]["value"]}%") and
                      sp.supplier_id == ^params["supplier_id"],
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
                from(a in Product, where: ilike(a.name, ^"%#{params["search"]["value"]}%"))
              )

            data2 =
              Repo.all(
                from(
                  a in Product,
                  where: ilike(a.name, ^"%#{params["search"]["value"]}%"),
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
      products = Settings.list_products()
      render(conn, "index.html", products: products)
    end
  end

  def new(conn, _params) do
    changeset = Settings.change_product(%Product{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"products" => product_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
      product_params = Utility.upload_file(product_params)

      if product_params["id"] != nil do
        product =
          if product_params["id"] == "0" do
            nil
          else
            Settings.get_product!(product_params["id"])
          end

        if product == nil do
          case Settings.create_product(product_params) do
            {:ok, product} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(product)))

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
          case Settings.update_product(product, product_params) do
            {:ok, product} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(product)))

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
      case Settings.create_product(product_params) do
        {:ok, product} ->
          conn
          |> put_flash(:info, "Product created successfully.")
          |> redirect(to: Routes.product_path(conn, :show, product))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    product = Settings.get_product!(id)
    render(conn, "show.html", product: product)
  end

  def edit(conn, %{"id" => id}) do
    product = Settings.get_product!(id)
    changeset = Settings.change_product(product)
    render(conn, "edit.html", product: product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Settings.get_product!(id)

    case Settings.update_product(product, product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: Routes.product_path(conn, :show, product))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Repo.get(Product, id)

    if product != nil do
      {:ok, _product} = Settings.delete_product(product)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "Product deleted successfully.")
        |> redirect(to: Routes.product_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
