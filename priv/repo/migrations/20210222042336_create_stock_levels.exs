defmodule WebAcc.Repo.Migrations.CreateStockLevels do
  use Ecto.Migration

  def change do
    create table(:stock_levels) do
      add :product_id, :integer
      add :location_id, :integer
      add :onhand, :float
      add :available, :float
      add :ordered, :float
      add :min_order, :float
      add :min_alert, :float

      timestamps()
    end

  end
end
