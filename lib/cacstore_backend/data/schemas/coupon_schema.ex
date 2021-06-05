defmodule Cacstore.Data.Schemas.CouponSchema do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cacstore.Domain.Entities.Coupon

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [ :code, :type_of_discount, :discount ]

  schema "coupons" do
    field :code, :string
    field :type_of_discount, :string
    field :discount, :float

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> check_constraint(:coupons, name: :price_must_be_greater_than_zero)
  end

  def to_coupon({ :ok, %__MODULE__{} = coupon }), do: {:ok, to_coupon(coupon) }
  def to_coupon( %__MODULE__{} = coupon ), do: struct( %Coupon{}, Map.from_struct(coupon) )
  def to_coupon(params), do: params
end
