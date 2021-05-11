defmodule Cacstore.Data.Repositories.ProductRepository do
  alias Cacstore.Domain.Repositories.ProductRepositoryContract
  alias Cacstore.Data.Schemas.ProductSchema
  alias Cacstore.Repo

  @behaviour ProductRepositoryContract

  @impl ProductRepositoryContract
  def create(params) do
    params
    |> ProductSchema.changeset()
    |> Repo.insert()
    |> ProductSchema.to_domain()
  end

  @impl ProductRepositoryContract
  def find(_id) do
    { :error, :not_implemented }
  end

  @impl ProductRepositoryContract
  def get_all() do
    { :error, :not_implemented }
  end

  @impl ProductRepositoryContract
  def update(_id, _product) do
    { :error, :not_implemented }
  end

  @impl ProductRepositoryContract
  def delete(_id) do
    { :error, :not_implemented }
  end
end
