defmodule WebAcc.Repo.Migrations.AddPomIdToPo do
  use Ecto.Migration

  def change do
  	alter table("purchase_orders") do
  		add :pom_id, :integer
  	end
  end
end
