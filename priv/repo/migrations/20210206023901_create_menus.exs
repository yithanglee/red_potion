defmodule WebAcc.Repo.Migrations.CreateMenus do
  use Ecto.Migration

  def change do
    create table(:menus) do
      add :name, :string
      add :category, :string
      add :link, :string
      add :icon, :string

      timestamps()
    end

  end
end
