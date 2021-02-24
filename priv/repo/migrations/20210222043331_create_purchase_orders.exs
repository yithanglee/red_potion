defmodule WebAcc.Repo.Migrations.CreatePurchaseOrders do
  use Ecto.Migration

  def change do
    create table(:purchase_orders) do
      add :supplier_product_id, :integer
      add :quantity, :float

      timestamps()
    end

  end
end
