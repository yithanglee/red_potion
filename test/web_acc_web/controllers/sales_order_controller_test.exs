defmodule WebAccWeb.SalesOrderControllerTest do
  use WebAccWeb.ConnCase

  alias WebAcc.Settings

  @create_attrs %{product_id: 42, product_name: "some product_name", quantity: 120.5, selling_price: 120.5, som_id: 42, unit_price: 120.5}
  @update_attrs %{product_id: 43, product_name: "some updated product_name", quantity: 456.7, selling_price: 456.7, som_id: 43, unit_price: 456.7}
  @invalid_attrs %{product_id: nil, product_name: nil, quantity: nil, selling_price: nil, som_id: nil, unit_price: nil}

  def fixture(:sales_order) do
    {:ok, sales_order} = Settings.create_sales_order(@create_attrs)
    sales_order
  end

  describe "index" do
    test "lists all sales_orders", %{conn: conn} do
      conn = get(conn, Routes.sales_order_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Sales orders"
    end
  end

  describe "new sales_order" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.sales_order_path(conn, :new))
      assert html_response(conn, 200) =~ "New Sales order"
    end
  end

  describe "create sales_order" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.sales_order_path(conn, :create), sales_order: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.sales_order_path(conn, :show, id)

      conn = get(conn, Routes.sales_order_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Sales order"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.sales_order_path(conn, :create), sales_order: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Sales order"
    end
  end

  describe "edit sales_order" do
    setup [:create_sales_order]

    test "renders form for editing chosen sales_order", %{conn: conn, sales_order: sales_order} do
      conn = get(conn, Routes.sales_order_path(conn, :edit, sales_order))
      assert html_response(conn, 200) =~ "Edit Sales order"
    end
  end

  describe "update sales_order" do
    setup [:create_sales_order]

    test "redirects when data is valid", %{conn: conn, sales_order: sales_order} do
      conn = put(conn, Routes.sales_order_path(conn, :update, sales_order), sales_order: @update_attrs)
      assert redirected_to(conn) == Routes.sales_order_path(conn, :show, sales_order)

      conn = get(conn, Routes.sales_order_path(conn, :show, sales_order))
      assert html_response(conn, 200) =~ "some updated product_name"
    end

    test "renders errors when data is invalid", %{conn: conn, sales_order: sales_order} do
      conn = put(conn, Routes.sales_order_path(conn, :update, sales_order), sales_order: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Sales order"
    end
  end

  describe "delete sales_order" do
    setup [:create_sales_order]

    test "deletes chosen sales_order", %{conn: conn, sales_order: sales_order} do
      conn = delete(conn, Routes.sales_order_path(conn, :delete, sales_order))
      assert redirected_to(conn) == Routes.sales_order_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.sales_order_path(conn, :show, sales_order))
      end
    end
  end

  defp create_sales_order(_) do
    sales_order = fixture(:sales_order)
    {:ok, sales_order: sales_order}
  end
end
