defmodule WebAcc.Repo.Migrations.AddLocationIdToSom do
  use Ecto.Migration

  def change do
  	alter table("sales_order_masters") do
  		add :location_id, :integer
  	end
  end
end
