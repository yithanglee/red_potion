defmodule WebAcc.Repo.Migrations.CreateStockTransferMaster do
  use Ecto.Migration

  def change do
    create table(:stock_transfer_master) do
      add :from_id, :integer
      add :to_id, :integer
      add :delivery_date, :date
      add :status, :string

      timestamps()
    end

  end
end
