defmodule Cacstore.Domain.Actions.Cart.Clean do
  @cart_repository Application.get_env(:cacstore_backend, :cart_repository)

  def call(%{ hash: hash }) do
    @cart_repository.clean(hash)
  end

  def call(_params), do: { :error, "Invalid parameters" }
end
