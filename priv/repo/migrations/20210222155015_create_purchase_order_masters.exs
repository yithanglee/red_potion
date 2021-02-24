defmodule WebAcc.Repo.Migrations.CreatePurchaseOrderMasters do
  use Ecto.Migration

  def change do
    create table(:purchase_order_masters) do
      add :order_date, :date
      add :location_id, :integer
      add :request_by, :string
      add :status, :string

      timestamps()
    end

  end
end
