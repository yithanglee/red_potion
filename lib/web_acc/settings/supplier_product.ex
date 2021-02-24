defmodule WebAcc.Settings.SupplierProduct do
  use Ecto.Schema
  import Ecto.Changeset

  schema "supplier_products" do
    field :product_id, :integer
    field :supplier_id, :integer

    timestamps()
  end

  @doc false
  def changeset(supplier_product, attrs) do
    supplier_product
    |> cast(attrs, [:supplier_id, :product_id])
    |> validate_required([:supplier_id, :product_id])
  end
end
