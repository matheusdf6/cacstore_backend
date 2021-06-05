defmodule Cacstore.Domain.Repositories.CartRepositoryContract do
  alias Cacstore.Domain.Entities.Cart

  @callback get_info( hash :: String.t ) :: Cart.t

  @callback clean( hash :: String.t ) :: :ok | :error

  @callback insert_item( hash :: String.t, product :: any, quantity :: integer ) :: :ok | :error

  @callback remove_item( hash :: String.t, product :: any ) :: :ok | :error

  @callback update_item( hash :: String.t, product :: any, quantity :: integer ) :: :ok | :error

  @callback insert_coupon( hash :: String.t, coupon :: any ) :: :ok | :error

  @callback remove_coupon( hash :: String.t ) :: :ok | :error

end
