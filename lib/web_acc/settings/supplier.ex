defmodule WebAcc.Settings.Supplier do
  use Ecto.Schema
  import Ecto.Changeset

  schema "suppliers" do
    field :address, :string
    field :contact, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(supplier, attrs) do
    supplier
    |> cast(attrs, [:name, :address, :contact])
    |> validate_required([:name, :address, :contact])
  end
end
