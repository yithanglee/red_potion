defmodule WebAcc.Settings.Menu do
  use Ecto.Schema
  import Ecto.Changeset

  schema "menus" do
    field :category, :string
    field :icon, :string
    field :link, :string
    field :name, :string
    field :parent_id, :integer

    timestamps()
  end

  @doc false
  def changeset(menu, attrs) do
    menu
    |> cast(attrs, [:parent_id, :name, :category, :link, :icon])
    |> validate_required([:name, :category, :link, :icon])
  end
end
