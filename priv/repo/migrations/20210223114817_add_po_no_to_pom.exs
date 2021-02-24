defmodule WebAcc.Repo.Migrations.AddPoNoToPom do
  use Ecto.Migration

  def change do
  	alter table("purchase_order_masters") do
  		add :po_no, :string
  	end

  	alter table("stock_receives") do
  		add :srn_no, :string 
  	end
  end
end
