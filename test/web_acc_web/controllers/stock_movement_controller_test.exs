defmodule WebAccWeb.StockMovementControllerTest do
  use WebAccWeb.ConnCase

  alias WebAcc.Settings

  @create_attrs %{action: "some action", location_id: 42, product_id: 42, quantity: 120.5, reference: "some reference"}
  @update_attrs %{action: "some updated action", location_id: 43, product_id: 43, quantity: 456.7, reference: "some updated reference"}
  @invalid_attrs %{action: nil, location_id: nil, product_id: nil, quantity: nil, reference: nil}

  def fixture(:stock_movement) do
    {:ok, stock_movement} = Settings.create_stock_movement(@create_attrs)
    stock_movement
  end

  describe "index" do
    test "lists all stock_movements", %{conn: conn} do
      conn = get(conn, Routes.stock_movement_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Stock movements"
    end
  end

  describe "new stock_movement" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.stock_movement_path(conn, :new))
      assert html_response(conn, 200) =~ "New Stock movement"
    end
  end

  describe "create stock_movement" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.stock_movement_path(conn, :create), stock_movement: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.stock_movement_path(conn, :show, id)

      conn = get(conn, Routes.stock_movement_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Stock movement"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.stock_movement_path(conn, :create), stock_movement: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Stock movement"
    end
  end

  describe "edit stock_movement" do
    setup [:create_stock_movement]

    test "renders form for editing chosen stock_movement", %{conn: conn, stock_movement: stock_movement} do
      conn = get(conn, Routes.stock_movement_path(conn, :edit, stock_movement))
      assert html_response(conn, 200) =~ "Edit Stock movement"
    end
  end

  describe "update stock_movement" do
    setup [:create_stock_movement]

    test "redirects when data is valid", %{conn: conn, stock_movement: stock_movement} do
      conn = put(conn, Routes.stock_movement_path(conn, :update, stock_movement), stock_movement: @update_attrs)
      assert redirected_to(conn) == Routes.stock_movement_path(conn, :show, stock_movement)

      conn = get(conn, Routes.stock_movement_path(conn, :show, stock_movement))
      assert html_response(conn, 200) =~ "some updated action"
    end

    test "renders errors when data is invalid", %{conn: conn, stock_movement: stock_movement} do
      conn = put(conn, Routes.stock_movement_path(conn, :update, stock_movement), stock_movement: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Stock movement"
    end
  end

  describe "delete stock_movement" do
    setup [:create_stock_movement]

    test "deletes chosen stock_movement", %{conn: conn, stock_movement: stock_movement} do
      conn = delete(conn, Routes.stock_movement_path(conn, :delete, stock_movement))
      assert redirected_to(conn) == Routes.stock_movement_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.stock_movement_path(conn, :show, stock_movement))
      end
    end
  end

  defp create_stock_movement(_) do
    stock_movement = fixture(:stock_movement)
    {:ok, stock_movement: stock_movement}
  end
end
