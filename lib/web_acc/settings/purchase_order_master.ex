defmodule WebAcc.Settings.PurchaseOrderMaster do
  use Ecto.Schema
  import Ecto.Changeset

  schema "purchase_order_masters" do
    field :location_id, :integer
    field :order_date, :date
    field :request_by, :string
    field :status, :string
    field :po_no, :string
    timestamps()
  end

  @doc false
  def changeset(purchase_order_master, attrs) do
    purchase_order_master
    |> cast(attrs, [:po_no, :order_date, :location_id, :request_by, :status])
    |> validate_required([:order_date, :location_id, :request_by, :status])
  end
end
