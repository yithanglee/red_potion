defmodule WebAccWeb.StockReceiveMasterControllerTest do
  use WebAccWeb.ConnCase

  alias WebAcc.Settings

  @create_attrs %{pom_id: 42, srn_no: "some srn_no", status: "some status"}
  @update_attrs %{pom_id: 43, srn_no: "some updated srn_no", status: "some updated status"}
  @invalid_attrs %{pom_id: nil, srn_no: nil, status: nil}

  def fixture(:stock_receive_master) do
    {:ok, stock_receive_master} = Settings.create_stock_receive_master(@create_attrs)
    stock_receive_master
  end

  describe "index" do
    test "lists all stock_receive_masters", %{conn: conn} do
      conn = get(conn, Routes.stock_receive_master_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Stock receive masters"
    end
  end

  describe "new stock_receive_master" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.stock_receive_master_path(conn, :new))
      assert html_response(conn, 200) =~ "New Stock receive master"
    end
  end

  describe "create stock_receive_master" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.stock_receive_master_path(conn, :create), stock_receive_master: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.stock_receive_master_path(conn, :show, id)

      conn = get(conn, Routes.stock_receive_master_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Stock receive master"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.stock_receive_master_path(conn, :create), stock_receive_master: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Stock receive master"
    end
  end

  describe "edit stock_receive_master" do
    setup [:create_stock_receive_master]

    test "renders form for editing chosen stock_receive_master", %{conn: conn, stock_receive_master: stock_receive_master} do
      conn = get(conn, Routes.stock_receive_master_path(conn, :edit, stock_receive_master))
      assert html_response(conn, 200) =~ "Edit Stock receive master"
    end
  end

  describe "update stock_receive_master" do
    setup [:create_stock_receive_master]

    test "redirects when data is valid", %{conn: conn, stock_receive_master: stock_receive_master} do
      conn = put(conn, Routes.stock_receive_master_path(conn, :update, stock_receive_master), stock_receive_master: @update_attrs)
      assert redirected_to(conn) == Routes.stock_receive_master_path(conn, :show, stock_receive_master)

      conn = get(conn, Routes.stock_receive_master_path(conn, :show, stock_receive_master))
      assert html_response(conn, 200) =~ "some updated srn_no"
    end

    test "renders errors when data is invalid", %{conn: conn, stock_receive_master: stock_receive_master} do
      conn = put(conn, Routes.stock_receive_master_path(conn, :update, stock_receive_master), stock_receive_master: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Stock receive master"
    end
  end

  describe "delete stock_receive_master" do
    setup [:create_stock_receive_master]

    test "deletes chosen stock_receive_master", %{conn: conn, stock_receive_master: stock_receive_master} do
      conn = delete(conn, Routes.stock_receive_master_path(conn, :delete, stock_receive_master))
      assert redirected_to(conn) == Routes.stock_receive_master_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.stock_receive_master_path(conn, :show, stock_receive_master))
      end
    end
  end

  defp create_stock_receive_master(_) do
    stock_receive_master = fixture(:stock_receive_master)
    {:ok, stock_receive_master: stock_receive_master}
  end
end
