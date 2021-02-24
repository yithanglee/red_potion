defmodule WebAcc.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :sku, :string
      add :name, :string
      add :image_url, :binary
      add :retail_price, :float
      add :short_desc, :binary
      add :long_desc, :binary

      timestamps()
    end

  end
end
