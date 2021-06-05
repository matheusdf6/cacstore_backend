defmodule Cacstore.Repo.Migrations.AddCouponsTable do
  use Ecto.Migration

  def change do
    create table :coupons do
      add :code, :string
      add :type_of_discount, :string
      add :discount, :float

      timestamps()
    end

    create constraint(:coupons, :price_must_be_greater_than_zero, check: "discount > 0")
  end
end
