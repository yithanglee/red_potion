defmodule WebAcc.Settings.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :crypted_password, :binary
    field :name, :string
    field :password, :string
    field :role, :string
    field :role_id, :integer
    field :username, :string

    field :image_url, :binary
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:image_url, :name, :username, :crypted_password, :role, :role_id])
    |> validate_required([:name, :username])
  end
end
