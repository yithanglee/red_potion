defmodule WebAcc.Settings.RoleMenu do
  use Ecto.Schema
  import Ecto.Changeset

  schema "role_menus" do
    field :menu_id, :integer
    field :role_id, :integer

    timestamps()
  end

  @doc false
  def changeset(role_menu, attrs) do
    role_menu
    |> cast(attrs, [:role_id, :menu_id])
    |> validate_required([:role_id, :menu_id])
  end
end
