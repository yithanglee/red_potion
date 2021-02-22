defmodule WebAcc.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :username, :string
      add :password, :string
      add :crypted_password, :binary
      add :role, :string
      add :role_id, :integer

      timestamps()
    end

  end
end
