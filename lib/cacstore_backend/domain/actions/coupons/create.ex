defmodule Cacstore.Domain.Actions.Coupons.Create do
  @coupon_repository Application.get_env(:cacstore_backend, :coupon_repository)

  def call(%{ code: _code, type_of_discount: _type, discount: _discount  } =  params) do
    @coupon_repository.create(params)
  end

  def call(_params), do: { :error, "Invalid parameters" }
end
