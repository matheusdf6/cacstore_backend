defmodule Cacstore.Domain.Actions.Coupons.GetAll do
  @coupon_repository Application.get_env(:cacstore_backend, :coupon_repository)

  def call() do
    @coupon_repository.get_all()
  end
end
