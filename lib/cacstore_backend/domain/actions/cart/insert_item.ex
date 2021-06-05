defmodule Cacstore.Domain.Actions.Cart.InsertItem do
  @cart_repository Application.get_env(:cacstore_backend, :cart_repository)

  def call(%{ hash: hash, product: product, quantity: quantity }) do
    @cart_repository.insert_item(hash, product, quantity)
  end

  def call(_params), do: { :error, "Invalid parameters" }
end
