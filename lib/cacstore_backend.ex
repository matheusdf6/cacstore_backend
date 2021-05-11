defmodule Cacstore do
  alias Cacstore.Domain.Actions.Product.Create, as: CreateProduct
  @moduledoc """
  Cacstore keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defdelegate create_product(params), to: CreateProduct, as: :call
end
