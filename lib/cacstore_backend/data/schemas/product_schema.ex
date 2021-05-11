defmodule Cacstore.Data.Schemas.ProductSchema do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cacstore.Domain.Entities.Product

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [ :name, :description, :price ]

  schema "products" do
    field :name, :string
    field :description, :string
    field :price, :float
    field :sale_price, :float
    field :category, :string

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> check_constraint(:products, name: :price_must_be_greater_than_zero)
  end

  def to_domain({ :ok, %{id: id, name: name, description: description, price: price, sale_price: sale_price, category: category} }) do
    {:ok, %Product{id: id, name: name, description: description, price: price, sale_price: sale_price, category: category}}
  end
end
