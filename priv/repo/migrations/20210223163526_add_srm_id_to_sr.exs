defmodule WebAcc.Repo.Migrations.AddSrmIdToSr do
  use Ecto.Migration

  def change do
  	alter table("stock_receives") do
  		add :srm_id, :integer
  	end
  end
end
