defmodule WebAccWeb.PurchaseOrderControllerTest do
  use WebAccWeb.ConnCase

  alias WebAcc.Settings

  @create_attrs %{quantity: 120.5, supplier_product_id: 42}
  @update_attrs %{quantity: 456.7, supplier_product_id: 43}
  @invalid_attrs %{quantity: nil, supplier_product_id: nil}

  def fixture(:purchase_order) do
    {:ok, purchase_order} = Settings.create_purchase_order(@create_attrs)
    purchase_order
  end

  describe "index" do
    test "lists all purchase_orders", %{conn: conn} do
      conn = get(conn, Routes.purchase_order_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Purchase orders"
    end
  end

  describe "new purchase_order" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.purchase_order_path(conn, :new))
      assert html_response(conn, 200) =~ "New Purchase order"
    end
  end

  describe "create purchase_order" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.purchase_order_path(conn, :create), purchase_order: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.purchase_order_path(conn, :show, id)

      conn = get(conn, Routes.purchase_order_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Purchase order"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.purchase_order_path(conn, :create), purchase_order: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Purchase order"
    end
  end

  describe "edit purchase_order" do
    setup [:create_purchase_order]

    test "renders form for editing chosen purchase_order", %{conn: conn, purchase_order: purchase_order} do
      conn = get(conn, Routes.purchase_order_path(conn, :edit, purchase_order))
      assert html_response(conn, 200) =~ "Edit Purchase order"
    end
  end

  describe "update purchase_order" do
    setup [:create_purchase_order]

    test "redirects when data is valid", %{conn: conn, purchase_order: purchase_order} do
      conn = put(conn, Routes.purchase_order_path(conn, :update, purchase_order), purchase_order: @update_attrs)
      assert redirected_to(conn) == Routes.purchase_order_path(conn, :show, purchase_order)

      conn = get(conn, Routes.purchase_order_path(conn, :show, purchase_order))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, purchase_order: purchase_order} do
      conn = put(conn, Routes.purchase_order_path(conn, :update, purchase_order), purchase_order: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Purchase order"
    end
  end

  describe "delete purchase_order" do
    setup [:create_purchase_order]

    test "deletes chosen purchase_order", %{conn: conn, purchase_order: purchase_order} do
      conn = delete(conn, Routes.purchase_order_path(conn, :delete, purchase_order))
      assert redirected_to(conn) == Routes.purchase_order_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.purchase_order_path(conn, :show, purchase_order))
      end
    end
  end

  defp create_purchase_order(_) do
    purchase_order = fixture(:purchase_order)
    {:ok, purchase_order: purchase_order}
  end
end
