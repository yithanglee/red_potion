defmodule WebAcc.Settings.SerialNo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "serial_nos" do
    field :product_id, :integer
    field :serial_no, :string

    timestamps()
  end

  @doc false
  def changeset(serial_no, attrs) do
    serial_no
    |> cast(attrs, [:serial_no, :product_id])
    |> validate_required([:serial_no, :product_id])
  end
end
