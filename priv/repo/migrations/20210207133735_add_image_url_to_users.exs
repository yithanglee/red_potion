defmodule WebAcc.Repo.Migrations.AddImageUrlToUsers do
  use Ecto.Migration

  def change do
  	alter table("users") do
  		add :image_url, :binary
  	end
  end
end
