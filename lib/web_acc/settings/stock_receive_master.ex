defmodule WebAcc.Settings.StockReceiveMaster do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stock_receive_masters" do
    field :pom_id, :integer
    field :srn_no, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(stock_receive_master, attrs) do
    stock_receive_master
    |> cast(attrs, [:pom_id, :srn_no, :status])
    |> validate_required([:pom_id, :srn_no, :status])
  end
end
