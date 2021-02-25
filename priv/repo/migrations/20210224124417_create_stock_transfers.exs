defmodule WebAcc.Repo.Migrations.CreateStockTransfers do
  use Ecto.Migration

  def change do
    create table(:stock_transfers) do
      add :stm_id, :integer
      add :product_id, :integer
      add :product_name, :string
      add :quantity, :float

      timestamps()
    end

  end
end
