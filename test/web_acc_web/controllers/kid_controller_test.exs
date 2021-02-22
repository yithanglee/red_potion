defmodule WebAccWeb.KidControllerTest do
  use WebAccWeb.ConnCase

  alias WebAcc.Settings

  @create_attrs %{chinese_name: "some chinese_name", father: "some father", mother: "some mother", name: "some name"}
  @update_attrs %{chinese_name: "some updated chinese_name", father: "some updated father", mother: "some updated mother", name: "some updated name"}
  @invalid_attrs %{chinese_name: nil, father: nil, mother: nil, name: nil}

  def fixture(:kid) do
    {:ok, kid} = Settings.create_kid(@create_attrs)
    kid
  end

  describe "index" do
    test "lists all kids", %{conn: conn} do
      conn = get(conn, Routes.kid_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Kids"
    end
  end

  describe "new kid" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.kid_path(conn, :new))
      assert html_response(conn, 200) =~ "New Kid"
    end
  end

  describe "create kid" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.kid_path(conn, :create), kid: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.kid_path(conn, :show, id)

      conn = get(conn, Routes.kid_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Kid"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.kid_path(conn, :create), kid: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Kid"
    end
  end

  describe "edit kid" do
    setup [:create_kid]

    test "renders form for editing chosen kid", %{conn: conn, kid: kid} do
      conn = get(conn, Routes.kid_path(conn, :edit, kid))
      assert html_response(conn, 200) =~ "Edit Kid"
    end
  end

  describe "update kid" do
    setup [:create_kid]

    test "redirects when data is valid", %{conn: conn, kid: kid} do
      conn = put(conn, Routes.kid_path(conn, :update, kid), kid: @update_attrs)
      assert redirected_to(conn) == Routes.kid_path(conn, :show, kid)

      conn = get(conn, Routes.kid_path(conn, :show, kid))
      assert html_response(conn, 200) =~ "some updated chinese_name"
    end

    test "renders errors when data is invalid", %{conn: conn, kid: kid} do
      conn = put(conn, Routes.kid_path(conn, :update, kid), kid: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Kid"
    end
  end

  describe "delete kid" do
    setup [:create_kid]

    test "deletes chosen kid", %{conn: conn, kid: kid} do
      conn = delete(conn, Routes.kid_path(conn, :delete, kid))
      assert redirected_to(conn) == Routes.kid_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.kid_path(conn, :show, kid))
      end
    end
  end

  defp create_kid(_) do
    kid = fixture(:kid)
    {:ok, kid: kid}
  end
end
