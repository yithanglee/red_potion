defmodule WebAcc.Settings.StockTransfer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stock_transfers" do
    field :product_id, :integer
    field :product_name, :string
    field :quantity, :float
    field :stm_id, :integer

    timestamps()
  end

  @doc false
  def changeset(stock_transfer, attrs) do
    stock_transfer
    |> cast(attrs, [:stm_id, :product_id, :product_name, :quantity])
    |> validate_required([:stm_id, :product_id, :product_name, :quantity])
  end
end
