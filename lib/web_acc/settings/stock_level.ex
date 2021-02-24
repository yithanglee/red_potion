defmodule WebAcc.Settings.StockLevel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stock_levels" do
    field :available, :float
    field :location_id, :integer
    field :min_alert, :float
    field :min_order, :float
    field :onhand, :float
    field :ordered, :float
    field :product_id, :integer

    timestamps()
  end

  @doc false
  def changeset(stock_level, attrs) do
    stock_level
    |> cast(attrs, [
      :product_id,
      :location_id,
      :onhand,
      :available,
      :ordered,
      :min_order,
      :min_alert
    ])
    |> validate_required([:product_id, :location_id])
  end
end
