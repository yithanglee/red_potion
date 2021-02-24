defmodule WebAcc.Settings.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :address, :string
    field :contact, :string
    field :lat, :float
    field :long, :float
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:name, :address, :contact, :long, :lat])
    |> validate_required([:name, :address, :contact, :long, :lat])
  end
end
