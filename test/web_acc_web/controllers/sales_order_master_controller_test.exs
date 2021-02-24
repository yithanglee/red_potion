defmodule WebAccWeb.SalesOrderMasterControllerTest do
  use WebAccWeb.ConnCase

  alias WebAcc.Settings

  @create_attrs %{created_by: "some created_by", customer_id: 42, delivery_date: ~D[2010-04-17], lat: 120.5, long: 120.5, status: "some status", to: "some to"}
  @update_attrs %{created_by: "some updated created_by", customer_id: 43, delivery_date: ~D[2011-05-18], lat: 456.7, long: 456.7, status: "some updated status", to: "some updated to"}
  @invalid_attrs %{created_by: nil, customer_id: nil, delivery_date: nil, lat: nil, long: nil, status: nil, to: nil}

  def fixture(:sales_order_master) do
    {:ok, sales_order_master} = Settings.create_sales_order_master(@create_attrs)
    sales_order_master
  end

  describe "index" do
    test "lists all sales_order_masters", %{conn: conn} do
      conn = get(conn, Routes.sales_order_master_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Sales order masters"
    end
  end

  describe "new sales_order_master" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.sales_order_master_path(conn, :new))
      assert html_response(conn, 200) =~ "New Sales order master"
    end
  end

  describe "create sales_order_master" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.sales_order_master_path(conn, :create), sales_order_master: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.sales_order_master_path(conn, :show, id)

      conn = get(conn, Routes.sales_order_master_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Sales order master"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.sales_order_master_path(conn, :create), sales_order_master: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Sales order master"
    end
  end

  describe "edit sales_order_master" do
    setup [:create_sales_order_master]

    test "renders form for editing chosen sales_order_master", %{conn: conn, sales_order_master: sales_order_master} do
      conn = get(conn, Routes.sales_order_master_path(conn, :edit, sales_order_master))
      assert html_response(conn, 200) =~ "Edit Sales order master"
    end
  end

  describe "update sales_order_master" do
    setup [:create_sales_order_master]

    test "redirects when data is valid", %{conn: conn, sales_order_master: sales_order_master} do
      conn = put(conn, Routes.sales_order_master_path(conn, :update, sales_order_master), sales_order_master: @update_attrs)
      assert redirected_to(conn) == Routes.sales_order_master_path(conn, :show, sales_order_master)

      conn = get(conn, Routes.sales_order_master_path(conn, :show, sales_order_master))
      assert html_response(conn, 200) =~ "some updated created_by"
    end

    test "renders errors when data is invalid", %{conn: conn, sales_order_master: sales_order_master} do
      conn = put(conn, Routes.sales_order_master_path(conn, :update, sales_order_master), sales_order_master: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Sales order master"
    end
  end

  describe "delete sales_order_master" do
    setup [:create_sales_order_master]

    test "deletes chosen sales_order_master", %{conn: conn, sales_order_master: sales_order_master} do
      conn = delete(conn, Routes.sales_order_master_path(conn, :delete, sales_order_master))
      assert redirected_to(conn) == Routes.sales_order_master_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.sales_order_master_path(conn, :show, sales_order_master))
      end
    end
  end

  defp create_sales_order_master(_) do
    sales_order_master = fixture(:sales_order_master)
    {:ok, sales_order_master: sales_order_master}
  end
end
