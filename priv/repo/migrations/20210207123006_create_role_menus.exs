defmodule WebAcc.Repo.Migrations.CreateRoleMenus do
  use Ecto.Migration

  def change do
    create table(:role_menus) do
      add :role_id, :integer
      add :menu_id, :integer

      timestamps()
    end

  end
end
