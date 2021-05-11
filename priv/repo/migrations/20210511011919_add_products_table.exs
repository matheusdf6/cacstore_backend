defmodule Cacstore.Repo.Migrations.AddProductsTable do
  use Ecto.Migration

  def change do
    create table :products do
      add :name, :string
      add :description, :string
      add :price, :float
      add :sale_price, :float
      add :category, :string

      timestamps()
    end

    create constraint(:products, :price_must_be_greater_than_zero, check: "price > 0")
  end

end
