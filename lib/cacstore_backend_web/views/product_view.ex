defmodule CacstoreWeb.ProductView do
  use CacstoreWeb, :view
  alias Cacstore.Domain.Entities.Product

  def render("product.json", %Product{name: name }) do
    %{
      message: "The product was created",
      data: %{
        name: name
      }
    }
  end
end
