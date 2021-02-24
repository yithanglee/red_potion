defmodule WebAcc.Settings.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :address, :string
    field :email, :string
    field :name, :string
    field :organization, :string
    field :phone, :string
    field :terms, :string

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:name, :phone, :email, :address, :organization, :terms])
    |> validate_required([:name, :phone, :email, :address, :organization, :terms])
  end
end
