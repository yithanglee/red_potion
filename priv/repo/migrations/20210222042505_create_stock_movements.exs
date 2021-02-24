defmodule WebAcc.Repo.Migrations.CreateStockMovements do
  use Ecto.Migration

  def change do
    create table(:stock_movements) do
      add :product_id, :integer
      add :location_id, :integer
      add :action, :string
      add :reference, :string
      add :quantity, :float

      timestamps()
    end

  end
end
