defmodule Cacstore.Domain.Actions.Cart.RemoveItem do
  @cart_repository Application.get_env(:cacstore_backend, :cart_repository)

  def call(%{ hash: hash, product: product }) do
    @cart_repository.remove_item(hash, product)
  end

  def call(_params), do: { :error, "Invalid parameters" }
end
