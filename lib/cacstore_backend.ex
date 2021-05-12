defmodule Cacstore do
  alias Cacstore.Domain.Actions.Products.Create, as: CreateProduct
  alias Cacstore.Domain.Actions.Products.Find, as: FindProduct
  alias Cacstore.Domain.Actions.Products.GetAll, as: GetAllProducts
  alias Cacstore.Domain.Actions.Products.Update, as: UpdateProduct
  alias Cacstore.Domain.Actions.Products.Delete, as: DeleteProduct
  @moduledoc """
  Cacstore keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defdelegate create_product(params), to: CreateProduct, as: :call
  defdelegate find_product(params), to: FindProduct, as: :call
  defdelegate get_all_products(), to: GetAllProducts, as: :call
  defdelegate update_product(params), to: UpdateProduct, as: :call
  defdelegate delete_product(params), to: DeleteProduct, as: :call
end
