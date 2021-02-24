defmodule WebAcc.Settings.PurchaseOrder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "purchase_orders" do
    field :product_id, :integer
    field :quantity, :float
    field :supplier_product_id, :integer
    field :pom_id, :integer
    timestamps()
  end

  @doc false
  def changeset(purchase_order, attrs) do
    purchase_order
    |> cast(attrs, [:product_id, :supplier_product_id, :quantity, :pom_id])
    |> validate_required([:product_id, :quantity])
  end
end
