defmodule WebAccWeb.PurchaseOrderMasterController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.PurchaseOrderMaster
  alias WebAcc.{Repo}
  import Ecto.Query

  def index(conn, params) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
      limit = String.to_integer(params["length"])
      offset = String.to_integer(params["start"])

      column_no = params["order"]["0"]["column"]
      key = params["columns"][column_no]["data"] |> String.to_atom()
      dir = params["order"]["0"]["dir"] |> String.to_atom()
      order_by = [{dir, key}]

      data =
        Repo.all(
          from(a in PurchaseOrderMaster, where: ilike(a.status, ^"%#{params["search"]["value"]}%"))
        )

      data2 =
        Repo.all(
          from(
            a in PurchaseOrderMaster,
            where: ilike(a.status, ^"%#{params["search"]["value"]}%"),
            limit: ^limit,
            offset: ^offset,
            order_by: ^order_by
          )
        )
        |> Enum.map(fn x -> Utility.s_to_map(x) end)

      json = %{
        data: data2,
        recordsTotal: Enum.count(data2),
        recordsFiltered: Enum.count(data),
        draw: String.to_integer(params["draw"])
      }

      conn
      |> put_resp_content_type("application/json")
      |> send_resp(
        200,
        Jason.encode!(json)
      )
    else
      purchase_order_masters = Settings.list_purchase_order_masters()
      render(conn, "index.html", purchase_order_masters: purchase_order_masters)
    end
  end

  def new(conn, _params) do
    changeset = Settings.change_purchase_order_master(%PurchaseOrderMaster{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"purchase_order_masters" => purchase_order_master_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
      if purchase_order_master_params["id"] != nil do
        purchase_order_master =
          if purchase_order_master_params["id"] == "0" do
            nil
          else
            Settings.get_purchase_order_master!(purchase_order_master_params["id"])
          end

        if purchase_order_master == nil do
          case Settings.create_purchase_order_master(purchase_order_master_params) do
            {:ok, purchase_order_master} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(purchase_order_master)))

            {:error, %Ecto.Changeset{} = changeset} ->
              errors = changeset.errors |> Keyword.keys()

              {reason, message} = changeset.errors |> hd()
              {proper_message, message_list} = message
              final_reason = Atom.to_string(reason) <> " " <> proper_message

              conn
              |> put_resp_content_type("application/json")
              |> send_resp(500, Jason.encode!(%{status: final_reason}))
          end
        else
          case Settings.update_purchase_order_master(
                 purchase_order_master,
                 purchase_order_master_params
               ) do
            {:ok, purchase_order_master} ->
              conn
              |> put_resp_content_type("application/json")
              |> send_resp(200, Jason.encode!(Utility.s_to_map(purchase_order_master)))

            {:error, %Ecto.Changeset{} = changeset} ->
              errors = changeset.errors |> Keyword.keys()

              {reason, message} = changeset.errors |> hd()
              {proper_message, message_list} = message
              final_reason = Atom.to_string(reason) <> " " <> proper_message

              conn
              |> put_resp_content_type("application/json")
              |> send_resp(500, Jason.encode!(%{status: final_reason}))
          end
        end
      end
    else
      case Settings.create_purchase_order_master(purchase_order_master_params) do
        {:ok, purchase_order_master} ->
          conn
          |> put_flash(:info, "Purchase order master created successfully.")
          |> redirect(to: Routes.purchase_order_master_path(conn, :show, purchase_order_master))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    purchase_order_master = Settings.get_purchase_order_master!(id)
    render(conn, "show.html", purchase_order_master: purchase_order_master)
  end

  def edit(conn, %{"id" => id}) do
    purchase_order_master = Settings.get_purchase_order_master!(id)
    changeset = Settings.change_purchase_order_master(purchase_order_master)
    render(conn, "edit.html", purchase_order_master: purchase_order_master, changeset: changeset)
  end

  def update(conn, %{"id" => id, "purchase_order_master" => purchase_order_master_params}) do
    purchase_order_master = Settings.get_purchase_order_master!(id)

    case Settings.update_purchase_order_master(
           purchase_order_master,
           purchase_order_master_params
         ) do
      {:ok, purchase_order_master} ->
        conn
        |> put_flash(:info, "Purchase order master updated successfully.")
        |> redirect(to: Routes.purchase_order_master_path(conn, :show, purchase_order_master))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html",
          purchase_order_master: purchase_order_master,
          changeset: changeset
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    purchase_order_master = Repo.get(PurchaseOrderMaster, id)

    if purchase_order_master != nil do
      {:ok, _purchase_order_master} = Settings.delete_purchase_order_master(purchase_order_master)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "Purchase order master deleted successfully.")
        |> redirect(to: Routes.purchase_order_master_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
