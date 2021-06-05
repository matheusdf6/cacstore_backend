defmodule Cacstore.Data.Repositories.ProductRepository do
  alias Cacstore.Domain.Repositories.ProductRepositoryContract
  alias Cacstore.Data.Schemas.ProductSchema
  alias Cacstore.Repo
  alias Ecto.Multi
  import Ecto.Query

  @behaviour ProductRepositoryContract

  @impl ProductRepositoryContract
  def exists?(id) do
    { result, _args } = find_product(Repo, id)
    result
  end

  @impl ProductRepositoryContract
  def create(params) do
    params
    |> ProductSchema.changeset()
    |> Repo.insert()
    |> ProductSchema.to_product()
  end

  @impl ProductRepositoryContract
  def find(id) do
    find_product(Repo, id)
    |> ProductSchema.to_product()
  end

  @impl ProductRepositoryContract
  def get_all() do
    products = Repo.all(ProductSchema)
    |> Enum.map( fn(schema) -> ProductSchema.to_product(schema) end )
    {:ok, products}
  end

  @impl ProductRepositoryContract
  def get_many( id_list ) do
    query = from p in ProductSchema, where: p.id in ^id_list
    products = Repo.all(query)
    |> Enum.map( fn(schema) -> ProductSchema.to_product(schema) end )
    {:ok, products}
  end

  @impl ProductRepositoryContract
  def update( %{ id: id } = params) do
    Multi.new()
    |> Multi.run(:find_product, fn repo, _changes -> find_product(repo, id) end )
    |> Multi.run(:update_product, fn repo, %{ find_product: product } -> update_product(product, repo, params) end )
    |> Repo.transaction()
    |> transaction_response(:update_product)
  end

  @impl ProductRepositoryContract
  def delete( id ) do
    Multi.new()
    |> Multi.run(:find_product, fn repo, _changes -> find_product(repo, id) end )
    |> Multi.run(:delete_product, fn repo, %{ find_product: product } -> delete_product(product, repo) end )
    |> Repo.transaction()
    |> transaction_response(:delete_product)
  end

  defp find_product(repo, id) do
    case repo.get(ProductSchema, id) do
      nil -> {:not_found, "Product not found"}
      product -> {:ok, product}
    end
  end

  defp update_product({:not_found, reason}, _repo, _params ), do: { :error, reason }
  defp update_product(%ProductSchema{} = product, repo, params) do
    product
    |> ProductSchema.changeset(params)
    |> repo.update()
    |> ProductSchema.to_product()
  end

  defp delete_product({:not_found, reason}, _repo ), do: { :error, reason }
  defp delete_product(%ProductSchema{} = product, repo ) do
    case repo.delete(product) do
        { :ok, _struct } -> { :ok, "Product deleted"}
        { :error, _reason } -> { :error, "An error occurred" }
    end
  end

  defp transaction_response({:error, _operation, reason, _changes}, _operation_name), do: { :error, reason }
  defp transaction_response({:ok, changes }, operation_name ), do: { :ok, Map.get(changes, operation_name) }

end
