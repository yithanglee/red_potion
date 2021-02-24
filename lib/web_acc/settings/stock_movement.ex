defmodule WebAcc.Settings.StockMovement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stock_movements" do
    field :action, :string
    field :location_id, :integer
    field :product_id, :integer
    field :quantity, :float
    field :reference, :string

    timestamps()
  end

  @doc false
  def changeset(stock_movement, attrs) do
    stock_movement
    |> cast(attrs, [:product_id, :location_id, :action, :reference, :quantity])
    |> validate_required([:product_id, :location_id, :action, :reference, :quantity])
  end
end
