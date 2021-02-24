defmodule WebAcc.Repo.Migrations.AddQuantityToSr do
  use Ecto.Migration

  def change do
  	alter table("stock_receives") do 
  		add :quantity, :float
  	end 
  end
end
