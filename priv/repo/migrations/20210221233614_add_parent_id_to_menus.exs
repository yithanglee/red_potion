defmodule WebAcc.Repo.Migrations.AddParentIdToMenus do
  use Ecto.Migration

  def change do
  	alter table("menus") do
  		add :parent_id, :integer
  	end
  end
end
