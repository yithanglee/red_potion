defmodule WebAcc.Repo.Migrations.CreateStockReceives do
  use Ecto.Migration

  def change do
    create table(:stock_receives) do
      add :pom_id, :integer
      add :received_by, :string
      add :status, :string

      timestamps()
    end

  end
end
