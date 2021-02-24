defmodule WebAccWeb.PurchaseOrderMasterControllerTest do
  use WebAccWeb.ConnCase

  alias WebAcc.Settings

  @create_attrs %{location_id: 42, order_date: ~D[2010-04-17], request_by: "some request_by", status: "some status"}
  @update_attrs %{location_id: 43, order_date: ~D[2011-05-18], request_by: "some updated request_by", status: "some updated status"}
  @invalid_attrs %{location_id: nil, order_date: nil, request_by: nil, status: nil}

  def fixture(:purchase_order_master) do
    {:ok, purchase_order_master} = Settings.create_purchase_order_master(@create_attrs)
    purchase_order_master
  end

  describe "index" do
    test "lists all purchase_order_masters", %{conn: conn} do
      conn = get(conn, Routes.purchase_order_master_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Purchase order masters"
    end
  end

  describe "new purchase_order_master" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.purchase_order_master_path(conn, :new))
      assert html_response(conn, 200) =~ "New Purchase order master"
    end
  end

  describe "create purchase_order_master" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.purchase_order_master_path(conn, :create), purchase_order_master: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.purchase_order_master_path(conn, :show, id)

      conn = get(conn, Routes.purchase_order_master_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Purchase order master"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.purchase_order_master_path(conn, :create), purchase_order_master: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Purchase order master"
    end
  end

  describe "edit purchase_order_master" do
    setup [:create_purchase_order_master]

    test "renders form for editing chosen purchase_order_master", %{conn: conn, purchase_order_master: purchase_order_master} do
      conn = get(conn, Routes.purchase_order_master_path(conn, :edit, purchase_order_master))
      assert html_response(conn, 200) =~ "Edit Purchase order master"
    end
  end

  describe "update purchase_order_master" do
    setup [:create_purchase_order_master]

    test "redirects when data is valid", %{conn: conn, purchase_order_master: purchase_order_master} do
      conn = put(conn, Routes.purchase_order_master_path(conn, :update, purchase_order_master), purchase_order_master: @update_attrs)
      assert redirected_to(conn) == Routes.purchase_order_master_path(conn, :show, purchase_order_master)

      conn = get(conn, Routes.purchase_order_master_path(conn, :show, purchase_order_master))
      assert html_response(conn, 200) =~ "some updated request_by"
    end

    test "renders errors when data is invalid", %{conn: conn, purchase_order_master: purchase_order_master} do
      conn = put(conn, Routes.purchase_order_master_path(conn, :update, purchase_order_master), purchase_order_master: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Purchase order master"
    end
  end

  describe "delete purchase_order_master" do
    setup [:create_purchase_order_master]

    test "deletes chosen purchase_order_master", %{conn: conn, purchase_order_master: purchase_order_master} do
      conn = delete(conn, Routes.purchase_order_master_path(conn, :delete, purchase_order_master))
      assert redirected_to(conn) == Routes.purchase_order_master_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.purchase_order_master_path(conn, :show, purchase_order_master))
      end
    end
  end

  defp create_purchase_order_master(_) do
    purchase_order_master = fixture(:purchase_order_master)
    {:ok, purchase_order_master: purchase_order_master}
  end
end
