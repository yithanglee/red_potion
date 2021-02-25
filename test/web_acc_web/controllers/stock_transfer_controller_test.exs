defmodule WebAccWeb.StockTransferControllerTest do
  use WebAccWeb.ConnCase

  alias WebAcc.Settings

  @create_attrs %{product_id: 42, product_name: "some product_name", quantity: 120.5, stm_id: 42}
  @update_attrs %{product_id: 43, product_name: "some updated product_name", quantity: 456.7, stm_id: 43}
  @invalid_attrs %{product_id: nil, product_name: nil, quantity: nil, stm_id: nil}

  def fixture(:stock_transfer) do
    {:ok, stock_transfer} = Settings.create_stock_transfer(@create_attrs)
    stock_transfer
  end

  describe "index" do
    test "lists all stock_transfers", %{conn: conn} do
      conn = get(conn, Routes.stock_transfer_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Stock transfers"
    end
  end

  describe "new stock_transfer" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.stock_transfer_path(conn, :new))
      assert html_response(conn, 200) =~ "New Stock transfer"
    end
  end

  describe "create stock_transfer" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.stock_transfer_path(conn, :create), stock_transfer: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.stock_transfer_path(conn, :show, id)

      conn = get(conn, Routes.stock_transfer_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Stock transfer"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.stock_transfer_path(conn, :create), stock_transfer: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Stock transfer"
    end
  end

  describe "edit stock_transfer" do
    setup [:create_stock_transfer]

    test "renders form for editing chosen stock_transfer", %{conn: conn, stock_transfer: stock_transfer} do
      conn = get(conn, Routes.stock_transfer_path(conn, :edit, stock_transfer))
      assert html_response(conn, 200) =~ "Edit Stock transfer"
    end
  end

  describe "update stock_transfer" do
    setup [:create_stock_transfer]

    test "redirects when data is valid", %{conn: conn, stock_transfer: stock_transfer} do
      conn = put(conn, Routes.stock_transfer_path(conn, :update, stock_transfer), stock_transfer: @update_attrs)
      assert redirected_to(conn) == Routes.stock_transfer_path(conn, :show, stock_transfer)

      conn = get(conn, Routes.stock_transfer_path(conn, :show, stock_transfer))
      assert html_response(conn, 200) =~ "some updated product_name"
    end

    test "renders errors when data is invalid", %{conn: conn, stock_transfer: stock_transfer} do
      conn = put(conn, Routes.stock_transfer_path(conn, :update, stock_transfer), stock_transfer: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Stock transfer"
    end
  end

  describe "delete stock_transfer" do
    setup [:create_stock_transfer]

    test "deletes chosen stock_transfer", %{conn: conn, stock_transfer: stock_transfer} do
      conn = delete(conn, Routes.stock_transfer_path(conn, :delete, stock_transfer))
      assert redirected_to(conn) == Routes.stock_transfer_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.stock_transfer_path(conn, :show, stock_transfer))
      end
    end
  end

  defp create_stock_transfer(_) do
    stock_transfer = fixture(:stock_transfer)
    {:ok, stock_transfer: stock_transfer}
  end
end
