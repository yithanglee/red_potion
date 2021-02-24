defmodule WebAcc.Repo.Migrations.CreateSuppliers do
  use Ecto.Migration

  def change do
    create table(:suppliers) do
      add :name, :string
      add :address, :string
      add :contact, :string

      timestamps()
    end

  end
end
