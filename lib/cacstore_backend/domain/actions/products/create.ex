defmodule Cacstore.Domain.Actions.Products.Create do
  @product_repository Application.get_env(:cacstore_backend, :product_repository)

  def call(%{ name: _name, description: _description, price: _price } = params) do
    @product_repository.create(params)
  end

  def call(_params), do: { :error, "Invalid parameters" }
end
