defmodule Cacstore.Domain.Actions.Products.Update do
  @product_repository Application.get_env(:cacstore_backend, :product_repository)

  def call(params) do
    @product_repository.update(params)
  end
end
