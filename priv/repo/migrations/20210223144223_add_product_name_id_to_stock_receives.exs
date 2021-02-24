defmodule WebAcc.Repo.Migrations.AddProductNameIdToStockReceives do
  use Ecto.Migration

  def change do
  	alter table("stock_receives") do
  		add :product_name, :string
  		add :product_id, :integer
  	end
  end
end
