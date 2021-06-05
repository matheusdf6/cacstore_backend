defmodule Cacstore.Domain.Repositories.CouponRepositoryContract do
  alias Cacstore.Domain.Entities.Coupon

  @callback find( id :: integer ) :: {:ok, Coupon :: %Coupon{} } | { :error, message :: String.t }

  @callback get_all() :: {:ok, Coupons :: [ %Coupon{} ] } | {:error, message :: String.t }

  @callback create( params :: %{} ) :: {:ok, Coupon :: %Coupon{} } | { :error, message :: String.t }

  @callback update( params :: %{} ) :: {:ok, Coupon :: %Coupon{} } | { :error, message :: String.t }

  @callback delete( id :: integer ) :: :ok | :error
end
