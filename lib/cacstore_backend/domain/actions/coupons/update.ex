defmodule Cacstore.Domain.Actions.Coupons.Update do
  @coupon_repository Application.get_env(:cacstore_backend, :coupon_repository)

  def call(%{ id: _id } =  params) do
    @coupon_repository.update(params)
  end

  def call(_params), do: { :error, "Invalid parameters" }
end
