defmodule WebAccWeb.StockReceiveControllerTest do
  use WebAccWeb.ConnCase

  alias WebAcc.Settings

  @create_attrs %{pom_id: 42, received_by: "some received_by", status: "some status"}
  @update_attrs %{pom_id: 43, received_by: "some updated received_by", status: "some updated status"}
  @invalid_attrs %{pom_id: nil, received_by: nil, status: nil}

  def fixture(:stock_receive) do
    {:ok, stock_receive} = Settings.create_stock_receive(@create_attrs)
    stock_receive
  end

  describe "index" do
    test "lists all stock_receives", %{conn: conn} do
      conn = get(conn, Routes.stock_receive_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Stock receives"
    end
  end

  describe "new stock_receive" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.stock_receive_path(conn, :new))
      assert html_response(conn, 200) =~ "New Stock receive"
    end
  end

  describe "create stock_receive" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.stock_receive_path(conn, :create), stock_receive: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.stock_receive_path(conn, :show, id)

      conn = get(conn, Routes.stock_receive_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Stock receive"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.stock_receive_path(conn, :create), stock_receive: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Stock receive"
    end
  end

  describe "edit stock_receive" do
    setup [:create_stock_receive]

    test "renders form for editing chosen stock_receive", %{conn: conn, stock_receive: stock_receive} do
      conn = get(conn, Routes.stock_receive_path(conn, :edit, stock_receive))
      assert html_response(conn, 200) =~ "Edit Stock receive"
    end
  end

  describe "update stock_receive" do
    setup [:create_stock_receive]

    test "redirects when data is valid", %{conn: conn, stock_receive: stock_receive} do
      conn = put(conn, Routes.stock_receive_path(conn, :update, stock_receive), stock_receive: @update_attrs)
      assert redirected_to(conn) == Routes.stock_receive_path(conn, :show, stock_receive)

      conn = get(conn, Routes.stock_receive_path(conn, :show, stock_receive))
      assert html_response(conn, 200) =~ "some updated received_by"
    end

    test "renders errors when data is invalid", %{conn: conn, stock_receive: stock_receive} do
      conn = put(conn, Routes.stock_receive_path(conn, :update, stock_receive), stock_receive: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Stock receive"
    end
  end

  describe "delete stock_receive" do
    setup [:create_stock_receive]

    test "deletes chosen stock_receive", %{conn: conn, stock_receive: stock_receive} do
      conn = delete(conn, Routes.stock_receive_path(conn, :delete, stock_receive))
      assert redirected_to(conn) == Routes.stock_receive_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.stock_receive_path(conn, :show, stock_receive))
      end
    end
  end

  defp create_stock_receive(_) do
    stock_receive = fixture(:stock_receive)
    {:ok, stock_receive: stock_receive}
  end
end
