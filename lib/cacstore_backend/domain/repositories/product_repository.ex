defmodule Cacstore.Domain.Repositories.ProductRepository do
  alias Cacstore.Domain.Entities.Product

  @callback find( id :: integer ) :: {:ok, product :: %Product{} } | { :error, message :: String.t }

  @callback get_all() :: {:ok, products :: [ %Product{} ] } | {:error, message :: String.t }

  @callback create( id :: integer, name :: String.t, description :: String.t, price :: float, sale_price :: float|nil, category :: atom ) :: {:ok, product :: %Product{} } | { :error, message :: String.t }

  @callback update( id :: integer, product :: %Product{} ) :: {:ok, product :: %Product{} } | { :error, message :: String.t }

  @callback delete( id :: integer ) :: :ok | :error
end
