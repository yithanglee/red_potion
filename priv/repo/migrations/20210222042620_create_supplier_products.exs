defmodule WebAcc.Repo.Migrations.CreateSupplierProducts do
  use Ecto.Migration

  def change do
    create table(:supplier_products) do
      add :supplier_id, :integer
      add :product_id, :integer

      timestamps()
    end

  end
end
