defmodule WebAcc.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :name, :string
      add :phone, :string
      add :email, :string
      add :address, :string
      add :organization, :string
      add :terms, :string

      timestamps()
    end

  end
end
