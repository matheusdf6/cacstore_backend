defmodule Cacstore.Domain.Actions.Products.Update do
  @product_repository Application.get_env(:cacstore_backend, :product_repository)

  def call(%{ id: _id } = params) do
    @product_repository.update(params)
  end

  def call(_params), do: { :error, "Invalid parameters" }
end
