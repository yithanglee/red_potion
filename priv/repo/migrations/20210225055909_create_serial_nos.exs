defmodule WebAcc.Repo.Migrations.CreateSerialNos do
  use Ecto.Migration

  def change do
    create table(:serial_nos) do
      add :serial_no, :string
      add :product_id, :integer

      timestamps()
    end

  end
end
