defmodule WebAccWeb.StockLevelControllerTest do
  use WebAccWeb.ConnCase

  alias WebAcc.Settings

  @create_attrs %{available: 120.5, location_id: 42, min_alert: 120.5, min_order: 120.5, onhand: 120.5, ordered: 120.5, product_id: 42}
  @update_attrs %{available: 456.7, location_id: 43, min_alert: 456.7, min_order: 456.7, onhand: 456.7, ordered: 456.7, product_id: 43}
  @invalid_attrs %{available: nil, location_id: nil, min_alert: nil, min_order: nil, onhand: nil, ordered: nil, product_id: nil}

  def fixture(:stock_level) do
    {:ok, stock_level} = Settings.create_stock_level(@create_attrs)
    stock_level
  end

  describe "index" do
    test "lists all stock_levels", %{conn: conn} do
      conn = get(conn, Routes.stock_level_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Stock levels"
    end
  end

  describe "new stock_level" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.stock_level_path(conn, :new))
      assert html_response(conn, 200) =~ "New Stock level"
    end
  end

  describe "create stock_level" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.stock_level_path(conn, :create), stock_level: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.stock_level_path(conn, :show, id)

      conn = get(conn, Routes.stock_level_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Stock level"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.stock_level_path(conn, :create), stock_level: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Stock level"
    end
  end

  describe "edit stock_level" do
    setup [:create_stock_level]

    test "renders form for editing chosen stock_level", %{conn: conn, stock_level: stock_level} do
      conn = get(conn, Routes.stock_level_path(conn, :edit, stock_level))
      assert html_response(conn, 200) =~ "Edit Stock level"
    end
  end

  describe "update stock_level" do
    setup [:create_stock_level]

    test "redirects when data is valid", %{conn: conn, stock_level: stock_level} do
      conn = put(conn, Routes.stock_level_path(conn, :update, stock_level), stock_level: @update_attrs)
      assert redirected_to(conn) == Routes.stock_level_path(conn, :show, stock_level)

      conn = get(conn, Routes.stock_level_path(conn, :show, stock_level))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, stock_level: stock_level} do
      conn = put(conn, Routes.stock_level_path(conn, :update, stock_level), stock_level: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Stock level"
    end
  end

  describe "delete stock_level" do
    setup [:create_stock_level]

    test "deletes chosen stock_level", %{conn: conn, stock_level: stock_level} do
      conn = delete(conn, Routes.stock_level_path(conn, :delete, stock_level))
      assert redirected_to(conn) == Routes.stock_level_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.stock_level_path(conn, :show, stock_level))
      end
    end
  end

  defp create_stock_level(_) do
    stock_level = fixture(:stock_level)
    {:ok, stock_level: stock_level}
  end
end
