defmodule WebAcc.Settings.SalesOrder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sales_orders" do
    field :product_id, :integer
    field :product_name, :string
    field :quantity, :float
    field :selling_price, :float
    field :som_id, :integer
    field :unit_price, :float

    timestamps()
  end

  @doc false
  def changeset(sales_order, attrs) do
    sales_order
    |> cast(attrs, [:som_id, :product_name, :product_id, :quantity, :selling_price, :unit_price])
    |> validate_required([:som_id, :product_name, :product_id, :quantity])
  end
end
