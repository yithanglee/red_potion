defmodule WebAcc.Settings.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :image_url, :binary
    field :long_desc, :binary
    field :name, :string
    field :retail_price, :float
    field :short_desc, :binary
    field :sku, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:sku, :name, :image_url, :retail_price, :short_desc, :long_desc])
    |> validate_required([:sku, :name, :retail_price, :short_desc])
  end
end
