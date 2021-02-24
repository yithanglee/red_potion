defmodule WebAcc.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :address, :string
      add :contact, :string
      add :long, :float
      add :lat, :float

      timestamps()
    end

  end
end
