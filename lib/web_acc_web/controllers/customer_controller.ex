defmodule WebAccWeb.CustomerController do
  use WebAccWeb, :controller

  alias WebAcc.Settings
  alias WebAcc.Settings.Customer
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
        Repo.all(from(a in Customer, where: ilike(a.name, ^"%#{params["search"]["value"]}%")))

      data2 =
        Repo.all(
          from(
            a in Customer,
            where: ilike(a.name, ^"%#{params["search"]["value"]}%"),
            limit: ^limit,
            offset: ^offset,
            order_by: ^order_by
          )
        )
        |> Enum.map(fn x -> Utility.s_to_map(x) end)
      json =
      %{
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
      customers = Settings.list_customers()
      render(conn, "index.html", customers: customers)
    end 
  end

  def new(conn, _params) do
    changeset = Settings.change_customer(%Customer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"customers" => customer_params}) do
    if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        if customer_params["id"] != nil do
          customer = 
          if customer_params["id"] == "0" do
            nil 
            else
            Settings.get_customer!( customer_params["id"] )
          end

          if customer == nil do
              case Settings.create_customer(customer_params) do
                {:ok, customer} ->
                  conn
                  |> put_resp_content_type("application/json")
                  |> send_resp(200, Jason.encode!(Utility.s_to_map(customer)))
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
              case Settings.update_customer(customer, customer_params) do
                {:ok, customer} ->
                  conn
                  |> put_resp_content_type("application/json")
                  |> send_resp(200, Jason.encode!(Utility.s_to_map(customer)))
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
      case Settings.create_customer(customer_params) do
        {:ok, customer} ->
          conn
          |> put_flash(:info, "Customer created successfully.")
          |> redirect(to: Routes.customer_path(conn, :show, customer))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    customer = Settings.get_customer!(id)
    render(conn, "show.html", customer: customer)
  end

  def edit(conn, %{"id" => id}) do
    customer = Settings.get_customer!(id)
    changeset = Settings.change_customer(customer)
    render(conn, "edit.html", customer: customer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "customer" => customer_params}) do
    customer = Settings.get_customer!(id)

    case Settings.update_customer(customer, customer_params) do
      {:ok, customer} ->
        conn
        |> put_flash(:info, "Customer updated successfully.")
        |> redirect(to: Routes.customer_path(conn, :show, customer))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", customer: customer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer = Repo.get(Customer , (id))

    if customer != nil do
        {:ok, _customer} = Settings.delete_customer(customer)

      if Enum.any?(conn.path_info, fn x -> x == "api" end) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(%{status: "ok"}))
      else
        conn
        |> put_flash(:info, "Customer deleted successfully.")
        |> redirect(to: Routes.customer_path(conn, :index))
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
    end
  end
end
