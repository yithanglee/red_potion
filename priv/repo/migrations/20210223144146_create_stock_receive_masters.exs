defmodule WebAcc.Repo.Migrations.CreateStockReceiveMasters do
  use Ecto.Migration

  def change do
    create table(:stock_receive_masters) do
      add :pom_id, :integer
      add :srn_no, :string
      add :status, :string

      timestamps()
    end

  end
end
