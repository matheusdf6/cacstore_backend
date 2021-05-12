defmodule Cacstore.Domain.Actions.Products.GetAll do
  @product_repository Application.get_env(:cacstore_backend, :product_repository)

  def call() do
    @product_repository.get_all()
  end
end
