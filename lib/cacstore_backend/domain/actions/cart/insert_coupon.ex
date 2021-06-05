defmodule Cacstore.Domain.Actions.Cart.InsertCoupon do
  @cart_repository Application.get_env(:cacstore_backend, :cart_repository)

  def call(%{ hash: hash, coupon: coupon }) do
    @cart_repository.insert_coupon(hash, coupon)
  end

  def call(_params), do: { :error, "Invalid parameters" }
end
