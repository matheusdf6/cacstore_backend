defmodule Cacstore.Domain.Actions.Products.Delete do
  @product_repository Application.get_env(:cacstore_backend, :product_repository)

  def call(%{ id: id }) do
    @product_repository.delete(id)
  end

  def call(_params), do: { :error, "Missing ID of product" }
end
