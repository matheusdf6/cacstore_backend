defmodule Cacstore.Domain.Actions.Coupons.Find do
  @coupon_repository Application.get_env(:cacstore_backend, :coupon_repository)

  def call(%{ id: id }) do
    @coupon_repository.find(id)
  end

  def call(_params), do: { :error, "Missing ID of product" }
end
