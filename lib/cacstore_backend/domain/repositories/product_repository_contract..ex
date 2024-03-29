defmodule Cacstore.Domain.Repositories.ProductRepositoryContract do
  alias Cacstore.Domain.Entities.Product

  @callback exists?( id :: integer ) :: :ok | :not_found

  @callback find( id :: integer ) :: {:ok, product :: %Product{} } | { :error, message :: String.t }

  @callback get_all() :: {:ok, products :: [ %Product{} ] } | {:error, message :: String.t }

  @callback get_many( id_list :: [ integer ] ) :: {:ok, products :: [ %Product{} ] } | {:error, message :: String.t }

  @callback create( params :: %{} ) :: {:ok, product :: %Product{} } | { :error, message :: String.t }

  @callback update( params :: %{} ) :: {:ok, product :: %Product{} } | { :error, message :: String.t }

  @callback delete( id :: integer ) :: :ok | :error
end
