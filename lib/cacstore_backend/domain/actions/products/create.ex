defmodule Cacstore.Domain.Actions.Products.Create do
  @product_repository Application.get_env(:cacstore_backend, :product_repository)

  def call(params) do
    @product_repository.create(params)
  end
end
