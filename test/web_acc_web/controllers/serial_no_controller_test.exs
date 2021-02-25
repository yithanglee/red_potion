defmodule WebAccWeb.SerialNoControllerTest do
  use WebAccWeb.ConnCase

  alias WebAcc.Settings

  @create_attrs %{product_id: 42, serial_no: "some serial_no"}
  @update_attrs %{product_id: 43, serial_no: "some updated serial_no"}
  @invalid_attrs %{product_id: nil, serial_no: nil}

  def fixture(:serial_no) do
    {:ok, serial_no} = Settings.create_serial_no(@create_attrs)
    serial_no
  end

  describe "index" do
    test "lists all serial_nos", %{conn: conn} do
      conn = get(conn, Routes.serial_no_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Serial nos"
    end
  end

  describe "new serial_no" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.serial_no_path(conn, :new))
      assert html_response(conn, 200) =~ "New Serial no"
    end
  end

  describe "create serial_no" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.serial_no_path(conn, :create), serial_no: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.serial_no_path(conn, :show, id)

      conn = get(conn, Routes.serial_no_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Serial no"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.serial_no_path(conn, :create), serial_no: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Serial no"
    end
  end

  describe "edit serial_no" do
    setup [:create_serial_no]

    test "renders form for editing chosen serial_no", %{conn: conn, serial_no: serial_no} do
      conn = get(conn, Routes.serial_no_path(conn, :edit, serial_no))
      assert html_response(conn, 200) =~ "Edit Serial no"
    end
  end

  describe "update serial_no" do
    setup [:create_serial_no]

    test "redirects when data is valid", %{conn: conn, serial_no: serial_no} do
      conn = put(conn, Routes.serial_no_path(conn, :update, serial_no), serial_no: @update_attrs)
      assert redirected_to(conn) == Routes.serial_no_path(conn, :show, serial_no)

      conn = get(conn, Routes.serial_no_path(conn, :show, serial_no))
      assert html_response(conn, 200) =~ "some updated serial_no"
    end

    test "renders errors when data is invalid", %{conn: conn, serial_no: serial_no} do
      conn = put(conn, Routes.serial_no_path(conn, :update, serial_no), serial_no: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Serial no"
    end
  end

  describe "delete serial_no" do
    setup [:create_serial_no]

    test "deletes chosen serial_no", %{conn: conn, serial_no: serial_no} do
      conn = delete(conn, Routes.serial_no_path(conn, :delete, serial_no))
      assert redirected_to(conn) == Routes.serial_no_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.serial_no_path(conn, :show, serial_no))
      end
    end
  end

  defp create_serial_no(_) do
    serial_no = fixture(:serial_no)
    {:ok, serial_no: serial_no}
  end
end
