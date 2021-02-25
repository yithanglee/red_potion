defmodule WebAccWeb.StockTransferMasterControllerTest do
  use WebAccWeb.ConnCase

  alias WebAcc.Settings

  @create_attrs %{delivery_date: ~D[2010-04-17], from_id: 42, status: "some status", to_id: 42}
  @update_attrs %{delivery_date: ~D[2011-05-18], from_id: 43, status: "some updated status", to_id: 43}
  @invalid_attrs %{delivery_date: nil, from_id: nil, status: nil, to_id: nil}

  def fixture(:stock_transfer_master) do
    {:ok, stock_transfer_master} = Settings.create_stock_transfer_master(@create_attrs)
    stock_transfer_master
  end

  describe "index" do
    test "lists all stock_transfer_master", %{conn: conn} do
      conn = get(conn, Routes.stock_transfer_master_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Stock transfer master"
    end
  end

  describe "new stock_transfer_master" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.stock_transfer_master_path(conn, :new))
      assert html_response(conn, 200) =~ "New Stock transfer master"
    end
  end

  describe "create stock_transfer_master" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.stock_transfer_master_path(conn, :create), stock_transfer_master: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.stock_transfer_master_path(conn, :show, id)

      conn = get(conn, Routes.stock_transfer_master_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Stock transfer master"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.stock_transfer_master_path(conn, :create), stock_transfer_master: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Stock transfer master"
    end
  end

  describe "edit stock_transfer_master" do
    setup [:create_stock_transfer_master]

    test "renders form for editing chosen stock_transfer_master", %{conn: conn, stock_transfer_master: stock_transfer_master} do
      conn = get(conn, Routes.stock_transfer_master_path(conn, :edit, stock_transfer_master))
      assert html_response(conn, 200) =~ "Edit Stock transfer master"
    end
  end

  describe "update stock_transfer_master" do
    setup [:create_stock_transfer_master]

    test "redirects when data is valid", %{conn: conn, stock_transfer_master: stock_transfer_master} do
      conn = put(conn, Routes.stock_transfer_master_path(conn, :update, stock_transfer_master), stock_transfer_master: @update_attrs)
      assert redirected_to(conn) == Routes.stock_transfer_master_path(conn, :show, stock_transfer_master)

      conn = get(conn, Routes.stock_transfer_master_path(conn, :show, stock_transfer_master))
      assert html_response(conn, 200) =~ "some updated status"
    end

    test "renders errors when data is invalid", %{conn: conn, stock_transfer_master: stock_transfer_master} do
      conn = put(conn, Routes.stock_transfer_master_path(conn, :update, stock_transfer_master), stock_transfer_master: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Stock transfer master"
    end
  end

  describe "delete stock_transfer_master" do
    setup [:create_stock_transfer_master]

    test "deletes chosen stock_transfer_master", %{conn: conn, stock_transfer_master: stock_transfer_master} do
      conn = delete(conn, Routes.stock_transfer_master_path(conn, :delete, stock_transfer_master))
      assert redirected_to(conn) == Routes.stock_transfer_master_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.stock_transfer_master_path(conn, :show, stock_transfer_master))
      end
    end
  end

  defp create_stock_transfer_master(_) do
    stock_transfer_master = fixture(:stock_transfer_master)
    {:ok, stock_transfer_master: stock_transfer_master}
  end
end
