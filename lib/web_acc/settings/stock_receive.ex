defmodule WebAcc.Settings.StockReceive do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stock_receives" do
    field :pom_id, :integer
    field :received_by, :string
    field :status, :string
    field :srn_no, :string
    field :product_name, :string
    field :product_id, :integer
    field :srm_id, :integer
    field :quantity, :float
    timestamps()
  end

  @doc false
  def changeset(stock_receive, attrs) do
    stock_receive
    |> cast(attrs, [
      :quantity,
      :srm_id,
      :product_name,
      :product_id,
      :srn_no,
      :pom_id,
      :received_by,
      :status
    ])
    |> validate_required([:pom_id, :product_name, :product_id])
  end
end
