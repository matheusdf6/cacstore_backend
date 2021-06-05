defmodule Cacstore.Domain.Repositories.CouponRepositoryContract do
  alias Cacstore.Domain.Entities.Coupon

  @callback exists?( id :: integer ) :: :ok | :not_found

  @callback find( id :: integer ) :: {:ok, coupon :: Coupon.t } | { :not_found, message :: String.t }

  @callback get_all() :: {:ok, coupons :: [ Coupon.t ] } | {:error, message :: String.t }

  @callback create( params :: %{} ) :: {:ok, coupon :: Coupon.t } | { :error, message :: String.t }

  @callback update( params :: %{} ) :: {:ok, coupon :: Coupon.t } | { :error, message :: String.t }

  @callback delete( id :: integer ) :: :ok | :error
end
