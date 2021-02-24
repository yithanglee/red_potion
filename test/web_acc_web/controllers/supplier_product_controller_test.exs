defmodule WebAccWeb.SupplierProductControllerTest do
  use WebAccWeb.ConnCase

  alias WebAcc.Settings

  @create_attrs %{product_id: 42, supplier_id: 42}
  @update_attrs %{product_id: 43, supplier_id: 43}
  @invalid_attrs %{product_id: nil, supplier_id: nil}

  def fixture(:supplier_product) do
    {:ok, supplier_product} = Settings.create_supplier_product(@create_attrs)
    supplier_product
  end

  describe "index" do
    test "lists all supplier_products", %{conn: conn} do
      conn = get(conn, Routes.supplier_product_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Supplier products"
    end
  end

  describe "new supplier_product" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.supplier_product_path(conn, :new))
      assert html_response(conn, 200) =~ "New Supplier product"
    end
  end

  describe "create supplier_product" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.supplier_product_path(conn, :create), supplier_product: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.supplier_product_path(conn, :show, id)

      conn = get(conn, Routes.supplier_product_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Supplier product"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.supplier_product_path(conn, :create), supplier_product: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Supplier product"
    end
  end

  describe "edit supplier_product" do
    setup [:create_supplier_product]

    test "renders form for editing chosen supplier_product", %{conn: conn, supplier_product: supplier_product} do
      conn = get(conn, Routes.supplier_product_path(conn, :edit, supplier_product))
      assert html_response(conn, 200) =~ "Edit Supplier product"
    end
  end

  describe "update supplier_product" do
    setup [:create_supplier_product]

    test "redirects when data is valid", %{conn: conn, supplier_product: supplier_product} do
      conn = put(conn, Routes.supplier_product_path(conn, :update, supplier_product), supplier_product: @update_attrs)
      assert redirected_to(conn) == Routes.supplier_product_path(conn, :show, supplier_product)

      conn = get(conn, Routes.supplier_product_path(conn, :show, supplier_product))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, supplier_product: supplier_product} do
      conn = put(conn, Routes.supplier_product_path(conn, :update, supplier_product), supplier_product: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Supplier product"
    end
  end

  describe "delete supplier_product" do
    setup [:create_supplier_product]

    test "deletes chosen supplier_product", %{conn: conn, supplier_product: supplier_product} do
      conn = delete(conn, Routes.supplier_product_path(conn, :delete, supplier_product))
      assert redirected_to(conn) == Routes.supplier_product_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.supplier_product_path(conn, :show, supplier_product))
      end
    end
  end

  defp create_supplier_product(_) do
    supplier_product = fixture(:supplier_product)
    {:ok, supplier_product: supplier_product}
  end
end
