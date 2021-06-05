defmodule Cacstore.Domain.Actions.Cart.GetInfo do
  @cart_repository Application.get_env(:cacstore_backend, :cart_repository)

  def call(%{ hash: hash }) do
    @cart_repository.get_info(hash)
  end

  def call(_params), do: { :error, "Invalid parameters" }
end
