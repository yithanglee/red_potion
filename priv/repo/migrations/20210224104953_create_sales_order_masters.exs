defmodule WebAcc.Repo.Migrations.CreateSalesOrderMasters do
  use Ecto.Migration

  def change do
    create table(:sales_order_masters) do
      add :customer_id, :integer
      add :long, :float
      add :lat, :float
      add :to, :binary
      add :delivery_date, :date
      add :status, :string
      add :created_by, :string

      timestamps()
    end

  end
end
