defmodule WebAccWeb.SupplierController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.Supplier
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
        Repo.all(from(a in Supplier, where: ilike(a.name, ^"%#{params["search"]["value"]}%")))

      data2 =
        Repo.all(
          from(
            a in Supplier,
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
      suppliers = Settings.list_suppliers()
      render(conn, "index.html", suppliers: suppliers)
    end 
  end

  def new(conn, _params) do
    changeset = Settings.change_supplier(%Supplier{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"suppliers" => supplier_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        if supplier_params["id"] != nil do
          supplier = 
          if supplier_params["id"] == "0" do
            nil 
            else
            Settings.get_supplier!( supplier_params["id"] )
          end

          if supplier == nil do
              case Settings.create_supplier(supplier_params) do
                {:ok, supplier} ->
                  conn
                  |> put_resp_content_type("application/json")
                  |> send_resp(200, Jason.encode!(Utility.s_to_map(supplier)))
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
              case Settings.update_supplier(supplier, supplier_params) do
                {:ok, supplier} ->
                  conn
                  |> put_resp_content_type("application/json")
                  |> send_resp(200, Jason.encode!(Utility.s_to_map(supplier)))
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
      case Settings.create_supplier(supplier_params) do
        {:ok, supplier} ->
          conn
          |> put_flash(:info, "Supplier created successfully.")
          |> redirect(to: Routes.supplier_path(conn, :show, supplier))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    supplier = Settings.get_supplier!(id)
    render(conn, "show.html", supplier: supplier)
  end

  def edit(conn, %{"id" => id}) do
    supplier = Settings.get_supplier!(id)
    changeset = Settings.change_supplier(supplier)
    render(conn, "edit.html", supplier: supplier, changeset: changeset)
  end

  def update(conn, %{"id" => id, "supplier" => supplier_params}) do
    supplier = Settings.get_supplier!(id)

    case Settings.update_supplier(supplier, supplier_params) do
      {:ok, supplier} ->
        conn
        |> put_flash(:info, "Supplier updated successfully.")
        |> redirect(to: Routes.supplier_path(conn, :show, supplier))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", supplier: supplier, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    supplier = Repo.get(Supplier , (id))

    if supplier != nil do
        {:ok, _supplier} = Settings.delete_supplier(supplier)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "Supplier deleted successfully.")
        |> redirect(to: Routes.supplier_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
