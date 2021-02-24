defmodule WebAcc.Settings.SalesOrderMaster do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sales_order_masters" do
    field :created_by, :string
    field :customer_id, :integer
    field :delivery_date, :date
    field :lat, :float
    field :long, :float
    field :status, :string
    field :to, :binary
    field :location_id, :integer
    timestamps()
  end

  @doc false
  def changeset(sales_order_master, attrs) do
    sales_order_master
    |> cast(attrs, [
      :location_id,
      :customer_id,
      :long,
      :lat,
      :to,
      :delivery_date,
      :status,
      :created_by
    ])
    |> validate_required([:customer_id, :long, :lat, :to, :delivery_date, :status, :created_by])
  end
end
