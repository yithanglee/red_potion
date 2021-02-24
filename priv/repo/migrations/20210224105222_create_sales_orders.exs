defmodule WebAcc.Repo.Migrations.CreateSalesOrders do
  use Ecto.Migration

  def change do
    create table(:sales_orders) do
      add :som_id, :integer
      add :product_name, :string
      add :product_id, :integer
      add :quantity, :float
      add :selling_price, :float
      add :unit_price, :float

      timestamps()
    end

  end
end
