defmodule WebAcc.Repo.Migrations.AddProductIdToPo do
  use Ecto.Migration

  def change do
	alter table("purchase_orders") do
		add :product_id, :integer
	end
  end
end
