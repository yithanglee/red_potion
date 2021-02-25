defmodule WebAcc.Settings.StockTransferMaster do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stock_transfer_master" do
    field :delivery_date, :date
    field :from_id, :integer
    field :status, :string
    field :to_id, :integer

    timestamps()
  end

  @doc false
  def changeset(stock_transfer_master, attrs) do
    stock_transfer_master
    |> cast(attrs, [:from_id, :to_id, :delivery_date, :status])
    |> validate_required([:from_id, :to_id, :delivery_date, :status])
  end
end
