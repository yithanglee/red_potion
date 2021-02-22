defmodule WebAccWeb.RoleMenuControllerTest do
  use WebAccWeb.ConnCase

  alias WebAcc.Settings

  @create_attrs %{menu_id: 42, role_id: 42}
  @update_attrs %{menu_id: 43, role_id: 43}
  @invalid_attrs %{menu_id: nil, role_id: nil}

  def fixture(:role_menu) do
    {:ok, role_menu} = Settings.create_role_menu(@create_attrs)
    role_menu
  end

  describe "index" do
    test "lists all role_menus", %{conn: conn} do
      conn = get(conn, Routes.role_menu_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Role menus"
    end
  end

  describe "new role_menu" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.role_menu_path(conn, :new))
      assert html_response(conn, 200) =~ "New Role menu"
    end
  end

  describe "create role_menu" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.role_menu_path(conn, :create), role_menu: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.role_menu_path(conn, :show, id)

      conn = get(conn, Routes.role_menu_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Role menu"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.role_menu_path(conn, :create), role_menu: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Role menu"
    end
  end

  describe "edit role_menu" do
    setup [:create_role_menu]

    test "renders form for editing chosen role_menu", %{conn: conn, role_menu: role_menu} do
      conn = get(conn, Routes.role_menu_path(conn, :edit, role_menu))
      assert html_response(conn, 200) =~ "Edit Role menu"
    end
  end

  describe "update role_menu" do
    setup [:create_role_menu]

    test "redirects when data is valid", %{conn: conn, role_menu: role_menu} do
      conn = put(conn, Routes.role_menu_path(conn, :update, role_menu), role_menu: @update_attrs)
      assert redirected_to(conn) == Routes.role_menu_path(conn, :show, role_menu)

      conn = get(conn, Routes.role_menu_path(conn, :show, role_menu))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, role_menu: role_menu} do
      conn = put(conn, Routes.role_menu_path(conn, :update, role_menu), role_menu: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Role menu"
    end
  end

  describe "delete role_menu" do
    setup [:create_role_menu]

    test "deletes chosen role_menu", %{conn: conn, role_menu: role_menu} do
      conn = delete(conn, Routes.role_menu_path(conn, :delete, role_menu))
      assert redirected_to(conn) == Routes.role_menu_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.role_menu_path(conn, :show, role_menu))
      end
    end
  end

  defp create_role_menu(_) do
    role_menu = fixture(:role_menu)
    {:ok, role_menu: role_menu}
  end
end
